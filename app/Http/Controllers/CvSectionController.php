<?php
namespace App\Http\Controllers;

use App\Models\MasterCvSection;
use App\Models\ResourceSection;
use App\Traits\ApiResponseTrait;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class CvSectionController extends Controller
{
    use ApiResponseTrait;

    //Fetch CV Section Groups with Their Sections::Returns all master CV section groups along with their associated resource sections.
    public function getGroupSections()
    {
        $sections = MasterCvSection::with('resourceSections')->where('status', 1)->get();
        $sections->each(function ($section) {
            $section->resourceSections->each(function ($resource) {
                $resource->makeHidden(['sectionTable']);
            });
        });
        return $this->successResponse(
            [
                'data' => $sections,
            ],
            'Groups and sections are fetched successfully!!',
        );
    }

    // Fetch Section Questions::Retrieves a specific resource section by ID along with all its related section questions and their dependent questions (if any). Ensures the section exists and returns a structured JSON response with validation and success status.
    // public function getSectionQuestions()
    // {
    //     $sections = ResourceSection::with([
    //         'sectionQuestions.dependentQuestions',
    //     ])->get();
    //     return $this->successResponse(
    //         [
    //             'data' => $sections,
    //         ],
    //         'Section and Questions are fetched successfully!!',
    //     );
    // }
    public function getSectionQuestions()
    {
        $sections = ResourceSection::with([
            'sectionQuestions.dependentQuestions',
        ])->get();

        // Only return section_id and section_questions
        $formattedSections = $sections->map(function ($section) {
            return [
                'section_id'        => $section->id,
                'section_questions' => $section->sectionQuestions,
            ];
        });

        return $this->successResponse(
            [
                'data' => $formattedSections,
            ],
            'Section and Questions are fetched successfully!!'
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
        $user_id = $request->input('user_id');

        if (! $user_id) {
            return $this->errorResponse('Missing user_id parameter', 400);
        }

        // Get all section entries for this user where status = 1
        $sections = DB::table('create-cvprofilesection')
            ->where('id', $user_id)
            ->where('status', 1)
            ->get();

        if ($sections->isEmpty()) {
            return $this->errorResponse('No active sections found for this user.', 404);
        }

        $sectionResults    = [];
        $processedSections = []; // to track section_id processed

        foreach ($sections as $sectionEntry) {
            $section_id = $sectionEntry->section;

            // Skip if already processed
            if (in_array($section_id, $processedSections)) {
                continue;
            }

            $subsectionIds = json_decode($sectionEntry->subsection, true) ?? [];

            // Get section config
            $sectionConfig = DB::table('resource-section')
                ->where('status', 1)
                ->where('id', $section_id)
                ->first();

            if (! $sectionConfig) {
                continue;
            }

            $sectionTable = $sectionConfig->sectionTable;
            $idColumnName = $sectionConfig->idColumnName;
            $sectionName  = $sectionConfig->sectionName;

            if (! $sectionTable || ! $idColumnName || empty($subsectionIds)) {
                continue;
            }

            // Retrieve section data from the respective table
            $sectionData = DB::table($sectionTable)
            // ->whereIn($idColumnName, $subsectionIds)
                ->where('id', $user_id)
                ->where('status', 1)
                ->get();

            $sectionResults[] = [
                'section_id'   => $section_id,
                'section_name' => $sectionName,
                'data'         => $sectionData,
            ];

            // Mark this section_id as processed
            $processedSections[] = $section_id;
        }

        return response()->json([
            'status'   => 'success',
            'user_id'  => $user_id,
            'sections' => $sectionResults,
        ]);
    }

    public function addData(Request $request)
    {
        $user_id    = $request->input('user_id');
        $section_id = $request->input('section_id');
        $profile_id = $request->input('profile_id');

        if (! $user_id || ! $section_id || ! $profile_id) {
            return $this->errorResponse('Missing parameters', 400);
        }

        // Step 1: Get section table name
        $section = DB::table('resource-section')->where('id', $section_id)->first();

        if (! $section) {
            return $this->errorResponse('Section not found.', 404);
        }

        $sectionTable = $section->sectionTable;
        $idColumnName = $section->idColumnName;
        $section_name = $section->sectionName;

        if (! $sectionTable || ! $idColumnName) {
            return $this->errorResponse('Section configuration is incomplete.', 400);
        }

        // Step 2: Get valid question_column_names mapping (sectionquestionid => question_column_name)
        $sectionquestionids = DB::table('section_questions')->select('sectionquestionid')

            ->where('resource_section_id', $section_id)->get()->pluck('sectionquestionid')
            ->filter(fn($name) => ! is_null($name) && trim($name) !== '')->values()->toArray();

        $questionColumnNamesAssoc = DB::table('section_questions')->whereIn('sectionquestionid', $sectionquestionids)->whereNotNull('question_column_name')->whereRaw("TRIM(question_column_name) != ''")->pluck('question_column_name', 'sectionquestionid')->toArray();

        // Step 3: Build dynamic section_data from input data array
        $inputData       = $request->input('data', []);
        $section_data    = [];
        $multiInsertRows = [];

        foreach ($questionColumnNamesAssoc as $sectionquestionid => $columnName) {
            $value                     = $inputData[$sectionquestionid] ?? null;
            $section_data[$columnName] = $value;
        }

        $insertedIds = [];

        if (! empty($multiInsertRows)) {
            foreach ($multiInsertRows as $row) {
                $insertedIds[] = DB::table($sectionTable)->insertGetId($row, $idColumnName);
            }
            $recordId = $insertedIds;
            $action   = 'inserted';
        } else {
            $section_data['id'] = $user_id;
            $recordId           = DB::table($sectionTable)->insertGetId($section_data, $idColumnName);

            $action = 'inserted';
        }

        $existingCvProfileSection = DB::table('create-cvprofilesection')
            ->where('cvid', $profile_id)
            ->where('section', $section_id)
            ->where('id', $user_id)
            ->where('status', 1)->first();

        $newRecordIds   = is_array($recordId) ? $recordId : [$recordId];
        $newRecordIds   = array_map('strval', $newRecordIds);
        $subsectionData = json_encode(array_map('strval', is_array($recordId) ? $recordId : [$recordId]));
        if ($existingCvProfileSection && $section->defaultsection == 1) {
            return $this->errorResponse('Data already Available.', 400);
        }

        if ($existingCvProfileSection && $section->defaultsection == 0) {
            $existingSubsection = json_decode($existingCvProfileSection->subsection, true) ?? [];
            $existingSubsection = array_map('strval', $existingSubsection);
            $mergedSubsection   = array_unique(array_merge($existingSubsection, $newRecordIds));

            DB::table('create-cvprofilesection')
                ->where('cvid', $profile_id)
                ->where('section', $section_id)
                ->where('id', $user_id)
                ->where('status', 1)
                ->update([
                    'subsection' => json_encode($mergedSubsection),
                    'showName'   => $section_name,
                ]);
        } else {
            DB::table('create-cvprofilesection')->insert([
                'cvid'       => $profile_id,
                'section'    => $section_id,
                'id'         => $user_id,
                'subsection' => json_encode($newRecordIds),
                'showName'   => $section_name,
            ]);
            //dd($existingCvProfileSection);
        }

        return response()->json([
            'status'        => 'success',
            'message'       => "Data {$action} successfully.",
            'record_id'     => $recordId,
            'section_table' => $sectionTable,
            'section_data'  => $section_data,
        ]);
    }

    public function getUserSectionDetailsUpdate(Request $request)
    {
        $user_id       = $request->input('user_id');
        $section_id    = $request->input('section_id');
        $subSection_id = $request->input('subSection_id');
        $refID         = $request->input('refID');

        //dd($user_id, $section_id, $subSection_id);

        if (! $user_id || ! $section_id || ! $subSection_id) {
            return $this->errorResponse('Missing parameters', 400);
        }

        // Step 1: Get section table config
        $section = DB::table('resource-section')->where('id', $section_id)->first();

        if (! $section) {
            return $this->errorResponse('Section not found.', 404);
        }

        $sectionTable = $section->sectionTable;
        $idColumnName = $section->idColumnName;

        if (! $sectionTable || ! $idColumnName) {
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
        $inputData  = $request->input('data', []);
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
        //->where($idColumnName, $subSection_id)
            ->where('id', $user_id)
            ->where('refID', $refID)
            ->where('status', 1)
            ->update($updateData);
//dd( $updated);
        if ($updated) {
            return response()->json([
                'status'         => 'success',
                'message'        => 'Section data updated successfully.',
                'section_table'  => $sectionTable,
                'sub_section_id' => $subSection_id,
                'updated_fields' => $updateData,
            ]);
        } else {
            return $this->errorResponse('Changes are done already!!!', 500);
        }
    }

    public function getUserSectionDetailsSoftDelete(Request $request)
    {
        $user_id    = $request->input('user_id');
        $profile_id = $request->input('profile_id');
        $section_id = $request->input('section_id');

        if (! $user_id || ! $profile_id || ! $section_id) {
            return response()->json(['status' => 'error', 'message' => 'Missing parameters'], 400);
        }

        // Step 1: Get section table info
        $section = DB::table('resource-section')->where('id', $section_id)->first();

        if (! $section) {
            return response()->json(['status' => 'error', 'message' => 'Section not found'], 404);
        }

        $sectionTable = $section->sectionTable;
        $idColumnName = $section->idColumnName;

        if (! $sectionTable || ! $idColumnName) {
            return response()->json(['status' => 'error', 'message' => 'Section configuration incomplete'], 400);
        }

        // Step 2: Get primary keys to soft-delete
        $primaryKeys = DB::table($sectionTable)
            ->where('id', $user_id)
            ->where('status', 1)
            ->where('refID', $request->input('refID'))
            ->pluck($idColumnName)
            ->map(function ($item) {
                return (string) $item;
            })
            ->toArray();

        if (empty($primaryKeys)) {
            return response()->json(['status' => 'error', 'message' => 'No matching section entries found'], 404);
        }

        // Step 4: Load profile section
        $profileSection = DB::table('create-cvprofilesection')
            ->where('cvid', $profile_id)
            ->where('section', $section_id)
            ->where('id', $user_id)
            ->where('status', 1)
            ->first();

        if (! $profileSection) {
            return response()->json(['status' => 'error', 'message' => 'Profile section not found'], 404);
        }

        $subsections = json_decode($profileSection->subsection, true) ?? [];

        // Step 5: Remove primary keys from subsection array
        $subsections = array_filter($subsections, function ($id) use ($primaryKeys) {
            return ! in_array((string) $id, $primaryKeys, true);
        });

        // Re-index array
        $subsections = array_values($subsections);

        // Step 6: Update create-cvprofilesection
        DB::table('create-cvprofilesection')
            ->where('psid', $profileSection->psid)
            ->update([
                'subsection' => json_encode($subsections),
            ]);

        return response()->json([
            'status'  => 'success',
            'message' => 'Section entry marked removed from profile section.',
        ]);

    }

    public function getUserSectionDetailsHardDelete(Request $request)
    {
        $user_id    = $request->input('user_id');
        $profile_id = $request->input('profile_id');
        $section_id = $request->input('section_id');

        if (! $user_id || ! $profile_id || ! $section_id) {
            return response()->json(['status' => 'error', 'message' => 'Missing parameters'], 400);
        }

        // Step 1: Get section table info
        $section = DB::table('resource-section')->where('id', $section_id)->first();

        if (! $section) {
            return response()->json(['status' => 'error', 'message' => 'Section not found'], 404);
        }

        $sectionTable = $section->sectionTable;
        $idColumnName = $section->idColumnName;

        if (! $sectionTable || ! $idColumnName) {
            return response()->json(['status' => 'error', 'message' => 'Section configuration incomplete'], 400);
        }

        // Step 2: Get primary keys to soft-delete
        $primaryKeys = DB::table($sectionTable)
            ->where('id', $user_id)
            ->where('status', 1)
            ->where('refID', $request->input('refID'))
            ->pluck($idColumnName)
            ->map(function ($item) {
                return (string) $item;
            })
            ->toArray();

        if (empty($primaryKeys)) {
            return response()->json(['status' => 'error', 'message' => 'No matching section entries found'], 404);
        }

        // Step 3: Soft delete in section table (status = 0)
        DB::table($sectionTable)
            ->where('id', $user_id)
            ->where('status', 1)
            ->where('refID', $request->input('refID'))
            ->update(['status' => 0]);

        // Step 4: Load profile section
        $profileSection = DB::table('create-cvprofilesection')
            ->where('cvid', $profile_id)
            ->where('section', $section_id)
            ->where('id', $user_id)
            ->where('status', 1)
            ->first();

        if (! $profileSection) {
            return response()->json(['status' => 'error', 'message' => 'Profile section not found'], 404);
        }

        $subsections = json_decode($profileSection->subsection, true) ?? [];

        // Step 5: Remove primary keys from subsection array
        $subsections = array_filter($subsections, function ($id) use ($primaryKeys) {
            return ! in_array((string) $id, $primaryKeys, true);
        });

        // Re-index array
        $subsections = array_values($subsections);

        // Step 6: Update create-cvprofilesection
        DB::table('create-cvprofilesection')
            ->where('psid', $profileSection->psid)
            ->update([
                'subsection' => json_encode($subsections),
            ]);

        return response()->json([
            'status'  => 'success',
            'message' => 'Subsection deleted successfully.',

        ]);
    }
}
