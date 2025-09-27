<?php

namespace App\Http\Controllers\Gemini;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;

class GeminiController extends Controller
{
    public function generate(Request $request)
{
    $keyphrasesSn = $request->input('keyphrases_sn');
    $limit        = $request->input('limit', 50);
    $offset       = $request->input('offset', 0);
    $userId       = auth()->user()->id;

    if (!$keyphrasesSn) {
        return response()->json(['error' => 'Missing keyphrases_sn'], 400);
    }

    // Fetch prompt
    $promptRow = DB::table('prompts')
        ->where('keyphrases_sn', $keyphrasesSn)
        ->where('status', 1)
        ->first();

    if (!$promptRow) {
        return response()->json(['error' => 'Prompt not found'], 404);
    }

    $promptType = $promptRow->prompt_name;

    // Specialization prompts handled separately
    if ($promptType === 'specialization') {
        $selectedKey = $request->input('key'); // course name
        if (!$selectedKey) {
            return response()->json(['error' => 'Missing key (course) for specialization'], 400);
        }
        return $this->generateSpecialization($request->merge(['key' => $selectedKey]));
    }

    // Fetch existing items from DB
    $existingItems = DB::table('keyphrasesdetails')
        ->where('keyphrases_sn', $keyphrasesSn)
        ->pluck('keyphrase_value')
        ->toArray();

    $existingCount = count($existingItems);
    $neededCount   = ($offset + $limit) - $existingCount;

    // Fetch candidate details if needed
    $details = $promptRow->need_userdetails
        ? DB::table('user-basic')->where('id', $userId)->first()
        : null;

    // Only call AI if more items are needed
    if ($neededCount > 0) {
        // Handle extra params dynamically
        $extraParams = [];
        if (!empty($promptRow->params)) {
            $keys = array_map('trim', explode(',', $promptRow->params));
            foreach ($keys as $key) {
                if ($request->has($key)) {
                    $extraParams[$key] = $request->input($key);
                } else {
                    // fallback: try fetch from keyphrasesdetails
                    $record = DB::table('keyphrasesdetails')
                        ->where('keyphrases_sn', $keyphrasesSn)
                        ->whereNotNull($key)
                        ->first();
                    if ($record) {
                        $extraParams[$key] = $record->{$key};
                    }
                }
            }
        }

        // Build AI prompt
        $aiPrompt = $this->buildAiPrompt($promptRow, $details, $extraParams);

        // Call Gemini AI
        $text = $this->callGemini($aiPrompt);
//dd( $text);
        // Store raw AI prompt + response
        $insertedId = DB::table('ai_prompts_deatils')->insertGetId([
            'keyphrase_id' => $keyphrasesSn,
            'prompt_text'  => $aiPrompt,
            'ai_response'  => $text,
            'created_at'   => now(),
            'updated_at'   => now(),
        ]);

        // Decode AI JSON
        $decoded = $this->extractJson($text);

        if ($decoded && isset($decoded[$promptType]) && is_array($decoded[$promptType])) {
			//dd('yes');
            $this->storeAiItems($decoded[$promptType], $keyphrasesSn, $details, $promptType, $extraParams);

            // Update pretty JSON
            DB::table('ai_prompts_deatils')
                ->where('id', $insertedId)
                ->update([
                    'ai_response' => json_encode($decoded, JSON_PRETTY_PRINT),
                    'updated_at'  => now(),
                ]);
        }
    }

    // Fetch paginated items (from DB, now including AI-generated)
    $query = DB::table('keyphrasesdetails')
        ->where('keyphrases_sn', $keyphrasesSn)
        ->whereNotNull('keyphrase_value');

    // Apply extra params as filters
    foreach (!empty($extraParams) ? $extraParams : [] as $key => $value) {
        $query->where(strtolower($key), $value);
    }

    $paginated = $query->orderBy('sn')
        ->skip($offset)
        ->take($limit)
        ->pluck('keyphrase_value')
        ->toArray();

    return response()->json([
        'keyphrases_sn' => $keyphrasesSn,
        $promptType     => $paginated,
        'source'        => $neededCount > 0 ? 'ai' : 'db'
    ]);
}


