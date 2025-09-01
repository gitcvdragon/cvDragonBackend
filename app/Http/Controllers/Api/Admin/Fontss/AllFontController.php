<?php

namespace App\Http\Controllers\Api\Admin\Fontss;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class AllFontController extends Controller
{
    public function index(Request $request)
    {

        $limit  = $request->input('limit', 10);   // default 10
        $offset = $request->input('offset', 0);   // default 0
        $fonts = DB::table('resource-profilefont')
            ->select(
                'fontid as id',
                'fontTypeName as schemeName',
                'googleFontName as fontFamily',
                'downloadTime as timesUsed',
                DB::raw("CASE WHEN status = 1 THEN 'Active' ELSE 'Inactive' END as status")
            )
            ->offset($offset)
            ->limit($limit)
            ->get();

        return response()->json([
            'fonts' => $fonts
        ]);
    }

    public function show($id)
    {
        $font = DB::table('resource-profilefont')
            ->select(
                'fontid as id',
                'fontTypeName as schemeName',
                'googleFontName as fontFamily',
                'downloadTime as timesUsed',
                DB::raw("CASE WHEN status = 1 THEN 'Active' ELSE 'Inactive' END as status")
            )
            ->where('fontid', $id)
            ->first();

        if (!$font) {
            return response()->json(['message' => 'Font not found'], 404);
        }

        // add preview text
        $font->previewText = "The quick brown fox jumps over the lazy dog";

        return response()->json($font);
    }

    public function store(Request $request)
    {
        $id = DB::table('resource-profilefont')->insertGetId([
            'fontTypeName'  => $request->schemeName,
            'googleFontName'=> $request->fontFamily,
            'downloadTime'  => $request->timesUsed ?? 0,
            'status'        => $request->status === 'Active' ? 1 : 0,
        ]);

        return response()->json([
            'id' => $id,
            'message' => 'Font created successfully'
        ]);
    }

    public function update(Request $request, $id)
    {
        DB::table('resource-profilefont')
            ->where('fontid', $id)
            ->update([
                'fontTypeName'  => $request->schemeName,
                'googleFontName'=> $request->fontFamily,
                'downloadTime'  => $request->timesUsed,
                'status'        => $request->status === 'Active' ? 1 : 0,
            ]);

        return response()->json([
            'id' => $id,
            'message' => 'Font updated successfully'
        ]);
    }

    public function destroy($id)
    {
        DB::table('resource-profilefont')
            ->where('fontid', $id)
            ->delete();

        return response()->json([
            'id' => $id,
            'message' => 'Font deleted successfully'
        ]);
    }
}
