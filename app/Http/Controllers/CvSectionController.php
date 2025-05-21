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
        $text = '';
        $id = $request->input('id');

        // Helper to process descriptions and titles
        $appendText = function ($items, $fields) use (&$text) {
            foreach ($items as $item) {
                foreach ($fields as $field) {
                    if (isset($item->$field)) {
                        $text .= $item->$field . ' ';
                    }
                }
            }
        };

        // 1. Basic Info
        $allSectionData['basic_info'] = DB::table('cv-basic-info')->where('id', $id)->where('status', 1)->first();

        // Contact Details
        $allSectionData['contact_details'] = DB::table('cv-contact')->where('id', $id)->where('status', 1)->first();

        $allSectionData['social_links'] = DB::table('cv_social_links')->where('user_id', $id)->where('status', 1)->first();

        // 2. Introduction
        $introduction = DB::table('cv-introduction')->select('id', 'title', 'introduction')->where('id', $id)->where('status', 1)->first();

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
            'certification' => ['cv-certification', ['certificateid', 'certificate', 'authority']],
        ];

        foreach ($sections as $key => [$table, $fields]) {
            $query = DB::table($table)->where('id', $id)->where('status', 1)->orderBy('created', 'desc');

            //     // Specific sort fields
            if ($table === 'cv-trainings') {
                $query->orderBy('number', 'desc');
            }
            if ($table === 'cv-achievements') {
                $query->orderBy('year', 'desc');
            }
            if (in_array($table, ['cv-association', 'cv-volunteer'])) {
                $query->orderBy('dateJoining', 'desc');
            }
            if ($table === 'cv-publications') {
                $query->orderBy('publishDate', 'desc');
            }

            $data = $query->get();
            $allSectionData[$key] = $data;
            $appendText($data, $fields);
        }

        return $this->successResponse(
            [
                'data' => $allSectionData,
            ],
            'All Sections Tabs are fetched successfully!!',
        );
    }

    public function getUserSectionDetailsAdd(Request $request)
    {
        $user_id = $request->input('user_id');

        $messages = [
            'academic_projects.*.academicid.required_with' => 'academicid is required when updating an academic project. Omit it only when adding a new one.',
        ];

        $validator = Validator::make(
            $request->all(),
            [
                'cvFullName' => 'required|string|max:100',
                'verified' => 'nullable',
                'nationality' => 'required|string|max:50',
                'gender' => 'required|string|in:Male,Female',
                'dateBirth' => 'required|date',
                'maritalStatus' => 'required',
                'location' => 'nullable|string',
                'fullAddress' => 'required|string',
                'introduction' => 'required|string',
                'projects' => 'nullable|array',
                'projects.*.workid' => 'required|integer',
                'projects.*.organization' => 'required|string',
                'projects.*.title' => 'required|string',
                'academic_projects' => 'nullable|array',
                'academic_projects.*.title' => 'required|string',
                'academic_projects.*.description' => 'required|string',
                'academic_projects.*.academicid' => 'nullable|integer|exists:cv-academic-projects,academicid',
            ],
            $messages,
        );

        if ($validator->fails()) {
            return $this->validationErrorResponse($validator->errors()->first(), 'Validation failed');
        }

        try {

            // For UserBasic Table
                $userBasic = DB::table('user-basic')->where('id', $user_id)->first();

                if (!$userBasic) {
                    DB::rollBack();
                    return $this->errorResponse('User not found', 404);
                }

                DB::table('user-basic')
                    ->where('id', $user_id)
                    ->update([
                        'fullName' => $request->input('cvFullName'),
                    ]);

            // For UserBasic Table

            // For UserBasicInfo Table
                $existsBasicInfo = DB::table('cv-basic-info')->where('id', $user_id)->exists();

                if ($existsBasicInfo) 
                {
                    DB::table('cv-basic-info')
                        ->where('id', $user_id)
                        ->update([
                            'cvFullName' => $request->input('cvFullName'),
                            'verified' => $request->input('verified'),
                            'nationality' => $request->input('nationality'),
                            'gender' => $request->input('gender'),
                            'dateBirth' => $request->input('dateBirth'),
                            'maritalStatus' => $request->input('maritalStatus'),
                        ]);
                } else {
                    DB::table('cv-basic-info')->insert([
                        'id' => $user_id,
                        'cvFullName' => $request->input('cvFullName'),
                        'verified' => $request->input('verified'),
                        'nationality' => $request->input('nationality'),
                        'gender' => $request->input('gender'),
                        'dateBirth' => $request->input('dateBirth'),
                        'maritalStatus' => $request->input('maritalStatus'),
                        'dateCreated' => now(),
                    ]);
                }
            // For UserBasicInfo Table

            // For UserIntro Table
                $existsIntro = DB::table('cv-introduction')->where('id', $user_id)->exists();

                if ($existsIntro) {
                    DB::table('cv-introduction')
                        ->where('id', $user_id)
                        ->update([
                            'introduction' => $request->input('introduction'),
                            'title' => $request->input('title'),
                        ]);
                } else {
                    DB::table('cv-introduction')->insert([
                        'id' => $user_id,
                        'introduction' => $request->input('introduction'),
                        'title' => $request->input('title'),
                        'created' => now(),
                    ]);
                }
            // For UserIntro Table

            // For UserContact Table
                // Insert or update contact details
                $existsContact = DB::table('cv-contact')->where('id', $user_id)->exists();

                if ($existsContact) {
                    DB::table('cv-contact')
                        ->where('id', $user_id)
                        ->update([
                            'location' => $request->input('location'),
                            'fullAddress' => $request->input('fullAddress'),
                        ]);
                } else {
                    DB::table('cv-contact')->insert([
                        'id' => $user_id,
                        'location' => $request->input('location'),
                        'fullAddress' => $request->input('fullAddress'),
                        'created' => now(),
                    ]);
                }
            // For UserContace Table

            // For UserSocialLink Table
                $socialLinks = $request->input('social_links', []);
                foreach ($socialLinks as $social) {
                    $linkName = $social['link_name'];
                    $linkUrl = $social['link'];

                    $existingLink = DB::table('cv_social_links')->where('user_id', $user_id)->where('link_name', $linkName)->exists();

                    if ($existingLink) {
                        DB::table('cv_social_links')
                            ->where('user_id', $user_id)
                            ->where('link_name', $linkName)
                            ->update([
                                'link' => $linkUrl,
                                'updated_at' => now(),
                            ]);
                    } else {
                        DB::table('cv_social_links')->insert([
                            'user_id' => $user_id,
                            'link_name' => $linkName,
                            'link' => $linkUrl,
                            'created_at' => now(),
                            'updated_at' => now(),
                        ]);
                    }
                }
            // For UserSocialLink Table

            // For Projects Table
                $projects = $request->input('projects', []);

                foreach ($projects as $cvProject) {
                    // UPDATE case: all three must match
                    if (!empty($cvProject['projectid'])) {
                        $existsProject = DB::table('cv-project')
                            ->where('id', $user_id)
                            ->where('projectid', $cvProject['projectid'])
                            ->where('title', $cvProject['title'])
                            ->exists();

                        if ($existsProject) {
                            DB::table('cv-project')
                                ->where('id', $user_id)
                                ->where('projectid', $cvProject['projectid'])
                                ->where('title', $cvProject['title'])
                                ->update([
                                    'workid' => $cvProject['workid'],
                                    'organization' => $cvProject['organization'],
                                    'designation' => $cvProject['designation'] ?? null,
                                    'duration' => $cvProject['duration'] ?? null,
                                    'location' => $cvProject['location'] ?? null,
                                    'description' => $cvProject['description'] ?? null,
                                ]);
                            continue;
                        }
                    }

                    // INSERT case: either projectid not provided or no match
                    DB::table('cv-project')->insert([
                        'id' => $user_id,
                        'projectid' => $cvProject['projectid'] ?? null, // include if present
                        'workid' => $cvProject['workid'],
                        'organization' => $cvProject['organization'],
                        'title' => $cvProject['title'],
                        'designation' => $cvProject['designation'] ?? null,
                        'duration' => $cvProject['duration'] ?? null,
                        'location' => $cvProject['location'] ?? null,
                        'description' => $cvProject['description'] ?? null,
                        'created' => now(),
                    ]);
                }
            // For Projects Table

            // For Academic Projects Table
                $academicProjects = $request->input('academic_projects', []);

                foreach ($academicProjects as $project) {
                    // If academicid is provided, treat as update
                    if (!empty($project['academicid'])) {
                        $exists = DB::table('cv-academic-projects')->where('academicid', $project['academicid'])->where('id', $user_id)->exists();

                        if ($exists) {
                            DB::table('cv-academic-projects')
                                ->where('academicid', $project['academicid'])
                                ->where('id', $user_id)
                                ->update([
                                    'title' => $project['title'],
                                    'description' => $project['description'],
                                    'created' => now(), // ideally use updated_at
                                ]);
                            continue;
                        } else {
                            DB::rollBack();
                            return $this->errorResponse('To update an academic project, you must provide a valid academicid. Otherwise, a new project will be created.', 404);
                        }
                    }

                    // Insert new academic project
                    DB::table('cv-academic-projects')->insert([
                        'id' => $user_id,
                        'title' => $project['title'],
                        'description' => $project['description'],
                        'created' => now(),
                    ]);
                }
            // For Academic Projects Table

            // For Poa Table
                $poa = $request->input('poa', []);

                foreach ($poa as $poas) {
                    // UPDATE case
                    if (!empty($poas['poaid'])) {
                        $existsPoa = DB::table('cv-poa')->where('poaid', $poas['poaid'])->where('id', $user_id)->exists();

                        if ($existsPoa) {
                            DB::table('cv-poa')
                                ->where('poaid', $poas['projectid'])
                                ->where('id', $user_id)
                                ->update([
                                    'title' => $poas['title'],
                                    'description' => $poas['description'] ?? null,
                                ]);
                            continue;
                        } else {
                            DB::rollBack();
                            return $this->errorResponse("Invalid poaid '{$poas['poaid']}' — no matching poa found for this user.", 404);
                        }
                    }

                    // INSERT case — Check for duplicate title for the same user
                    $duplicateTitle = DB::table('cv-poa')->where('id', $user_id)->where('title', $poas['title'])->exists();

                    if ($duplicateTitle) {
                        DB::rollBack();
                        return $this->errorResponse("Position title '{$poas['title']}' already exists for this user. Titles must be unique.", 409);
                    }

                    DB::table('cv-poa')->insert([
                        'id' => $user_id,
                        'title' => $poas['title'],
                        'description' => $poas['description'] ?? null,
                        'created' => now(),
                    ]);
                }
            // For poa Table


            DB::commit();

            $allSectionData = [
                'userBasic' => DB::table('user-basic')->where('id', $user_id)->first(),
                'basicInfo' => DB::table('cv-basic-info')->where('id', $user_id)->first(),
                'contact' => DB::table('cv-contact')->where('id', $user_id)->first(),
                'socialLinks' => DB::table('cv_social_links')->where('user_id', $user_id)->get(),
                'introduction' => DB::table('cv-introduction')->where('id', $user_id)->first(),
                // 'allProjects' => DB::table('cv-project')->where('id', $user_id)->get(),
                'academicProjects' => DB::table('cv-academic-projects')->where('id', $user_id)->get(),
            ];

            return $this->successResponse(
                [
                    'data' => $allSectionData,
                ],
                'User data stored successfully!',
            );
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse('Failed to store user data: ' . $e->getMessage(), 500);
        }
    }
}
