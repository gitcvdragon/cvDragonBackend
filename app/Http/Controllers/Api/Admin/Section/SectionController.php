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
                            'sectionId' => (string) $section->id,
                            'order'     => $row->orderSection,
                            'title'     => $row->sectionName,
                            'icon'      => $row->sectionImage,
                            'color'     => $section->color, // ✅ correct color source
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
}
