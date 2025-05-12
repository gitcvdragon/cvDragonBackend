<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Carbon;

class AppConfigController extends Controller
{
     public function getConfig(Request $request)
    {
        $id = $request->query('id');
        $authkey = $request->query('authkey');
        $data = $request->query('data');
        $publicKey = 'cvDragonPublicKey54321'; // Optionally move to env
        $date = Carbon::now();

        if (!$id) {
            return response()->json(['error' => 'Missing id'], 400);
        }

        if (!$authkey) {
            return response()->json(['error' => 'Missing authkey'], 400);
        }

        if (!$this->userCheck($id, $authkey) && $authkey !== $publicKey) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        if ($data === 'appConfig') {
            $configs = DB::table('cvDragonAppConfigNew')
                ->select('configkey', 'configvalue', 'configvalueios', 'parameter')
                ->where('version', 15)
                ->where('sendData', 1)
                ->get()
                ->toArray();

            // Add server time config
            $configs[] = [
                'configkey'      => 'SERVERTIME',
                'configvalue'    => '1',
                'configvalueios' => '1',
                'parameter'      => $date->toIso8601String(),
            ];

            return response()->json($configs);
        }

        return response()->json(['error' => 'Invalid data request'], 400);
    }

    private function userCheck($id, $authkey)
    {
        return DB::table('users')
            ->where('id', $id)
            ->where('authkey', $authkey)
            ->exists();
    }
}
