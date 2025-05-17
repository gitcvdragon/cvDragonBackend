<?php

namespace App\Http\Controllers;

use App\Models\{ResourceProfileColor, ResourceProfileDesignCategory, ResourceProfilefont};
use App\Traits\ApiResponseTrait;
use Illuminate\Http\Request;

class CvDesignController extends Controller
{
    use ApiResponseTrait;

    //Fetch Active Designs, Fonts, and Colors
    public function allDesigns()
    {
        $designs = ResourceProfileDesignCategory::with('resourceProfileDesigns')
            ->where('status', 1)
            // ->where('app', 1)
            // ->where('version', 'like', '%7%')
            ->get();
        $fonts = ResourceProfilefont::where('status', 1)->get();
        $colors = ResourceProfileColor::where('status', 1)->get();
        return $this->successResponse(
            [
                'designs' => $designs,
                'fonts' => $fonts,
                'colors' => $colors,
            ],
            'Designs, Fonts, and Colors fetched successfully!',
        );
    }
}
