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
        SELECT d.id, d.sectionOrder
        FROM resource_profile_designs d
        JOIN resource_profile_design_categories c ON d.category_id = c.id
        WHERE c.status = 1
    ");

        foreach ($designs as $design) {
            $decoded = json_decode($design->sectionOrder, true);

            if (is_array($decoded) && isset($decoded[0]) && is_array($decoded[0])) {
                $flattened = collect($decoded)->flatten()->values()->toArray();
                $json      = json_encode($flattened);

                DB::update("UPDATE resource_profile_designs SET sectionOrder = ? WHERE id = ?", [
                    $json,
                    $design->id,
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
