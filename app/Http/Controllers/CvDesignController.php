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
SELECT d.*, c.status AS category_status
FROM `resource-profiledesign` d
JOIN resource_profile_design_categories c ON d.categoryid = c.id
WHERE c.status = 1
");

$flattenedDesigns = [];

foreach ($designs as $design) {
    $row = (array) $design;

    // Force decode JSON fields
    foreach (['sectionOrder', 'sectionDefault', 'version'] as $field) {
        if (!empty($row[$field])) {
            $decoded = json_decode($row[$field], true);

            // Fallback to empty array if decoding fails
            $row[$field] = is_array($decoded) ? $decoded : [];
        } else {
            $row[$field] = [];
        }
    }

    $flattenedDesigns[] = $row;
}

        $fonts  = ResourceProfilefont::where('status', 1)->get();
        $colors = ResourceProfilesetting::where('status', 1)->get();
        return $this->successResponse(
            [
                'designs' => $flattenedDesigns,
                'fonts'   => $fonts,
                'colors'  => $colors,
            ],
            'Designs, Fonts, and Colors fetched successfully!',
        );
    }
}
