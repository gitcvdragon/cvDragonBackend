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
            $rawConfigs = DB::table('cvdragonappconfignew')
                ->where('status', 1)
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
