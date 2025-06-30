<?php
namespace App\Http\Controllers;

use App\Models\ResourceProfileDesignCategory;
use App\Models\ResourceProfilefont;
use App\Models\ResourceProfilesetting;
use App\Traits\ApiResponseTrait;

class CvDesignController extends Controller
{
    use ApiResponseTrait;

    //Fetch Active Designs, Fonts, and Colors
    public function allCvDesgin()
    {
        // $designs = ResourceProfileDesignCategory::with(['resourceProfileDesigns' => function ($query) {
        //     $query->get()->each(function ($design) {
        //         $design->sectionOrder = json_decode($design->sectionOrder, true);
        //     });
        // }])->where('status', 1)->get();

        $categories = ResourceProfileDesignCategory::with('resourceProfileDesigns')->where('status', 1)->get();

        foreach ($categories as $category) {
            foreach ($category->resourceProfileDesigns as $design) {
                $decoded = json_decode($design->sectionOrder, true);

                if (is_array($decoded) && isset($decoded[0]) && is_array($decoded[0])) {
                    $flattened            = collect($decoded)->flatten()->values()->toArray();
                    $design->sectionOrder = json_encode($flattened);

                    if (! empty($design->id)) {
                        $design->save();
                    }
                }
            }
        }
        $fonts  = ResourceProfilefont::where('status', 1)->get();
        $colors = ResourceProfilesetting::where('status', 1)->get();
        return $this->successResponse(
            [
                'designs' => $categories,
                'fonts'   => $fonts,
                'colors'  => $colors,
            ],
            'Designs, Fonts, and Colors fetched successfully!',
        );
    }
}
