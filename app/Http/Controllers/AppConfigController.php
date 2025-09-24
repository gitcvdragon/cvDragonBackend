<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Carbon;
use App\Traits\ApiResponseTrait;
use Illuminate\Support\Facades\Validator;
class AppConfigController extends Controller
{
    use  ApiResponseTrait;



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
           // ->select('parameter','configid')
                ->where('status', 1)
                ->where('user_category', $category)
                ->get();

   $configs = $rawConfigs->map(function ($config) {
    $parameter = $config->parameter;

    $decoded = json_decode($parameter, true);

    if ($decoded === null) {
        $parameter = str_replace(['{', '}'], ['[', ']'], $parameter);

        $parameter = str_replace(['True', 'TRUE', 'False', 'FALSE'], ['true', 'false'], $parameter);

        $decoded = json_decode($parameter, true);

        $config->parameter = $decoded ?: $config->parameter;
    } else {
        $config->parameter = $decoded;
    }

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

    public function getActiveConfigSingle(Request $request)
{
    try {


        // Validate request params
        $validator = Validator::make($request->all(), [
            'configkey' => 'nullable|string|max:255',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Validation failed',
                'errors'  => $validator->errors(),
            ], 422);
        }



        // Build query
        $query = DB::table('resource-appconfig-user')
            ->select(
                'sn',
                'configid',
                'user_category',
                'configkey',
                'changesBeforeUpdate',
                'parameter',
                'sendData',
                'status'
            )
            ->where('status', 1);

        if ($request->filled('configkey')) {
            $query->where('configkey', $request->input('configkey'));
        }

        $rawConfigs = $query->get();

        // Decode parameter JSON safely
        $configs = $rawConfigs->map(function ($config) {
            $decoded = json_decode($config->parameter, true);

            if ($decoded === null) {
                $parameter = str_replace(['{', '}'], ['[', ']'], $config->parameter);
                $parameter = str_replace(['True', 'TRUE', 'False', 'FALSE'], ['true', 'false'], $parameter);

                $decoded = json_decode($parameter, true);
                $config->parameter = $decoded ?: $config->parameter;
            } else {
                $config->parameter = $decoded;
            }

            return $config;
        });

        // If only one record, return object instead of array
        $result = $configs->count() === 1 ? $configs->first() : $configs;

        return $this->successResponse(
            ['data' => $result],
            'All Data Fetched!!'
        );

    } catch (\Exception $e) {
        return $this->errorResponse('An error occurred: ' . $e->getMessage(), 500);
    }
}


}
