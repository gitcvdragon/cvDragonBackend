<?php

namespace App\Http\Controllers\Api\website;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;

class AllTemplateswithCategory extends Controller
{
    public function getAllTemplatesWithCategory()
    {
        $categories = DB::table('resource_profile_design_categories')
            ->where('status', 1)
            ->get();

        foreach ($categories as $category) {
            $designs = DB::table('resource-profiledesign')
                ->where('categoryid', $category->id)
                ->where('status', 1)
                ->get()
                ->map(function ($design) {
                    // Convert sectionOrder JSON string into array
                    if (!empty($design->sectionOrder)) {
                        $design->sectionOrder = json_decode($design->sectionOrder, true);
                    } else {
                        $design->sectionOrder = [];
                    }
                    return $design;
                });

            $category->designs = $designs;
        }

        return $this->successResponse([
            'categories' => $categories
        ], 'All Data Fetched!!');
    }
}

