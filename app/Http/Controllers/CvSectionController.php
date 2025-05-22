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

    // public function getUserSectionDetailsAdd(Request $request)
    // {
    //     $user_id = $request->input('user_id');

    //     $messages = [
    //         'academic_projects.*.academicid.required_with' => 'academicid is required when updating an academic project. Omit it only when adding a new one.',
    //         'academic_projects.*.academicid.exists' => 'The selected academic project does not exist.',
    //         'projects.*.workid.integer' => 'The work ID must be a valid number.',
    //         'projects.*.organization.required' => 'Organization name is required for each project.',
    //         'projects.*.organization.string' => 'Organization must be a valid string.',
    //         'projects.*.title.required' => 'Project title is required.',
    //         'projects.*.title.string' => 'Project title must be a valid string.',

    //         'co_curricular_activities.*.title.required' => 'Title is required for each co-curricular activity.',
    //         'co_curricular_activities.*.title.string' => 'Title must be a valid string.',
    //         'co_curricular_activities.*.description.required' => 'Description is required for each co-curricular activity.',
    //         'co_curricular_activities.*.description.string' => 'Description must be a valid string.',
    //         'co_curricular_activities.*.activityid.exists' => 'The selected co-curricular activity does not exist.',
    //     ];

    //     $validator = Validator::make(
    //         $request->all(),
    //         [
    //             'cvFullName' => 'required|string|max:100',
    //             'verified' => 'nullable',
    //             'nationality' => 'required|string|max:50',
    //             'gender' => 'required|string|in:Male,Female',
    //             'dateBirth' => 'required|date',
    //             'maritalStatus' => 'required',
    //             'location' => 'nullable|string',
    //             'fullAddress' => 'required|string',
    //             'introduction' => 'required|string',

    //             'projects' => 'nullable|array',
    //             'projects.*.workid' => 'nullable|integer',
    //             'projects.*.organization' => 'required|string',
    //             'projects.*.title' => 'required|string',

    //             'academic_projects' => 'nullable|array',
    //             'academic_projects.*.title' => 'required|string',
    //             'academic_projects.*.description' => 'required|string',
    //             'academic_projects.*.academicid' => 'nullable|integer|exists:cv-academic-projects,academicid',

    //             'co_curricular_activities' => 'nullable|array',
    //             'co_curricular_activities.*.title' => 'required|string',
    //             'co_curricular_activities.*.description' => 'required|string',
    //             'co_curricular_activities.*.activityid' => 'nullable|integer|exists:cv-co-curricular-activities,activityid',

    //             'poa.*.poaid.required_with' => 'poaid is required when updating a poa. Omit it only when adding a new one.',
    //             'poa.*.poaid.exists' => 'The selected poa does not exist.',
    //             'poa.*.title.required' => 'POA title is required.',
    //             'poa.*.title.string' => 'POA title must be a string.',
    //             'poa.*.description.required' => 'POA description is required.',
    //             'poa.*.description.string' => 'POA description must be a string.',

    //             'social_links' => 'nullable|array',
    //             'social_links.*.link_name' => 'required|string',
    //             'social_links.*.link' => 'required|string',             
    //         ],
    //         $messages,
    //     );

    //     if ($validator->fails()) {
    //         return $this->validationErrorResponse($validator->errors()->first(), 'Validation failed');
    //     }

    //     try {
    //         // For UserBasic Table
    //         $userBasic = DB::table('user-basic')->where('id', $user_id)->first();

    //         if (!$userBasic) {
    //             DB::rollBack();
    //             return $this->errorResponse('User not found', 404);
    //         }

    //         DB::table('user-basic')
    //             ->where('id', $user_id)
    //             ->update([
    //                 'fullName' => $request->input('cvFullName'),
    //             ]);

    //         // For UserBasic Table

    //         // For UserBasicInfo Table
    //             $existsBasicInfo = DB::table('cv-basic-info')->where('id', $user_id)->exists();

    //             if ($existsBasicInfo) {
    //                 DB::table('cv-basic-info')
    //                     ->where('id', $user_id)
    //                     ->update([
    //                         'cvFullName' => $request->input('cvFullName'),
    //                         'verified' => $request->input('verified'),
    //                         'nationality' => $request->input('nationality'),
    //                         'gender' => $request->input('gender'),
    //                         'dateBirth' => $request->input('dateBirth'),
    //                         'maritalStatus' => $request->input('maritalStatus'),
    //                     ]);
    //             } else {
    //                 DB::table('cv-basic-info')->insert([
    //                     'id' => $user_id,
    //                     'cvFullName' => $request->input('cvFullName'),
    //                     'verified' => $request->input('verified'),
    //                     'nationality' => $request->input('nationality'),
    //                     'gender' => $request->input('gender'),
    //                     'dateBirth' => $request->input('dateBirth'),
    //                     'maritalStatus' => $request->input('maritalStatus'),
    //                     'dateCreated' => now(),
    //                 ]);
    //             }
    //         // For UserBasicInfo Table

    //         // For UserIntro Table
    //             $existsIntro = DB::table('cv-introduction')->where('id', $user_id)->exists();

    //             if ($existsIntro) {
    //                 DB::table('cv-introduction')
    //                     ->where('id', $user_id)
    //                     ->update([
    //                         'introduction' => $request->input('introduction'),
    //                         'title' => $request->input('title'),
    //                     ]);
    //             } else {
    //                 DB::table('cv-introduction')->insert([
    //                     'id' => $user_id,
    //                     'introduction' => $request->input('introduction'),
    //                     'title' => $request->input('title'),
    //                     'created' => now(),
    //                 ]);
    //             }
    //         // For UserIntro Table

    //         // For UserContact Table
    //             // Insert or update contact details
    //             $existsContact = DB::table('cv-contact')->where('id', $user_id)->exists();

    //             if ($existsContact) {
    //                 DB::table('cv-contact')
    //                     ->where('id', $user_id)
    //                     ->update([
    //                         'location' => $request->input('location'),
    //                         'fullAddress' => $request->input('fullAddress'),
    //                     ]);
    //             } else {
    //                 DB::table('cv-contact')->insert([
    //                     'id' => $user_id,
    //                     'location' => $request->input('location'),
    //                     'fullAddress' => $request->input('fullAddress'),
    //                     'created' => now(),
    //                 ]);
    //             }
    //         // For UserContace Table

    //         // For preference Table
    //             $existsPreference = DB::table('cv-preference')->where('id', $user_id)->exists();

    //             if ($existsPreference) {
    //                 DB::table('cv-preference')
    //                     ->where('id', $user_id)
    //                     ->update([
    //                         'passport' => $request->input('passport'),
    //                         'passportDetails' => $request->input('passportDetails'),
    //                         'recommendations' => $request->input('recommendations'),
    //                         'preferredLocation' => $request->input('preferredLocation'),
    //                         'canRelocate' => $request->input('canRelocate'),
    //                         'noticePeriod' => $request->input('noticePeriod'),
    //                         'canJoin' => $request->input('canJoin'),
    //                         'expectedCTC' => $request->input('expectedCTC'),
    //                         'isNegotiate' => $request->input('isNegotiate'),
    //                         'declaration' => $request->input('declaration'),
    //                         'signature' => $request->input('signature'),
    //                     ]);
    //             } else {
    //                 DB::table('cv-preference')->insert([
    //                     'id' => $user_id,
    //                     'passport' => $request->input('passport'),
    //                     'passportDetails' => $request->input('passportDetails'),
    //                     'recommendations' => $request->input('recommendations'),
    //                     'preferredLocation' => $request->input('preferredLocation'),
    //                     'canRelocate' => $request->input('canRelocate'),
    //                     'noticePeriod' => $request->input('noticePeriod'),
    //                     'canJoin' => $request->input('canJoin'),
    //                     'expectedCTC' => $request->input('expectedCTC'),
    //                     'isNegotiate' => $request->input('isNegotiate'),
    //                     'declaration' => $request->input('declaration'),
    //                     'signature' => $request->input('signature'),
    //                     'created' => now(),
    //                 ]);
    //             }
    //         // For preference Table

    //         // For UserSocialLink Table
    //             $socialLinks = $request->input('social_links', []);
    //             foreach ($socialLinks as $social) {
    //                 $linkName = $social['link_name'];
    //                 $linkUrl = $social['link'];

    //                 $existingLink = DB::table('cv_social_links')->where('user_id', $user_id)->where('link_name', $linkName)->exists();

    //                 if ($existingLink) {
    //                     DB::table('cv_social_links')
    //                         ->where('user_id', $user_id)
    //                         ->where('link_name', $linkName)
    //                         ->update([
    //                             'link' => $linkUrl,
    //                             'updated_at' => now(),
    //                         ]);
    //                 } else {
    //                     DB::table('cv_social_links')->insert([
    //                         'user_id' => $user_id,
    //                         'link_name' => $linkName,
    //                         'link' => $linkUrl,
    //                         'created_at' => now(),
    //                         'updated_at' => now(),
    //                     ]);
    //                 }
    //             }
    //         // For UserSocialLink Table

    //         // For Academic Projects Table
    //             $academicProjects = $request->input('academic_projects', []);

    //             DB::beginTransaction();
    //             try {
    //                 foreach ($academicProjects as $academicProject) {
    //                     $academicProjectId = $academicProject['academicid'] ?? null;

    //                     if (!empty($academicProjectId)) {
    //                         DB::table('cv-academic-projects') // updated table name
    //                             ->where('id', $user_id)
    //                             ->where('academicid', $academicProjectId)
    //                             ->update([
    //                                 'title' => $academicProject['title'] ?? '',
    //                                 'description' => $academicProject['description'] ?? '',
    //                             ]);
    //                     } else {
    //                         DB::table('cv-academic-projects')->insert([
    //                             'id' => $user_id,
    //                             'title' => $academicProject['title'] ?? '',
    //                             'description' => $academicProject['description'] ?? '',
    //                             'created' => now(),
    //                         ]);
    //                     }
    //                 }
    //                 DB::commit();
    //             } catch (\Exception $e) {
    //                 DB::rollBack();
    //                 return response()->json(
    //                     [
    //                         'success' => false,
    //                         'message' => 'Failed to process academic projects.',
    //                         'error' => $e->getMessage(),
    //                     ],
    //                     500,
    //                 );
    //             }
    //         // For Academic Projects Table

    //         // For Poa Table
    //            $poa = $request->input('poa', []);
    //             DB::beginTransaction();
    //             try {
    //                     foreach ($poa as $poas) {
    //                         $poaid = $poas['poaid'] ?? null;

    //                         if (!empty($poaid)) {
    //                                 DB::table('cv-poa')
    //                                     ->where('poaid', $poaid)
    //                                     ->where('id', $user_id)
    //                                     ->update([
    //                                         'title' => $poas['title'] ?? '',
    //                                         'description' => $poas['description'] ?? '',
    //                                     ]);
    //                         }else{
    //                         DB::table('cv-poa')->insert([
    //                                 'id' => $user_id,
    //                                 'title' => $poas['title'] ?? '',
    //                                 'description' => $poas['description'] ?? '',
    //                                 'created' => now(),
    //                             ]);
    //                         }                       
    //                     }

    //                     DB::commit();
    //                 } catch (\Exception $e) {
    //                     DB::rollBack();
    //                     return response()->json([
    //                         'success' => false,
    //                         'message' => 'Failed to process POA entries.',
    //                         'error' => $e->getMessage(),
    //                     ], 500);
    //                 }
    //         // For poa Table

    //         //For Projects Table
    //             $cvProjects = $request->input('projects', []);
    //             DB::beginTransaction();
    //             try {
    //                 foreach ($cvProjects as $cvProject) {
    //                     $projectId = $cvProject['projectid'] ?? null;

    //                     if (!empty($projectId)) {
    //                         DB::table('cv-project')
    //                             ->where('id', $user_id)
    //                             ->where('projectid', $projectId)
    //                             ->update([
    //                                 'title' => $cvProject['title'] ?? '',
    //                                 'workid' => $cvProject['workid'] ?? null,
    //                                 'organization' => $cvProject['organization'] ?? '',
    //                                 'designation' => $cvProject['designation'] ?? null,
    //                                 'duration' => $cvProject['duration'] ?? null,
    //                                 'location' => $cvProject['location'] ?? null,
    //                                 'description' => $cvProject['description'] ?? null,
    //                             ]);
    //                     } else {
    //                         DB::table('cv-project')->insert([
    //                             'id' => $user_id,
    //                             'title' => $cvProject['title'] ?? '',
    //                             'workid' => $cvProject['workid'] ?? null,
    //                             'organization' => $cvProject['organization'] ?? '',
    //                             'designation' => $cvProject['designation'] ?? null,
    //                             'duration' => $cvProject['duration'] ?? null,
    //                             'location' => $cvProject['location'] ?? null,
    //                             'description' => $cvProject['description'] ?? null,
    //                             'created' => now(),
    //                         ]);
    //                     }
    //                 }

    //                 DB::commit();
    //             } catch (\Exception $e) {
    //                 DB::rollBack();
    //                 return response()->json([
    //                     'success' => false,
    //                     'message' => 'Failed to process project entries.',
    //                     'error' => $e->getMessage(),
    //                 ], 500);
    //             }
    //         //For Projects Table

    //         //For Co-Curricular Activities
    //           $coCurricularActivities = $request->input('co_curricular_activities', []);

    //             DB::beginTransaction();
    //             try {
    //                 foreach ($coCurricularActivities as $activity) {
    //                     $activityId = $activity['activityid'] ?? null;
    //                     $title = $activity['title'] ?? '';
    //                     $description = $activity['description'] ?? '';

    //                     if (!empty($activityId)) {
    //                         DB::table('cv-co-curricular-activities')
    //                             ->where('id', $user_id)
    //                             ->where('activityid', $activityId)
    //                             ->update([
    //                                 'title' => $title,
    //                                 'description' => $description,
    //                             ]);
    //                     } else {
    //                         DB::table('cv-co-curricular-activities')->insert([
    //                             'id' => $user_id,
    //                             'title' => $title,
    //                             'description' => $description,
    //                             'created' => now(),
    //                         ]);
    //                     }
    //                 }

    //                 DB::commit();
    //             } catch (\Exception $e) {
    //                 DB::rollBack();
    //                 return response()->json([
    //                     'success' => false,
    //                     'message' => 'Failed to process co-curricular activities.',
    //                     'error' => $e->getMessage(),
    //                 ], 500);
    //             }
    //         //For Co-Curricular Activities

    //         //For presentations
    //           $presentations = $request->input('presentations', []);

    //             DB::beginTransaction();
    //             try {
    //                 foreach ($presentations as $presentation) {
    //                     $presentationactivityId = $presentation['activityid'] ?? null;
    //                     $title = $presentation['title'] ?? '';
    //                     $description = $presentation['description'] ?? '';

    //                     if (!empty($presentationactivityId)) {
    //                         DB::table('cv-presentations')
    //                             ->where('id', $user_id)
    //                             ->where('activityid', $presentationactivityId)
    //                             ->update([
    //                                 'title' => $title,
    //                                 'description' => $description,
    //                             ]);
    //                     } else {
    //                         DB::table('cv-presentations')->insert([
    //                             'id' => $user_id,
    //                             'title' => $title,
    //                             'description' => $description,
    //                             'created' => now(),
    //                         ]);
    //                     }
    //                 }

    //                 DB::commit();
    //             } catch (\Exception $e) {
    //                 DB::rollBack();
    //                 return response()->json([
    //                     'success' => false,
    //                     'message' => 'Failed to process presentations.',
    //                     'error' => $e->getMessage(),
    //                 ], 500);
    //             }
    //         //For presentations

    //         //For internship Table
    //             $internships = $request->input('internship', []);
    //             DB::beginTransaction();
    //             try {
    //                 foreach ($internships as $internship) {
    //                     $internshipid = $internship['internshipid'] ?? null;

    //                     if (!empty($internshipid)) {
    //                         DB::table('cv-internship')
    //                             ->where('id', $user_id)
    //                             ->where('internshipid', $internshipid)
    //                             ->update([
    //                                 'title' => $internship['title'] ?? '',
    //                                 'workid' => $internship['workid'] ?? null,
    //                                 'organization' => $internship['organization'] ?? '',
    //                                 'designation' => $internship['designation'] ?? null,
    //                                 'duration' => $internship['duration'] ?? null,
    //                                 'location' => $internship['location'] ?? null,
    //                                 'description' => $internship['description'] ?? null,
    //                             ]);
    //                     } else {
    //                         DB::table('cv-internship')->insert([
    //                             'id' => $user_id,
    //                             'title' => $internship['title'] ?? '',
    //                             'workid' => $internship['workid'] ?? null,
    //                             'organization' => $internship['organization'] ?? '',
    //                             'designation' => $internship['designation'] ?? null,
    //                             'duration' => $internship['duration'] ?? null,
    //                             'location' => $internship['location'] ?? null,
    //                             'description' => $internship['description'] ?? null,
    //                             'created' => now(),
    //                         ]);
    //                     }
    //                 }

    //                 DB::commit();
    //             } catch (\Exception $e) {
    //                 DB::rollBack();
    //                 return response()->json([
    //                     'success' => false,
    //                     'message' => 'Failed to process internship entries.',
    //                     'error' => $e->getMessage(),
    //                 ], 500);
    //             }
    //         //For internship Table

    //         // For trainings Table
    //             $trainings = $request->input('trainings', []);

    //             DB::beginTransaction();
    //             try {
    //                 foreach ($trainings as $training) {
    //                     $trainingid = $training['trainingid'] ?? null;

    //                     if (!empty($trainingid)) {
    //                         DB::table('cv-trainings') // updated table name
    //                             ->where('id', $user_id)
    //                             ->where('trainingid', $trainingid)
    //                             ->update([
    //                                 'training' => $training['training'] ?? '',
    //                                 'description' => $training['description'] ?? '',
    //                                 'number' => $training['number'] ?? '',
    //                             ]);
    //                     } else {
    //                         DB::table('cv-trainings')->insert([
    //                             'id' => $user_id,
    //                             'training' => $training['training'] ?? '',
    //                             'description' => $training['description'] ?? '',
    //                             'number' => $training['number'] ?? '',
    //                             'created' => now(),
    //                         ]);
    //                     }
    //                 }
    //                 DB::commit();
    //             } catch (\Exception $e) {
    //                 DB::rollBack();
    //                 return response()->json(
    //                     [
    //                         'success' => false,
    //                         'message' => 'Failed to process trainings.',
    //                         'error' => $e->getMessage(),
    //                     ],
    //                     500,
    //                 );
    //             }
    //         // For trainings Table


    //         // For technical Table
    //             $technical = $request->input('technical', []);

    //             DB::beginTransaction();
    //             try {
    //                 foreach ($technical as $technicalSkill) {
    //                     $technicalid = $technicalSkill['technicalid'] ?? null;

    //                     if (!empty($technicalid)) {
    //                         DB::table('cv-technical') // updated table name
    //                             ->where('id', $user_id)
    //                             ->where('technicalid', $technicalid)
    //                             ->update([
    //                                 'technical' => $technicalSkill['technical'] ?? '',
    //                                 'level' => $technicalSkill['level'] ?? '',
    //                             ]);
    //                     } else {
    //                         DB::table('cv-technical')->insert([
    //                             'id' => $user_id,
    //                             'technical' => $technicalSkill['technical'] ?? '',
    //                             'level' => $technicalSkill['level'] ?? '',
    //                             'created' => now(),
    //                         ]);
    //                     }
    //                 }
    //                 DB::commit();
    //             } catch (\Exception $e) {
    //                 DB::rollBack();
    //                 return response()->json(
    //                     [
    //                         'success' => false,
    //                         'message' => 'Failed to process technical.',
    //                         'error' => $e->getMessage(),
    //                     ],
    //                     500,
    //                 );
    //             }
    //         // For technical Table

    //         // For publications Table
    //             $publications = $request->input('publications', []);

    //             DB::beginTransaction();
    //             try {
    //                 foreach ($publications as $publication) {
    //                     $publishid = $publication['publishid'] ?? null;

    //                     if (!empty($publishid)) {
    //                         DB::table('cv-publications') // updated table name
    //                             ->where('id', $user_id)
    //                             ->where('publishid', $publishid)
    //                             ->update([
    //                                 'title' => $publication['title'] ?? '',
    //                                 'category' => $publication['category'] ?? '',
    //                                 'publisher' => $publication['publisher'] ?? '',
    //                                 'publishDate' => $publication['publishDate'] ?? '',
    //                                 'description' => $publication['description'] ?? '',
    //                             ]);
    //                     } else {
    //                         DB::table('cv-publications')->insert([
    //                             'id' => $user_id,
    //                             'title' => $publication['title'] ?? '',
    //                             'category' => $publication['category'] ?? '',
    //                             'publisher' => $publication['publisher'] ?? '',
    //                             'publishDate' => $publication['publishDate'] ?? '',
    //                             'description' => $publication['description'] ?? '',
    //                             'created' => now(),
    //                         ]);
    //                     }
    //                 }
    //                 DB::commit();
    //             } catch (\Exception $e) {
    //                 DB::rollBack();
    //                 return response()->json(
    //                     [
    //                         'success' => false,
    //                         'message' => 'Failed to process publications.',
    //                         'error' => $e->getMessage(),
    //                     ],
    //                     500,
    //                 );
    //             }
    //         // For publications Table

    //         // For skills Table
    //             $skills = $request->input('skills', []);

    //             DB::beginTransaction();
    //             try {
    //                 foreach ($skills as $skill) {
    //                     $skillid = $publication['skillid'] ?? null;

    //                     if (!empty($skillid)) {
    //                         DB::table('cv-skills') // updated table name
    //                             ->where('id', $user_id)
    //                             ->where('skillid', $skillid)
    //                             ->update([
    //                                 'skill' => $skill['skill'] ?? '',
    //                                 'description' => $skill['description'] ?? '',
    //                             ]);
    //                     } else {
    //                         DB::table('cv-skills')->insert([
    //                             'id' => $user_id,
    //                             'skill' => $skill['skill'] ?? '',
    //                             'description' => $skill['description'] ?? '',
    //                             'created' => now(),
    //                         ]);
    //                     }
    //                 }
    //                 DB::commit();
    //             } catch (\Exception $e) {
    //                 DB::rollBack();
    //                 return response()->json(
    //                     [
    //                         'success' => false,
    //                         'message' => 'Failed to process skill.',
    //                         'error' => $e->getMessage(),
    //                     ],
    //                     500,
    //                 );
    //             }
    //         // For publications Table

    //         // For achievements Table
    //             $achievements = $request->input('achievements', []);

    //             DB::beginTransaction();
    //             try {
    //                 foreach ($achievements as $achievement) {
    //                     $achieveid = $achievement['achieveid'] ?? null;

    //                     if (!empty($achieveid)) {
    //                         DB::table('cv-achievements') // updated table name
    //                             ->where('id', $user_id)
    //                             ->where('achieveid', $achieveid)
    //                             ->update([
    //                                 'achievement' => $achievement['achievement'] ?? '',
    //                                 'year' => $achievement['year'] ?? '',
    //                                 'description' => $achievement['description'] ?? '',
    //                             ]);
    //                     } else {
    //                         DB::table('cv-achievements')->insert([
    //                             'id' => $user_id,
    //                             'achievement' => $achievement['achievement'] ?? '',
    //                             'year' => $achievement['year'] ?? '',
    //                             'description' => $achievement['description'] ?? '',
    //                             'created' => now(),
    //                         ]);
    //                     }
    //                 }
    //                 DB::commit();
    //             } catch (\Exception $e) {
    //                 DB::rollBack();
    //                 return response()->json(
    //                     [
    //                         'success' => false,
    //                         'message' => 'Failed to process achievement.',
    //                         'error' => $e->getMessage(),
    //                     ],
    //                     500,
    //                 );
    //             }
    //         // For achievements Table

    //         // For association Table
    //             $associations = $request->input('association', []);

    //             DB::beginTransaction();
    //             try {
    //                 foreach ($associations as $association) {
    //                     $associationid = $association['associationid'] ?? null;

    //                     if (!empty($associationid)) {
    //                         DB::table('cv-association') // updated table name
    //                             ->where('id', $user_id)
    //                             ->where('associationid', $associationid)
    //                             ->update([
    //                                 'organization' => $association['organization'] ?? '',
    //                                 'position' => $association['position'] ?? '',
    //                                 'location' => $association['location'] ?? '',
    //                                 'description' => $association['description'] ?? '',
    //                                 'dateJoining' => $association['dateJoining'] ?? '',
    //                                 'dateLeaving' => $association['dateLeaving'] ?? '',
    //                                 'present' => $association['present'] ?? '',
    //                             ]);
    //                     } else {
    //                         DB::table('cv-association')->insert([
    //                             'id' => $user_id,
    //                             'organization' => $association['organization'] ?? '',
    //                             'position' => $association['position'] ?? '',
    //                             'location' => $association['location'] ?? '',
    //                             'description' => $association['description'] ?? '',
    //                             'dateJoining' => $association['dateJoining'] ?? '',
    //                             'dateLeaving' => $association['dateLeaving'] ?? '',
    //                             'present' => $association['present'] ?? '',
    //                             'created' => now(),
    //                         ]);
    //                     }
    //                 }
    //                 DB::commit();
    //             } catch (\Exception $e) {
    //                 DB::rollBack();
    //                 return response()->json(
    //                     [
    //                         'success' => false,
    //                         'message' => 'Failed to process association.',
    //                         'error' => $e->getMessage(),
    //                     ],
    //                     500,
    //                 );
    //             }
    //         // For association Table

            

    //         DB::commit();

    //         $allSectionData = [
    //             'userBasic' => DB::table('user-basic')->where('id', $user_id)->first(),
    //             'basicInfo' => DB::table('cv-basic-info')->where('id', $user_id)->first(),
    //             'contact' => DB::table('cv-contact')->where('id', $user_id)->first(),
    //             'socialLinks' => DB::table('cv_social_links')->where('user_id', $user_id)->get(),
    //             'introduction' => DB::table('cv-introduction')->where('id', $user_id)->first(),
    //             'allProjects' => DB::table('cv-project')->where('id', $user_id)->get(),
    //             'academicProjects' => DB::table('cv-academic-projects')->where('id', $user_id)->get(),
    //         ];

    //         return $this->successResponse(
    //             [
    //                 'data' => $allSectionData,
    //             ],
    //             'User data stored successfully!',
    //         );
    //     } catch (\Exception $e) {
    //         DB::rollBack();
    //         return $this->errorResponse('Failed to store user data: ' . $e->getMessage(), 500);
    //     }
    // }

    public function getUserSectionDetailsAdd(Request $request)
    {
        $user_id = $request->input('user_id');
        $section_id = $request->input('section_id');
        $profile_id = $request->input('profile_id');
        $section_data = $request->input('data'); // nested section-specific data

        if (!$user_id || !$section_id || !$profile_id || !is_array($section_data)) {
            return response()->json(['status' => 'error', 'message' => 'Missing or invalid parameters.'], 400);
        }

        // Step 1: Get section table name
        $section = DB::table('resource-section')->where('id', $section_id)->first();

        if (!$section || !$section->sectionTable) {
            return response()->json(['status' => 'error', 'message' => 'Invalid section ID or missing table mapping.'], 404);
        }

        $tableName = $section->sectionTable;

        //dd($tableName);

        // Step 2: Merge user_id and profile_id with the section data
        $insertData = array_merge($section_data, [
            'user_id' => $user_id,
            'profile_id' => $profile_id
        ]);

        try {
            DB::table($tableName)->insert($insertData);
            return response()->json(['status' => 'success', 'message' => 'Section data inserted successfully.']);
        } catch (\Exception $e) {
            return response()->json(['status' => 'error', 'message' => 'Insertion failed.', 'error' => $e->getMessage()], 500);
        }
    }

}
