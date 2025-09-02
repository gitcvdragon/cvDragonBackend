<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Carbon;
use App\Traits\ApiResponseTrait;

class AppConfigController extends Controller
{
    use  ApiResponseTrait;


    public function getConfig(Request $request)
    {
        $id = $request->query('id');
        $authkey = $request->query('authkey');
        $data = $request->query('data');
        $publickey = 'cvDragonPublicKey54321';
        $date = Carbon::now();

        if (!$id || !$authkey) {
            return $this->errorResponse('Missing id or authkey', 400);
        }

        if ($this->userCheck($id, $authkey) || $authkey === $publickey) {
            if ($data === 'appConfig') {
                $configs = DB::table('cvDragonAppConfigNew')->select('configkey', 'configvalue', 'configvalueios', 'parameter')->where('version', 15)->where('sendData', 1)->get();

                $configArray = $configs->toArray();

                // Append server time
                $serverTime = [
                    'configkey' => 'SERVERTIME',
                    'configvalue' => '1',
                    'configvalueios' => '1',
                    'parameter' => Carbon::now()->toIso8601String(),
                ];

                $configArray[] = $serverTime;

                return $this->successResponse($configArray, 'App config fetched successfully!!');
            }

            return $this->errorResponse('Invalid data parameter', 400);
        }

        return $this->errorResponse('Unauthorized access', 401);
    }

    private function userCheck($id, $authkey)
    {
        return DB::table('users')->where('id', $id)->where('authkey', $authkey)->exists();
    }

    public function getActiveConfigs(Request $request)
    {
        try {
            $userId = auth()->id();

    if (! $userId) {
        return response()->json([
            'status'  => 'error',
            'message' => 'User not authenticated',
        ], 401);
    }

    // Fetch categoryid for this user
    $category = DB::table('users')
        ->where('id', $userId)
        ->value('categoryid');


            if (!$category) {
                return $this->errorResponse('Missing category ', 400);
            }
            $rawConfigs = DB::table('resource-appconfig-user')
                ->where('status', 1)
                ->where('user_category', $category)
                ->get();

            $configs = $rawConfigs->map(function ($config) {
                $decodedParam = json_decode($config->parameter, true);
                $config->parameter = $decodedParam ?: $config->parameter;
                return $config;
            });

            return $this->successResponse(
                ['data' => $configs],
                'All Data Fetched!!'
            );

        } catch (\Exception $e) {
            return $this->errorResponse('An error occurred: ' . $e->getMessage(), 500);

        }
    }


}
