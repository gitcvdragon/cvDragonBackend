<?php
namespace App\Http\Controllers;

use App\Models\ResourceProfilefont;
use App\Models\ResourceProfilesetting;
use App\Traits\ApiResponseTrait;
use Illuminate\Support\Facades\DB;

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

        $designs = DB::select("
        SELECT d.designid, d.sectionOrder
        FROM  `resource-profiledesign` d
        JOIN resource_profile_design_categories c ON d.category_id = c.id
        WHERE c.status = 1
    ");

        $flattenedDesigns = collect();

        foreach ($designs as $design) {
            $decoded = json_decode($design->sectionOrder, true);

            if (is_array($decoded)) {
                if (isset($decoded[0]) && is_array($decoded[0])) {
                    $flattened = collect($decoded)->flatten()->values()->toArray();
                } else {
                    $flattened = $decoded; // already flat
                }

                $flattenedDesigns->push([
                    'id'           => $design->designid,
                    'sectionOrder' => $flattened,
                ]);
            }
        }
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
