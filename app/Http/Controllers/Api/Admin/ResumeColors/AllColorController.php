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
            'color1', 'color2', 'color3', 'color4',
            'downloadTimes as timesUsed',
            DB::raw("CASE WHEN status = 1 THEN 'Active' ELSE 'Inactive' END as status")
        )
        ->get()
        ->map(function ($item) {
            // Build array in PHP, not SQL
            $item->colorSwatches = [
                $item->color1,
                $item->color2,
                $item->color3,
                $item->color4
            ];

            // Remove raw DB columns
            unset($item->color1, $item->color2, $item->color3, $item->color4);

            return $item;
        });

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
            'color1',
            'color2',
            'color3',
            'color4',
            'downloadTimes as timesUsed',
            'content as description',
            DB::raw("CASE WHEN status = 1 THEN 'Active' ELSE 'Inactive' END as status")
        )
        ->where('settingid', $id)
        ->first();

    if ($colour) {
        $colour->colorSwatches = [
            $colour->color1,
            $colour->color2,
            $colour->color3,
            $colour->color4,
        ];
        unset($colour->color1, $colour->color2, $colour->color3, $colour->color4);
    }


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
