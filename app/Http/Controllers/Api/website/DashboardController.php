<?php

namespace App\Http\Controllers\Api\Website;

use App\Http\Controllers\Controller;
use App\Traits\ApiResponseTrait;
use Illuminate\Http\Request;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class DashboardController extends Controller
{
    use ApiResponseTrait;
    use \App\Traits\CryptHelper;
    public function dashboard(Request $request)
    {
        try {
            $userId = auth()->id();

            // 1. Fetch Designs
            $designs = DB::table('resource_profile_design_categories as c')
                ->join('resource-profiledesign as d', 'c.id', '=', 'd.categoryid')
                ->select(
                    'c.id',
                    'c.title',
                    'c.description',
                    'd.design_image',
                    'c.id as category_id'
                )
                ->where('c.status', 1)
                ->where('d.status', 1)

                ->orderBy('d.downloadTimes', 'desc')
                ->limit(9)
                ->get();

            $careerImages = DB::table('enhance_career_image')
                ->where('status', 1)
                ->where('category', 'homepage')
                ->where('sub_category', 'dashboard')
                ->where('status',1)

                ->get();

            $cvCount = DB::table('create-cvprofile')
                ->where('id', $userId)
                ->where('status',1)

                ->count();

            $userBasic = DB::table('user-basic')
            ->select('profile_type','wizardWorkExp','wizardEducationProfile','wizardWorkProfile','wizardEducationSpecialization','wizardWorkSpecialization')
                ->where('id', $userId)
                ->where('status',1)

                ->first();

            $userCategory = DB::table('users')
                ->join('user_categories', 'users.categoryid', '=', 'user_categories.usercategoryid')
                ->select('users.id', 'users.categoryid', 'user_categories.category as category_name')
                ->where('users.id', $userId)
                ->where('status',1)

                ->first();
                $subscriptionCount = DB::table('user-subscription')
                ->where('user_id', $userId)
                ->where('status',1)
                ->count();
            return $this->successResponse([
                'designs'       => $designs,
                'career_images' => $careerImages,
                'cv_count'      => $cvCount,
                'subscription_count'=> $subscriptionCount,
                'user_basic'    => $userBasic,
                'user_category' => $userCategory,
            ], 'Dashboard data fetched successfully!');

        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong! ' . $e->getMessage(), 500);
        }
    }

}
