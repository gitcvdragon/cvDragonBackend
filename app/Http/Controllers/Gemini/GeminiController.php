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
        $limit = $request->input('limit') ?? 50;
        $offset = $request->input('offset') ?? 0;
        $userId = auth()->user()->id;

        // Fetch active prompt
        $promptRow = DB::table('prompts')
            ->where('keyphrases_sn', $keyphrasesSn)
            ->where('status', 1)
            ->first();

        // Fetch existing skills
        $existingSkills = DB::table('keyphrasesdetails')
            ->where('keyphrases_sn', $keyphrasesSn)
            ->pluck('keyphrase_value')
            ->toArray();

        $existingSkillsCount = count($existingSkills);
        $neededSkills = ($offset + $limit) - $existingSkillsCount;

        if ($promptRow && $neededSkills > 0) {
            // Fetch candidate details
            $details = DB::table('user-basic')
                ->where('id', $userId)
                ->first();

            // Build AI prompt
            $aiPrompt = $promptRow->prompt_text . "\n\nCandidate Details:\n";
            $aiPrompt .= !empty($details->wizardWorkExp)
                ? "Work Experience: " . $details->wizardWorkExp . "\n" : "";
            $aiPrompt .= !empty($details->wizardEducationProfile)
                ? "Education Profile: " . $details->wizardEducationProfile . "\n" : "";
            $aiPrompt .= !empty($details->wizardWorkProfile)
                ? "Work Profile (Wizard): " . $details->wizardWorkProfile . "\n" : "";
            $aiPrompt .= !empty($details->wizardEducationSpecialization)
                ? "Education Specialization: " . $details->wizardEducationSpecialization . "\n" : "";
            $aiPrompt .= !empty($details->wizardWorkSpecialization)
                ? "Work Specialization: " . $details->wizardWorkSpecialization . "\n" : "";
            $aiPrompt .= $promptRow->return_data_structure;

            // Call Gemini API
            $response = Http::withHeaders([
                'Content-Type' => 'application/json',
                'X-Goog-Api-Key' => env('GEMINI_API_KEY'),
            ])->post(
                'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent',
                [
                    "contents" => [
                        [
                            "parts" => [
                                ["text" => $aiPrompt]
                            ]
                        ]
                    ]
                ]
            );

            $json = $response->json();
            $text = trim($json['candidates'][0]['content']['parts'][0]['text'] ?? '');

            // Store raw prompt + response and get inserted ID
            $insertedId = DB::table('ai_prompts_deatils')->insertGetId([
                'keyphrase_id' => $keyphrasesSn,
                'prompt_text'  => $aiPrompt,
                'ai_response'  => $text,
                'created_at'   => now(),
                'updated_at'   => now(),
            ]);

            // Extract JSON from AI response
            $start = strpos($text, '{');
            $end = strrpos($text, '}');

            if ($start !== false && $end !== false && $end > $start) {
                $jsonText = substr($text, $start, $end - $start + 1);
                $decoded = json_decode($jsonText, true);

                if (is_array($decoded) && isset($decoded['skills']) && is_array($decoded['skills'])) {
                    // Update the AI response with pretty JSON
                    DB::table('ai_prompts_deatils')
                        ->where('id', $insertedId)
                        ->update([
                            'ai_response' => json_encode($decoded, JSON_PRETTY_PRINT),
                            'updated_at'  => now(),
                        ]);

                    // Insert individual skills into keyphrasesdetails
                    foreach ($decoded['skills'] as $skill) {
                        $skill = trim($skill);
                        if ($skill && !in_array($skill, $existingSkills)) {
                            DB::table('keyphrasesdetails')->insert([
                                'keyphrases_sn'   => $keyphrasesSn,
                                'course'          => $details->wizardEducationSpecialization ?? null,
                                'specialization'  => $details->wizardEducationSpecialization ?? null,
                                'work_industry'   => $details->wizardWorkProfile ?? null,
                                'work_profile'    => $details->wizardWorkSpecialization ?? null,
                                'year'            => $details->wizardWorkExp ?? null,
                                'keyphrase_value' => $skill,
                                'keyphrase_status'=> 1,
                                'created_at'      => now(),
                            ]);
                            $existingSkills[] = $skill;
                        }
                    }
                }
            }
        }

        // Apply limit + offset
        $paginatedSkills = DB::table('keyphrasesdetails')
            ->where('keyphrases_sn', $keyphrasesSn)
            ->orderBy('sn')
            ->skip($offset)
            ->take($limit)
            ->pluck('keyphrase_value')
            ->toArray();

        return response()->json([
            'keyphrases_sn' => $keyphrasesSn,
            'skills' => $paginatedSkills,
            'source' => 'ai'
        ]);
    }
}
