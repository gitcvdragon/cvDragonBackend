<?php

namespace App\Http\Controllers;

use App\Models\Course;
use App\Models\ResourceCarrer;
use App\Models\Specialization;
use Illuminate\Http\Request;
use App\Traits\ApiResponseTrait;
use Illuminate\Support\Facades\Validator;

class CvCommonController extends Controller
{
    use ApiResponseTrait;

    //This function retrieves all records from the ResourceCarrer model and returns them in a structured success response with a message indicating the list of career resources.
    public function getResourceCarrer()
    {
        $resource = ResourceCarrer::get();

        return $this->successResponse(
            [
                'resource' => $resource,
            ],
            'Resource Carrer List',
        );
    }

    //This API returns a set of input fields based on the user's experience background. Depending on whether the user is a student, fresher, experienced professional, or restarting their career, relevant fields such as course, specialization, industry, or job profile are returned to guide the next steps in their journey.
    public function getFieldsByExperience(Request $request)
    {
        $validator = Validator::make(
            $request->all(),
            [
                'experience_brife' => 'required|in:1,2,3,4,5',
            ],
            [
                'experience_brife.required' => 'Please provide your experience background.',
                'experience_brife.in' => 'Invalid experience option selected.',
            ],
        );

        if ($validator->fails()) {
            return response()->json(
                [
                    'status' => false,
                    'message' => 'Validation failed.',
                    'errors' => $validator->errors(),
                ],
                422,
            );
        }

        $experienceOptions = [
            1 => 'student',
            2 => 'fresher',
            3 => 'experience',
            4 => 'women restarting career',
            5 => 'prefer not to say',
        ];

        $experience = $experienceOptions[$request->experience_brife];
        $fields = [];

        if (in_array($experience, ['student', 'fresher'])) {
            $fields = [['name' => 'course', 'type' => 'select', 'label' => 'Select your course'], ['name' => 'specialization', 'type' => 'select', 'label' => 'Select your specialization']];
        } elseif (in_array($experience, ['experience', 'women restarting career'])) {
            $fields = [['name' => 'industry', 'type' => 'select', 'label' => 'Select your industry'], ['name' => 'profile', 'type' => 'select', 'label' => 'Select your profile']];
        }

        return response()->json([
            'status' => true,
            'message' => 'Fields loaded successfully.',
            'data' => [
                'fields' => $fields,
            ],
        ]);
    }

    //Fetches all resource career categories along with their associated courses.
    public function getAllResourceCarrersWithCourses()
    {
        $data = ResourceCarrer::with(['courses'])->get();

        return response()->json([
            'status' => true,
            'message' => 'Resource Carrers with Courses fetched successfully.',
            'data' => $data,
        ]);
    }

    //Retrieves a list of all courses and their related specializations.
    public function getAllCoursesWithSpecs()
    {
        $data = Course::with(['specializations'])->get();

        return response()->json([
            'status' => true,
            'message' => 'Course with Specializations fetched successfully.',
            'data' => $data,
        ]);
    }

    //Returns all resource careers, each with their courses and the respective specializations for each course.
    public function getAllResourceCarrersWithCoursesandSpecs()
    {
        $data = ResourceCarrer::with(['courses.specializations'])->get();

        return response()->json([
            'status' => true,
            'message' => 'Resource Carrers with Courses and Specializations fetched successfully.',
            'data' => $data,
        ]);
    }

    public function getSkillsBySpecialization(Request $request)
    {
        $validator = Validator::make(
            $request->all(),
            [
                'specialization_id' => 'required|exists:specializations,id',
            ],
            [
                'specialization_id.required' => 'Specialization ID is required.',
                'specialization_id.exists' => 'The selected specialization does not exist.',
            ],
        );

        if ($validator->fails()) {
            return response()->json(
                [
                    'status' => false,
                    'message' => 'Validation failed.',
                    'errors' => $validator->errors(),
                ],
                422,
            );
        }

        $specialization = Specialization::with([
            'skills' => function ($q) {
                $q->where('status', 1);
            },
            'technicalSkills' => function ($q) {
                $q->where('status', 1);
            },
            'languages' => function ($q) {
                $q->where('status', 1);
            },
            'interests' => function ($q) {
                $q->where('status', 1);
            },
        ])->find($request->specialization_id);

        return response()->json([
            'status' => true,
            'message' => 'Skills fetched successfully.',
            'data' => [
                'skills' => $specialization->skills,
                'technical_skills' => $specialization->technicalSkills,
                'languages' => $specialization->languages,
                'interests' => $specialization->interests,
            ],
        ]);
    }
}
