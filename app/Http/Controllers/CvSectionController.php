<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\{MasterCvSection, ResourceSection};
use App\Traits\ApiResponseTrait;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class CvSectionController extends Controller
{

    use ApiResponseTrait;

    //Fetch CV Section Groups with Their Sections::Returns all master CV section groups along with their associated resource sections.
    public function getGroupSections()
    {
        $sections = MasterCvSection::with('resourceSections')->get();
        return $this->successResponse(
            [
                'data' => $sections,
            ],
            'Groups and sections are fetched successfully!!',
        );
    }

    // Fetch Section Questions::Retrieves a specific resource section by ID along with all its related section questions and their dependent questions (if any). Ensures the section exists and returns a structured JSON response with validation and success status.
    public function getSectionQuestions(Request $request)
    {
        $validator = Validator::make(
            $request->all(),
            [
                'id' => 'required|exists:resource-section,id',
            ],
            [
                'id.required' => 'Section ID is required.',
                'id.exists' => 'The selected section does not exist.',
            ],
        );

        if ($validator->fails()) {
            return response()->json(
                [
                    'status' => false,
                    'message' => 'Validation failed.',
                    'errors' => $validator->errors()->first(),
                ],
                422,
            );
        }

        $section = ResourceSection::with('sectionQuestions.dependentQuestions')->findOrFail($request->id);
        return $this->successResponse(
            [
                'data' => $section,
            ],
            'Section and Questions are fetched successfully!!',
        );
    }

    public function allSectionsBasic()
    {
        $sections = ResourceSection::select(['section', 'defaultSection', 'sectionContentApp', 'sectionDefaultContent', 'orderSection as sectionName'])
            ->where('main', 1)
            ->where('status', 1)
            ->get();

        return $this->successResponse(
            [
                'data' => $sections,
            ],
            'All Basic Sections are fetched successfully!!',
        );
    }

    public function allSectionTabs(Request $request)
    {
        $request->validate([
            'tabType' => 'required|string',
        ]);

        $tabType = $request->input('tabType');

        $sections = ResourceSection::select(['id as categoryID', 'sectionName', 'idColumnName as postType'])
            ->where('main', 3)
            ->where('sectionTable', $tabType)
            ->where('status', 1)
            ->get();

        return $this->successResponse(
            [
                'data' => $sections,
            ],
            'All Sections Tabs are fetched successfully!!',
        );
    }

    public function getUserSectionDetails(Request $request)
    {
        $allSectionData = [];
        $text = "";
        $id = $request->input('id');
        
        // Helper to process descriptions and titles
        $appendText = function ($items, $fields) use (&$text) {
            foreach ($items as $item) {
                foreach ($fields as $field) {
                    if (isset($item->$field)) {
                        $text .= $item->$field . " ";
                    }
                }
            }
        };

        // 1. Basic Info
        $allSectionData['basic_info'] = DB::table('cv-basic-info')
            ->where('id', $id)
            ->where('status', 1)
            ->first();

        // Contact Details
        $allSectionData['contact_details'] = DB::table('cv-contact')
            ->where('id', $id)
            ->where('status', 1)
            ->first();

        $allSectionData['social_links'] = DB::table('cv_social_links')
            ->where('user_id', $id)
            ->where('status', 1)
            ->first();
            
        // 2. Introduction
        $introduction = DB::table('cv-introduction')
            ->select('id', 'title','introduction')
            ->where('id', $id)
            ->where('status', 1)
            ->first();

        $allSectionData['introduction'] = $introduction;

        //Sections with multiple records
        $sections = [
            'projects' => ['cv-project', ['projectid', 'description']],
            'academic_projects' => ['cv-academic-projects', ['academicid', 'description']],
            'poa' => ['cv-POA', ['poaid', 'description']],
            'co_curricular' => ['cv-co-curricular-activities', ['activityid', 'title', 'description']],
            'presentations' => ['cv-presentations', ['activityid', 'title', 'description']],
            'internships' => ['cv-internship', ['internshipid', 'description']],
            'trainings' => ['cv-trainings', ['trainingid', 'description']],
            'technical_skills' => ['cv-technical', ['technicalid', 'technical', 'type', 'level', 'description']],
            'publications' => ['cv-publications', ['publishid', 'title', 'publisher', 'description']],
            'achievements' => ['cv-achievements', ['achieveid', 'achievement', 'description']],
            'associations' => ['cv-association', ['associationid', 'description']],
            'volunteer' => ['cv-volunteer', ['volunteerid', 'description']],
            'skills' => ['cv-skills', ['skillid', 'skill', 'description']],
            'interests' => ['cv-interests', ['interestid', 'interest', 'level']],
            'languages' => ['cv-languages', ['langid', 'language']],
            'images' => ['cv-images', ['imageid', 'image', 'status']],
            'preferences' => ['cv-preference', ['prefid', 'noticePeriod', 'expectedCTC']],
            'education' => ['cv-education', ['eduid', 'category', 'specialization']],
            'work_experience' => ['cv-work', ['workid', 'organization', 'designation']],
            'patent' => ['cv-patent', ['patentid', 'patentOffice', 'patentStatus']],
        ];

        foreach ($sections as $key => [$table, $fields]) {
            $query = DB::table($table)
                ->where('id', $id)
                ->where('status', 1)
                ->orderBy('created', 'desc');

        //     // Specific sort fields
            if ($table === 'cv-trainings') $query->orderBy('number', 'desc');
            if ($table === 'cv-achievements') $query->orderBy('year', 'desc');
            if (in_array($table, ['cv-association', 'cv-volunteer'])) $query->orderBy('dateJoining', 'desc');
            if ($table === 'cv-publications') $query->orderBy('publishDate', 'desc');

            $data = $query->get();
            $allSectionData[$key] = $data;
            $appendText($data, $fields);
        }

        return $this->successResponse(
            [
                'data' => $allSectionData,
            ],
            'All Sections Tabs are fetched successfully!!'
        );
    }

}