    private function buildAiPrompt($promptRow, $details = null, $params = [])
    {
        $prompt = $promptRow->prompt_text;

        // Include candidate details if needed
        if ($details) {
            $fields = [
                'wizardWorkExp' => 'Work Experience',
                'wizardEducationProfile' => 'Education Profile',
                'wizardWorkProfile' => 'Work Profile',
                'wizardEducationSpecialization' => 'Education Specialization',
                'wizardWorkSpecialization' => 'Work Specialization'
            ];
            foreach ($fields as $field => $label) {
                if (!empty($details->{$field})) {
                    $prompt .= "\n$label: {$details->{$field}}";
                }
            }
        }

        // Include extra params in AI prompt
        foreach ($params as $key => $value) {
            $prompt .= "\n$key: $value";
        }

        $prompt .= "\n" . $promptRow->return_data_structure;
//dd( $prompt );
        return $prompt;
    }

    private function callGemini($prompt)
    {
        $response = Http::withHeaders([
            'Content-Type' => 'application/json',
            'X-Goog-Api-Key' => env('GEMINI_API_KEY'),
        ])->post(
            'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent',
            [
                "contents" => [
                    [
                        "parts" => [["text" => $prompt]]
                    ]
                ]
            ]
        );

        $json = $response->json();
        return trim($json['candidates'][0]['content']['parts'][0]['text'] ?? '');
    }

    private function extractJson($text)
    {
        $start = strpos($text, '{');
        $end   = strrpos($text, '}');
        if ($start !== false && $end !== false && $end > $start) {
            $jsonText = substr($text, $start, $end - $start + 1);
            return json_decode($jsonText, true);
        }
        return null;
    }

    private function storeAiItems(array $items, int $keyphrasesSn, $details, string $promptType, array $params = [])
    {
        $existingItems = DB::table('keyphrasesdetails')
            ->where('keyphrases_sn', $keyphrasesSn)
            ->pluck('keyphrase_value')
            ->toArray();

        foreach ($items as $item) {
            if (is_array($item)) {
                $item = array_values($item)[0] ?? null;
            }
            $item = trim($item);
            if (!$item || in_array($item, $existingItems)) continue;

            $data = [
                'keyphrases_sn'   => $keyphrasesSn,
                'keyphrase_value' => $item,
                'keyphrase_status'=> 1,
                'created_at'      => now(),
            ];

            // Attach candidate details for non-course prompts
            if ($promptType !== 'courses' && $details) {
                $data['course']         = $details->wizardEducationSpecialization ?? null;
                $data['specialization'] = $details->wizardEducationSpecialization ?? null;
                $data['work_industry']  = $details->wizardWorkProfile ?? null;
                $data['work_profile']   = $details->wizardWorkSpecialization ?? null;
                $data['year']           = $details->wizardWorkExp ?? null;
            }

            // Apply extra params for insert
            foreach ($params as $key => $value) {
                $data[strtolower($key)] = $value;
            }

            DB::table('keyphrasesdetails')->insert($data);
            $existingItems[] = $item;
        }
    }


