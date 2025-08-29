<?php

namespace App\Http\Controllers\Api\Admin\ResumeColors;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
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
        // Validate request
        $validator = Validator::make($request->all(), [
            'schemeName'      => 'required|string|max:100',  // matches DB column size
            'heading'         => 'nullable|string|max:10',   // matches DB column size
            'content'         => 'nullable|string',          // text column
            'colorSwatches'   => 'array|max:4',
            'colorSwatches.*' => 'nullable|string|max:10',   // color1–color4 are varchar(10)
            'status'          => 'required|in:Active,Inactive',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors'  => $validator->errors(),
            ], 422);
        }

        $validated = $validator->validated();

        // Update record
        DB::table('resource-profilesetting')
            ->where('settingid', $id)
            ->update([
                'name'    => $validated['schemeName'],
                'heading' => $validated['heading'] ?? null,
                'content' => $validated['content'] ?? null,
                'color1'  => $validated['colorSwatches'][0] ?? null,
                'color2'  => $validated['colorSwatches'][1] ?? null,
                'color3'  => $validated['colorSwatches'][2] ?? null,
                'color4'  => $validated['colorSwatches'][3] ?? null,
                'status'  => $validated['status'] === 'Active' ? 1 : 0,
            ]);

        return response()->json([
            'success'  => true,
            'colorId'  => $id,
            'message'  => 'Colour scheme updated successfully',
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

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'schemeName'      => 'required|string|max:100', // DB column `name` is varchar(100)
            'heading'         => 'nullable|string|max:100',  // DB column heading varchar(10)
            'content'         => 'nullable|string',         // DB column content (text)
            'colorSwatches'   => 'array|max:4',
            'colorSwatches.*' => 'nullable|string|max:100',
            'status'          => 'required|in:Active,Inactive',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors'  => $validator->errors(),
            ], 422);
        }

        $validated = $validator->validated();

        // Insert into DB
        $id = DB::table('resource-profilesetting')->insertGetId([
            'name'          => $validated['schemeName'],
            'heading'       => $validated['heading'] ?? null,
            'content'       => $validated['content'] ?? null,
            'color1'        => $validated['colorSwatches'][0] ?? null,
            'color2'        => $validated['colorSwatches'][1] ?? null,
            'color3'        => $validated['colorSwatches'][2] ?? null,
            'color4'        => $validated['colorSwatches'][3] ?? null,
            'status'        => $validated['status'] === 'Active' ? 1 : 0,
            'downloadTimes' => 0,
        ]);

        return response()->json([
            'templateId' => $id,
            'message'    => 'Template created successfully',
        ], 201);
    }


}
