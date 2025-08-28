<?php

namespace App\Http\Controllers\Api\Admin\ResumeColors;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class AllColorController extends Controller
{
    public function index()
    {
        $colours = DB::table('resource-profilesetting')
            ->select(
                'settingid as colorId',
                'name as schemeName',
                DB::raw("JSON_ARRAY(color1, color2, color3, color4) as colorSwatches"),
                'downloadTimes as timesUsed',
                DB::raw("CASE WHEN status = 1 THEN 'Active' ELSE 'Inactive' END as status")
            )
            ->get();

        return response()->json([
            'colours' => $colours
        ]);
    }

    public function show($id)
    {
        $colour = DB::table('resource-profilesetting')
            ->select(
                'settingid as colorId',
                'name as schemeName',
                DB::raw("JSON_ARRAY(color1, color2, color3, color4) as colorSwatches"),
                'downloadTimes as timesUsed',
                'content as description',
                DB::raw("CASE WHEN status = 1 THEN 'Active' ELSE 'Inactive' END as status")
            )
            ->where('settingid', $id)
            ->first();

        return response()->json($colour);
    }

    public function update(Request $request, $id)
    {
        DB::table('resource-profilesetting')
            ->where('settingid', $id)
            ->update([
                'name'   => $request->schemeName,
                'color1' => $request->colorSwatches[0] ?? null,
                'color2' => $request->colorSwatches[1] ?? null,
                'color3' => $request->colorSwatches[2] ?? null,
                'color4' => $request->colorSwatches[3] ?? null,
                'status' => $request->status === 'Active' ? 1 : 0,
            ]);

        return response()->json([
            'colorId' => $id,
            'message' => 'Colour scheme updated successfully'
        ]);
    }

    public function destroy($id)
    {
        DB::table('resource-profilesetting')
            ->where('settingid', $id)
            ->delete();

        return response()->json([
            'colorId' => $id,
            'message' => 'Colour scheme deleted successfully'
        ]);
    }
}
