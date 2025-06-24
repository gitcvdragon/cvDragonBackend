<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class FallbackController extends Controller
{
    public function handle(Request $request)
    {
        $url = $request->fullUrl();

        $method = $request->method();

        $data = $request->all();

        DB::table('api_logs')->insert([
            'url'        => $url,
            'method'     => $method,
            'payload'    => json_encode($data),
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        Log::info('API Fallback called', [
            'url'    => $url,
            'method' => $method,
            'data'   => $data,
        ]);

        return response()->json([
            'status'  => 'success',
            'message' => 'API request stored',
            'url'     => $url,
        ]);
    }

}
