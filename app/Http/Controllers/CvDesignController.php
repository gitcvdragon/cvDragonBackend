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
        $designs = ResourceProfileDesignCategory::with(['resourceProfileDesigns' => function ($query) {
            $query->get()->each(function ($design) {
                $design->sectionOrder = json_decode($design->sectionOrder, true);
            });
        }])->where('status', 1)->get();

        $fonts  = ResourceProfilefont::where('status', 1)->get();
        $colors = ResourceProfilesetting::where('status', 1)->get();
        return $this->successResponse(
            [
                'designs' => $designs,
                'fonts'   => $fonts,
                'colors'  => $colors,
            ],
            'Designs, Fonts, and Colors fetched successfully!',
        );
    }
}
