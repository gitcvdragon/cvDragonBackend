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
        $sections = MasterCvSection::with('resourceSections')->where('status', 1)->get();
        return $this->successResponse(
            [
                'data' => $sections,
            ],
            'Groups and sections are fetched successfully!!',
        );
    }

    // Fetch Section Questions::Retrieves a specific resource section by ID along with all its related section questions and their dependent questions (if any). Ensures the section exists and returns a structured JSON response with validation and success status.
    public function getSectionQuestions()
    {
        $sections = ResourceSection::with([
                'sectionQuestions.dependentQuestions'
            ])->get();
        return $this->successResponse(
            [
                'data' => $sections,
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

    // public function getUserSectionDetails(Request $request)
    // {
    //     $allSectionData = [];
    //     $text = '';
    //     $id = $request->input('id');

    //     // Helper to process descriptions and titles
    //     $appendText = function ($items, $fields) use (&$text) {
    //         foreach ($items as $item) {
    //             foreach ($fields as $field) {
    //                 if (isset($item->$field)) {
    //                     $text .= $item->$field . ' ';
    //                 }
    //             }
    //         }
    //     };

    //     // 1. Basic Info
    //     $allSectionData['basic_info'] = DB::table('cv-basic-info')->where('id', $id)->where('status', 1)->first();

    //     // Contact Details
    //     $allSectionData['contact_details'] = DB::table('cv-contact')->where('id', $id)->where('status', 1)->first();

    //     $allSectionData['social_links'] = DB::table('cv_social_links')->where('id', $id)->where('status', 1)->first();

    //     // 2. Introduction
    //     $introduction = DB::table('cv-introduction')->select('id', 'title', 'introduction')->where('id', $id)->where('status', 1)->first();

    //     $allSectionData['introduction'] = $introduction;

    //     //Sections with multiple records
    //     $sections = [
    //         'projects' => ['cv-project', ['projectid', 'description']],
    //         'academic_projects' => ['cv-academic-projects', ['academicid', 'description']],
    //         'poa' => ['cv-poa', ['poaid', 'description']],
    //         'co_curricular' => ['cv-co-curricular-activities', ['activityid', 'title', 'description']],
    //         'presentations' => ['cv-presentations', ['activityid', 'title', 'description']],
    //         'internships' => ['cv-internship', ['internshipid', 'description']],
    //         'trainings' => ['cv-trainings', ['trainingid', 'description']],
    //         'technical_skills' => ['cv-technical', ['technicalid', 'technical', 'type', 'level', 'description']],
    //         'publications' => ['cv-publications', ['publishid', 'title', 'publisher', 'description']],
    //         'achievements' => ['cv-achievements', ['achieveid', 'achievement', 'description']],
    //         'associations' => ['cv-association', ['associationid', 'description']],
    //         'volunteer' => ['cv-volunteer', ['volunteerid', 'description']],
    //         'skills' => ['cv-skills', ['skillid', 'skill', 'description']],
    //         'interests' => ['cv-interests', ['interestid', 'interest', 'level']],
    //         'languages' => ['cv-languages', ['langid', 'language']],
    //         'images' => ['cv-images', ['imageid', 'image', 'status']],
    //         'preferences' => ['cv-preference', ['prefid', 'noticePeriod', 'expectedCTC']],
    //         'education' => ['cv-education', ['eduid', 'category', 'specialization']],
    //         'work_experience' => ['cv-work', ['workid', 'organization', 'designation']],
    //         'patent' => ['cv-patent', ['patentid', 'patentOffice', 'patentStatus']],
    //         'certification' => ['cv-certification', ['certificateid', 'certificate', 'authority']],
    //     ];

    //     foreach ($sections as $key => [$table, $fields]) {
    //         $query = DB::table($table)->where('id', $id)->where('status', 1)->orderBy('created', 'desc');

    //         //     // Specific sort fields
    //         if ($table === 'cv-trainings') {
    //             $query->orderBy('number', 'desc');
    //         }
    //         if ($table === 'cv-achievements') {
    //             $query->orderBy('year', 'desc');
    //         }
    //         if (in_array($table, ['cv-association', 'cv-volunteer'])) {
    //             $query->orderBy('dateJoining', 'desc');
    //         }
    //         if ($table === 'cv-publications') {
    //             $query->orderBy('publishDate', 'desc');
    //         }

    //         $data = $query->get();
    //         $allSectionData[$key] = $data;
    //         $appendText($data, $fields);
    //     }

    //     return $this->successResponse(
    //         [
    //             'data' => $allSectionData,
    //         ],
    //         'All Sections Tabs are fetched successfully!!',
    //     );
    // }

    public function getUserSectionDetails(Request $request)
    {
        $user_id = $request->input('user_id');
        $section_id = $request->input('section_id');

        if (!$user_id || !$section_id) {
            return $this->errorResponse('Missing parameters', 400);
        }

        // Step 1: Get section table info
        $section = DB::table('resource-section')->where('id', $section_id)->first();

        if (!$section) {
            return $this->errorResponse('Section not found.', 404);
        }

        $sectionTable = $section->sectionTable;
        $idColumnName = $section->idColumnName;

        if (!$sectionTable || !$idColumnName) {
            return $this->errorResponse('Section configuration is incomplete.', 400);
        }

        // Step 2: Get question_column_name mappings
        $columnNames = DB::table('section_questions')
            ->select('sectionquestionid')
            ->where('resource_section_id', $section_id)
            ->get()
            ->pluck('sectionquestionid')
            ->filter(fn($name) => !is_null($name) && trim($name) !== '')
            ->values()
            ->toArray();

        $questionColumnNamesAssoc = DB::table('section_questions')
            ->whereIn('sectionquestionid', $columnNames)
            ->whereNotNull('question_column_name')
            ->whereRaw("TRIM(question_column_name) != ''")
            ->pluck('question_column_name', 'sectionquestionid')
            ->toArray();

        // Step 3: Fetch section records
        $sectionRecords = DB::table($sectionTable)
            ->where('id', $user_id)
            ->get();

        if ($sectionRecords->isEmpty()) {
            return $this->successResponse('No section data found.', [
                'data' => [],
                'section_table' => $sectionTable,
            ]);
        }

        // Step 4: Transform data (optional: map column names back to sectionquestionid)
        $responseData = [];

        foreach ($sectionRecords as $record) {
            $row = [];
            foreach ($questionColumnNamesAssoc as $sectionquestionid => $columnName) {
                $row[$sectionquestionid] = $record->$columnName ?? null;
            }
            $responseData[] = $row;
        }

        return response()->json([
            'status' => 'success',
            'message' => 'Section data fetched successfully.',
            'data' => $responseData,
            'section_table' => $sectionTable,
        ]);
    }

    public function getUserSectionDetailsAdd(Request $request)
    {
        $user_id = $request->input('user_id');
        $section_id = $request->input('section_id');
        $profile_id = $request->input('profile_id');

        if (!$user_id || !$section_id || !$profile_id) {
            return $this->errorResponse('Missing parameters', 400);
        }

        // Step 1: Get section table name
        $section = DB::table('resource-section')->where('id', $section_id)->first();

        if (!$section) {
            return $this->errorResponse('Section not found.', 404);
        }

        $sectionTable = $section->sectionTable;
        $idColumnName = $section->idColumnName;
        $section_name = $section->sectionName;

        if (!$sectionTable || !$idColumnName) {
            return $this->errorResponse('Section configuration is incomplete.', 400);
        }

        // Step 2: Get valid question_column_names mapping (sectionquestionid => question_column_name)
        $columnNames = DB::table('section_questions')->select('sectionquestionid')->where('resource_section_id', $section_id)->get()->pluck('sectionquestionid')->filter(fn($name) => !is_null($name) && trim($name) !== '')->values()->toArray();

        $questionColumnNamesAssoc = DB::table('section_questions')->whereIn('sectionquestionid', $columnNames)->whereNotNull('question_column_name')->whereRaw("TRIM(question_column_name) != ''")->pluck('question_column_name', 'sectionquestionid')->toArray();

        // Step 3: Build dynamic section_data from input data array
        $inputData = $request->input('data', []);
        $section_data = [];
        $multiInsertRows = [];

        foreach ($questionColumnNamesAssoc as $sectionquestionid => $columnName) {
            $value = $inputData[$sectionquestionid] ?? null;
            $section_data[$columnName] = $value;
        }

        $insertedIds = [];
        if (!empty($multiInsertRows)) {
            foreach ($multiInsertRows as $row) {
                $insertedIds[] = DB::table($sectionTable)->insertGetId($row, $idColumnName);
            }
            $recordId = $insertedIds;
            $action = 'inserted';
        } else {
            $section_data['id'] = $user_id;
            $recordId = DB::table($sectionTable)->insertGetId($section_data, $idColumnName);
            $action = 'inserted';
        }

        // Step 5: Handle special tables mapping
        $specialTables = ['cv-introduction', 'cv-contact', 'cv-basic-info', 'cv-preference'];

        if (in_array($sectionTable, $specialTables)) {
            $mapping = [
                'cv-introduction' => 'intro',
                'cv-contact' => 'contact_id',
                'cv-basic-info' => 'basic_info_id',
                'cv-preference' => 'preference_id',
            ];

            $columnToUpdate = $mapping[$sectionTable] ?? null;

            if ($columnToUpdate) {
                $cvProfile = DB::table('create-cvprofile')->where('cvid', $profile_id)->where('id', $user_id)->first();

                if ($cvProfile) {
                    DB::table('create-cvprofile')
                        ->where('cvid', $profile_id)
                        ->where('id', $user_id)
                        ->update([$columnToUpdate => $recordId]);
                } else {
                    DB::table('create-cvprofile')->insert([
                        'cvid' => $profile_id,
                        'id' => $user_id,
                        $columnToUpdate => $recordId,
                    ]);
                }
            }
        } else {
            // Step 6: Handle non-special tables -> create-cvprofilesection
            $existingCvProfileSection = DB::table('create-cvprofilesection')->where('cvid', $profile_id)->where('section', $section_id)->where('id', $user_id)->first();

            $newRecordIds = is_array($recordId) ? $recordId : [$recordId];
            $newRecordIds = array_map('strval', $newRecordIds);
            $subsectionData = json_encode(array_map('strval', is_array($recordId) ? $recordId : [$recordId]));

            if ($existingCvProfileSection) {
                $existingSubsection = json_decode($existingCvProfileSection->subsection, true) ?? [];
                $existingSubsection = array_map('strval', $existingSubsection);
                $mergedSubsection = array_unique(array_merge($existingSubsection, $newRecordIds));

                DB::table('create-cvprofilesection')
                    ->where('cvid', $profile_id)
                    ->where('section', $section_id)
                    ->where('id', $user_id)
                    ->update([
                        'subsection' => json_encode($mergedSubsection),
                        'showName' => $section_name,
                    ]);
            } else {
                DB::table('create-cvprofilesection')->insert([
                    'cvid' => $profile_id,
                    'section' => $section_id,
                    'id' => $user_id,
                    'subsection' => json_encode($newRecordIds),
                    'showName' => $section_name,
                ]);
            }
        }

        return response()->json([
            'status' => 'success',
            'message' => "Data {$action} successfully.",
            'record_id' => $recordId,
            'section_table' => $sectionTable,
            'section_data' => $section_data,
        ]);
    }

    public function getUserSectionDetailsUpdate(Request $request)
    {
        $user_id = $request->input('user_id');
        $section_id = $request->input('section_id');
        $subSection_id = $request->input('subSection_id');

        //dd($user_id, $section_id, $subSection_id);

        if (!$user_id || !$section_id || !$subSection_id) {
            return $this->errorResponse('Missing parameters', 400);
        }

        // Step 1: Get section table config
        $section = DB::table('resource-section')->where('id', $section_id)->first();

        if (!$section) {
            return $this->errorResponse('Section not found.', 404);
        }

        $sectionTable = $section->sectionTable;
        $idColumnName = $section->idColumnName;

        if (!$sectionTable || !$idColumnName) {
            return $this->errorResponse('Section configuration is incomplete.', 400);
        }

        // Step 2: Get valid column mappings
        $questionColumnNamesAssoc = DB::table('section_questions')
            ->where('resource_section_id', $section_id)
            ->whereNotNull('question_column_name')
            ->whereRaw("TRIM(question_column_name) != ''")
            ->pluck('question_column_name', 'sectionquestionid')
            ->toArray();

        // Step 3: Build update data from input
        $inputData = $request->input('data', []);
        $updateData = [];

        foreach ($questionColumnNamesAssoc as $sectionquestionid => $columnName) {
            if (array_key_exists($sectionquestionid, $inputData)) {
                $updateData[$columnName] = $inputData[$sectionquestionid];
            }
        }

        if (empty($updateData)) {
            return $this->errorResponse('No valid data to update.', 400);
        }

        // Step 4: Perform the update
        $updated = DB::table($sectionTable)
            ->where($idColumnName, $subSection_id)
            ->where('id', $user_id)
            ->update($updateData);

        if ($updated) {
            return response()->json([
                'status' => 'success',
                'message' => 'Section data updated successfully.',
                'section_table' => $sectionTable,
                'sub_section_id' => $subSection_id,
                'updated_fields' => $updateData
            ]);
        } else {
            return $this->errorResponse('Changes are done already!!!', 500);
        }
    }

    public function getUserSectionDetailsHardDelete(Request $request)
    {
        $user_id = $request->input('user_id');
        $section_id = $request->input('section_id');
        $subSection_id = $request->input('subSection_id');

        if (!$user_id || !$section_id || !$subSection_id) {
            return response()->json(['status' => 'error', 'message' => 'Missing parameters'], 400);
        }

        // Step 1: Get section table info
        $section = DB::table('resource-section')->where('id', $section_id)->first();

        if (!$section) {
            return response()->json(['status' => 'error', 'message' => 'Section not found'], 404);
        }

        $sectionTable = $section->sectionTable;
        $idColumnName = $section->idColumnName;

        if (!$sectionTable || !$idColumnName) {
            return response()->json(['status' => 'error', 'message' => 'Section configuration incomplete'], 400);
        }

        // Step 2: Soft delete in section table (status = 0)
        $updated = DB::table($sectionTable)
            ->where($idColumnName, $subSection_id)
            ->where('id', $user_id)
            ->update(['status' => 0]);

        if (!$updated) {
            return response()->json(['status' => 'error', 'message' => 'Delete failed or already deleted'], 500);
        }

        // Step 3: Remove subSection_id from create-cvprofilesection subsection
        $cvProfileSection = DB::table('create-cvprofilesection')
            ->where('id', $user_id)
            ->where('section', $section_id)
            ->first();

        if ($cvProfileSection) {
            $existingSubsections = json_decode($cvProfileSection->subsection, true) ?? [];
            $updatedSubsections = array_filter($existingSubsections, fn($id) => (string)$id !== (string)$subSection_id);

            DB::table('create-cvprofilesection')
                ->where('id', $user_id)
                ->where('section', $section_id)
                ->update(['subsection' => json_encode(array_values($updatedSubsections))]);
        }

        return response()->json([
            'status' => 'success',
            'message' => 'Subsection deleted successfully.',
            'section_table' => $sectionTable,
            'sub_section_id' => $subSection_id
        ]);
    }

    public function getUserSectionDetailsSoftDelete(Request $request)
    {
        $user_id = $request->input('user_id');
        $profile_id = $request->input('profile_id');
        $section_id = $request->input('section_id');
        $subSection_id = $request->input('subSection_id');

        if (!$user_id || !$profile_id || !$section_id || !$subSection_id) {
            return response()->json(['status' => 'error', 'message' => 'Missing parameters'], 400);
        }

        // Step 2: Remove subsection ID from create-cvprofilesection
        $profileSection = DB::table('create-cvprofilesection')
            ->where('cvid', $profile_id)
            ->where('section', $section_id)
            ->where('id', $user_id)
            ->first();

        if ($profileSection) {
            $subsections = json_decode($profileSection->subsection, true) ?? [];

            // Remove the subSection_id
            $subsections = array_filter($subsections, function ($id) use ($subSection_id) {
                return strval($id) !== strval($subSection_id);
            });

            // Update the record
            DB::table('create-cvprofilesection')
                ->where('cvid', $profile_id)
                ->where('section', $section_id)
                ->where('id', $user_id)
                ->update([
                    'subsection' => json_encode(array_values($subsections)) // reset indexes
                ]);
        }

        return response()->json([
            'status' => 'success',
            'message' => 'Section entry marked removed from profile section.',
        ]);
    }


}