	public function generateSpecialization(Request $request)
{
    $keyphrasesSn = $request->input('keyphrases_sn');
    $offset       = $request->input('offset', 0);
    $limit        = $request->input('limit', 50);
    $selectedKey  = $request->input('key'); // keyphrase_value to find course

    if (!$keyphrasesSn || !$selectedKey) {
        return response()->json(['error' => 'Missing keyphrases_sn or key'], 400);
    }
  $courseName = $selectedKey;

// Fetch existing specializations
$existingSpecializations = DB::table('keyphrasesdetails')
    ->where('keyphrases_sn', $keyphrasesSn)
    ->where('course', $courseName)
    ->whereNotNull('keyphrase_value')
    ->orderBy('sn')
    ->pluck('keyphrase_value')
    ->toArray();

$existingCount = count($existingSpecializations);
$neededCount = ($offset + $limit) - $existingCount;
//dd($neededCount);
if ($neededCount <= 0) {
    // DB has enough data, just return the requested slice
    $paginated = array_slice($existingSpecializations, $offset, $limit);
    return response()->json([
        'keyphrases_sn'   => $keyphrasesSn,
        'course'          => $courseName,
        'specializations' => $paginated,
        'source'          => 'db'
    ]);
}

    // Fetch prompt
    $promptRow = DB::table('prompts')
        ->where('keyphrases_sn', $keyphrasesSn)
        ->where('status', 1)
        ->first();

    if (!$promptRow) {
        return response()->json(['error' => 'Prompt not found'], 404);
    }

    $promptType = $promptRow->prompt_name;

    // Fetch candidate details only if needed
    $details = $promptRow->need_userdetails
        ? DB::table('user-basic')->where('id', auth()->user()->id)->first()
        : null;

    $courseName = $selectedKey;

    // Build AI prompt
    $aiPrompt = $promptRow->prompt_text;
    if ($promptType === 'specialization') {
        $aiPrompt .= "\nCourse: $courseName";
    }

    if ($details) {
        $fields = [
            'wizardWorkExp' => 'Work Experience',
            'wizardEducationProfile' => 'Education Profile',
            'wizardWorkProfile' => 'Work Profile (Wizard)',
            'wizardEducationSpecialization' => 'Education Specialization',
            'wizardWorkSpecialization' => 'Work Specialization'
        ];
        foreach ($fields as $field => $label) {
            if (!empty($details->{$field})) {
                $aiPrompt .= "\n$label: {$details->{$field}}";
            }
        }
    }

    $aiPrompt .= "\n" . $promptRow->return_data_structure;

    // Call Gemini API
    $text = $this->callGemini($aiPrompt);

    // Store raw AI prompt + response
    $insertedId = DB::table('ai_prompts_deatils')->insertGetId([
        'keyphrase_id' => $keyphrasesSn,
        'prompt_text'  => $aiPrompt,
        'ai_response'  => $text,
        'created_at'   => now(),
        'updated_at'   => now(),
    ]);

    // Decode JSON
    $decoded = $this->extractJson($text);
//dd($decoded);
    if ($decoded && isset($decoded['specializations']) && is_array($decoded['specializations'])) {
        $this->storeSpecializations($decoded['specializations'], $keyphrasesSn, $courseName);

        // Update pretty JSON
        DB::table('ai_prompts_deatils')
            ->where('id', $insertedId)
            ->update([
                'ai_response' => json_encode($decoded, JSON_PRETTY_PRINT),
                'updated_at'  => now(),
            ]);
    }

    // Fetch and return only specializations for that course
    $paginated = DB::table('keyphrasesdetails')
        ->where('keyphrases_sn', $keyphrasesSn)
        ->where('course', $courseName)
        ->whereNotNull('keyphrase_value')
        ->orderBy('sn')
        ->skip($offset)
        ->take($limit)
        ->pluck('keyphrase_value')
        ->toArray();
//dd( $courseName);
    return response()->json([
        'keyphrases_sn'   => $keyphrasesSn,
        'course'          => $courseName,
        'specializations' => $paginated,
        'source'          => 'ai'
    ]);
}

/**
 * Store specialization items with course info
 */
private function storeSpecializations(array $items, int $keyphrasesSn, string $course)
{
    $existingItems = DB::table('keyphrasesdetails')
        ->where('keyphrases_sn', $keyphrasesSn)
        ->where('course', $course)
        ->pluck('keyphrase_value')
        ->toArray();

    foreach ($items as $item) {
        if (is_array($item)) {
            $item = array_values($item)[0] ?? null;
        }

        $item = trim($item);
        if (!$item || in_array($item, $existingItems)) continue;

        DB::table('keyphrasesdetails')->insert([
            'keyphrases_sn'   => $keyphrasesSn,
            'course'          => $course,
            'keyphrase_value' => $item,
            'keyphrase_status'=> 1,
            'created_at'      => now(),
        ]);

        $existingItems[] = $item;
    }
}


}
