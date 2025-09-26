<?php

namespace App\Http\Controllers\Api\website\Onboading;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Traits\ApiResponseTrait;
use Illuminate\Support\Facades\Validator;
class OnboadingController extends Controller
{
    use ApiResponseTrait;

    // Fetch courses with limit & offset
    public function getCourses(Request $request)
    {
        try {
            $limit = $request->input('limit', 10);
            $offset = $request->input('offset', 0);

            $courses = DB::table('courses')
                ->where('status', 1)
                ->select('title as name','sn')
                ->skip($offset)
                ->take($limit)
                ->get();

            return $this->successResponse([
                'courses' => $courses,
                'limit' => $limit,
                'offset' => $offset
            ], 'Courses fetched successfully!');
        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong! ' . $e->getMessage(), 500);
        }
    }

    // Fetch specializations by course_id with limit & offset
    public function getSpecializations(Request $request)
    {
        try {
            $request->validate([
                'course_id' => 'required|integer|exists:courses,id'
            ]);

            $limit = $request->input('limit', 10);
            $offset = $request->input('offset', 0);

            $specializations = DB::table('specializations')
                ->where('status', 1)
                ->where('course_id', $request->course_id)
                ->select('title as name','sn')
                ->skip($offset)
                ->take($limit)
                ->get();

            return $this->successResponse([
                'specializations' => $specializations,
                'limit' => $limit,
                'offset' => $offset
            ], 'Specializations fetched successfully!');
        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong! ' . $e->getMessage(), 500);
        }
    }
    public function getInterests(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'specialization_id' => 'required|integer|exists:specializations,id',
            'limit' => 'nullable|integer|min:1',
            'offset' => 'nullable|integer|min:0',
        ]);

        if ($validator->fails()) {
            return $this->errorResponse(
                $validator->errors()->first(),
                422,
                $validator->errors()
            );
        }

        $specializationId = $request->specialization_id;
        $limit = $request->input('limit', 10);
        $offset = $request->input('offset', 0);

        $interestsQuery = DB::table('interests')
            ->where('specialization_id', $specializationId)
            ->where('status', 1)
            ->select('title')
            ->orderBy('id')
            ->skip($offset)
            ->take($limit);

        $interests = $interestsQuery->pluck('title')->toArray();

        return $this->successResponse([
            'specialization_id' => $specializationId,
            'interests' => $interests,
            'limit' => $limit,
            'offset' => $offset,
        ], 'Interests fetched successfully!');
    }
}
