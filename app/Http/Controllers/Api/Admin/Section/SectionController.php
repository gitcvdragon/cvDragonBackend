<?php

namespace App\Http\Controllers\Api\Admin\Section;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class SectionController extends Controller
{
    public function listSections()
    {
        try {
            $sections = DB::table('master_cv_sections as mcs')
                ->where('mcs.status', 1)
                ->orderBy('mcs.ordering', 'asc')
                ->get();

            $response = [];

            foreach ($sections as $section) {
                $rows = DB::table('resource-section as rs')
                    ->where('rs.master_cv_sections_id', $section->id)
                    ->where('rs.status', 1)
                    ->orderBy('rs.orderSection', 'asc')
                    ->get()
                    ->map(function ($row) use ($section) {
                        return [
                            'id'        => $row->id,
                            'sectionId' => $section->id,
                            'order'     => $row->orderSection,
                            'title'     => $row->sectionName,
                            'icon'      => $row->sectionImage,
                            'color'     => $section->color,
                        ];
                    });

                $response[] = [
                    'id'    => $section->id,
                    'title' => $section->heading,
                    'order' => $section->ordering,
                    'rows'  => $rows,
                ];
            }

            return response()->json([
                'success'  => true,
                'sections' => $response,
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Something went wrong!',
                'error'   => $e->getMessage(),
            ], 500);
        }
    }



    public function viewSection($id)
    {
        try {
            $row = DB::table('resource-section as rs')
                ->join('master_cv_sections as mcs', 'rs.master_cv_sections_id', '=', 'mcs.id')
                ->where('rs.id', $id)
                ->select(
                    'rs.id',
                    'mcs.heading as parentTitle',
                    'rs.sectionName as title',
                    'rs.sectionContent as description',
                    'rs.sectionLink',
                    'rs.idColumnName as sectionId',
                    'rs.sectionTable as tableName',
                    'rs.orderSection as order',
                    'rs.displayParameter as type',
                    'rs.status',
                    'rs.sectionImage as icon'
                )
                ->first();

            if (!$row) {
                return response()->json([
                    'success' => false,
                    'message' => 'Section not found'
                ], 404);
            }

            // format response
            $response = [
                "id"          => $row->id,
                "parentTitle" => $row->parentTitle,
                "title"       => $row->title,
                "description" => $row->description,
                "sectionLink" => $row->sectionLink,
                "sectionId"   => $row->sectionId,
                "tableName"   => $row->tableName,
                "order"       => $row->order,
                "type"        => $row->type,
                "status"      => $row->status == 1 ? "Active" : "Inactive",
                "icon"        => $row->icon,
            ];

            return response()->json($response, 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Something went wrong!',
                'error'   => $e->getMessage(),
            ], 500);
        }
    }
    public function deleteSection($id)
    {
        try {
            $section = DB::table('resource-section')
                ->where('id', $id)
                ->where('status', 1)
                ->first();

            if (!$section) {
                return response()->json([
                    'success' => false,
                    'message' => 'Section not found',
                ], 404);
            }

            DB::table('resource-section')
                ->where('id', $id)
                ->update(['status' => 0]);

            return response()->json([
                'success' => true,
                'message' => 'Section deleted',
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Something went wrong!',
                'error'   => $e->getMessage(),
            ], 500);
        }
    }

}
