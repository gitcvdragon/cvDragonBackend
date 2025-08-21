<?php
namespace App\Http\Controllers\Api\website;

use App\Http\Controllers\Controller;
use App\Traits\ApiResponseTrait;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;

use Illuminate\Support\Facades\Validator;

class PartnerInstitute extends Controller
{
    use ApiResponseTrait;

    public function partnerInstitute(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'category' => 'nullable|string|max:100',
            ]);

            if ($validator->fails()) {
                return $this->errorResponse($validator->errors()->first(), 422);
            }
            $category = $request->input('category') ?? 'patner-institute';

            $institutes = DB::table('resource-marketing-institue-placed')
                ->select('sn', 'institue_name', 'institue_logo', 'created_at')
     ->where([
        ['category', '=', $category],
        ['status', '=', 1],
    ])
    ->orderBy('created_at', 'desc')
    ->limit(5)
    ->get();


            $images = DB::table('enhance_career_image')
                ->select('sn','image')
                ->where([
                    ['category', '=', $category],

                    ['status', '=', 1],
                ])
                ->orderBy('created_at', 'desc')
                ->limit(10)
                ->get();

                $faqs = DB::table('resource_faqs')
                ->select('sn', 'question', 'answer', 'created_at','category', 'sub_category')
                ->where([
                    ['category', '=', $category],

                    ['status', '=', 1],
                ])
                ->orderBy('created_at', 'desc')
                ->limit(5)
                ->get();


            return $this->successResponse([
                'category' => $category,
'images'=> $images,
                'institutes' => $institutes,
                'faqs'       => $faqs,
            ], 'All Services Fetched!!');

        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong! ' . $e->getMessage(), 500);
        }
    }

}
