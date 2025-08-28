<?php

namespace App\Http\Controllers\Api\Admin\Templates;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
class TemplatesFetchController extends Controller
{
    public function index()
    {
        $templates = DB::table('resource-profiledesign as d')
            ->leftJoin('resource_profile_design_categories as c', 'd.categoryid', '=', 'c.id')
            ->select(
                'd.designid as id',
                'd.designName as schemeName',
                DB::raw("JSON_ARRAY(d.color1, d.color2, d.color3, d.color4) as colorSwatches"),
                'd.downloadTimes as timesUsed',
                DB::raw("CONCAT('$', d.basevalue) as price"),
                'c.title as category',
                DB::raw("CASE WHEN d.status = 1 THEN 'Active' ELSE 'Inactive' END as status")
            )
            ->get();

        return response()->json([
            'templates' => $templates
        ]);
    }

    public function show($id)
    {
        $template = DB::table('resource-profiledesign as d')
            ->leftJoin('resource_profile_design_categories as c', 'd.categoryid', '=', 'c.id')
            ->select(
                'd.designid as id',
                'd.designName as schemeName',
                'c.title as category',
                'd.downloadTimes as timesUsed',
                DB::raw("CONCAT('$', d.basevalue) as price"),
                DB::raw("CASE WHEN d.status = 1 THEN 'Active' ELSE 'Inactive' END as status"),
                'd.design_image as previewImageUrl'
            )
            ->where('d.designid', $id)
            ->first();

        return response()->json($template);
    }

    public function store(Request $request)
    {
        $id = DB::table('resource-profiledesign')->insertGetId([
            'designName'   => $request->schemeName,
            'color1'       => $request->colorSwatches[0] ?? null,
            'color2'       => $request->colorSwatches[1] ?? null,
            'color3'       => $request->colorSwatches[2] ?? null,
            'color4'       => $request->colorSwatches[3] ?? null,
            'basevalue'    => (float) str_replace('$', '', $request->price),
            'categoryid'   => $request->category,
            'status'       => $request->status === 'Active' ? 1 : 0,
            'design_image' => $request->previewImageUrl,
            'lastUpdated'  => now(),
        ]);

        return response()->json([
            'templateId' => $id,
            'message' => 'Template created successfully'
        ]);
    }

    public function update(Request $request, $id)
    {
        DB::table('resource-profiledesign')
            ->where('designid', $id)
            ->update([
                'designName'   => $request->schemeName,
                'color1'       => $request->colorSwatches[0] ?? null,
                'color2'       => $request->colorSwatches[1] ?? null,
                'color3'       => $request->colorSwatches[2] ?? null,
                'color4'       => $request->colorSwatches[3] ?? null,
                'basevalue'    => (float) str_replace('$', '', $request->price),
                'status'       => $request->status === 'Active' ? 1 : 0,
                'design_image' => $request->previewImageUrl,
                'lastUpdated'  => now(),
            ]);

        return response()->json([
            'templateId' => $id,
            'message' => 'Template updated successfully'
        ]);
    }

    public function destroy($id)
    {
        DB::table('resource-profiledesign')
            ->where('designid', $id)
            ->delete();

        return response()->json([
            'templateId' => $id,
            'message' => 'Template deleted successfully'
        ]);
    }
}
