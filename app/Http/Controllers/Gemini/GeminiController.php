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

        // Fetch active prompt
        $promptRow = DB::table('prompts')
            ->where('keyphrases_sn', $keyphrasesSn)
            ->where('status', 1)
            ->first();

        // Fetch all existing skills
        $existingSkills = DB::table('keyphrasesdetails')
            ->where('keyphrases_sn', $keyphrasesSn)
            ->pluck('keyphrase_value')
            ->toArray();

        $existingSkillsCount = count($existingSkills);
        $neededSkills = ($offset + $limit) - $existingSkillsCount;

        // Call AI only if we need more skills
        if ($promptRow && $neededSkills > 0) {
            $details = DB::table('keyphrasesdetails')
                ->where('keyphrases_sn', $keyphrasesSn)
                ->first();

            $aiPrompt = $promptRow->prompt_text . "\n\n";
            $aiPrompt .= "Candidate Details:\n";
            $aiPrompt .= "Course: " . ($details->course ?? 'N/A') . "\n";
            $aiPrompt .= "Specialization: " . ($details->specialization ?? 'N/A') . "\n";
            $aiPrompt .= "Work Industry: " . ($details->work_industry ?? 'N/A') . "\n";
            $aiPrompt .= "Work Profile: " . ($details->work_profile ?? 'N/A') . "\n";
            $aiPrompt .= "Year: " . ($details->year ?? 'N/A') . "\n";
            $aiPrompt .= $promptRow->return_data_structure;

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
            $text = $json['candidates'][0]['content']['parts'][0]['text'] ?? '';
            $text = trim($text);

            // Extract JSON between first { and last }
            $start = strpos($text, '{');
            $end = strrpos($text, '}');

            if ($start !== false && $end !== false && $end > $start) {
                $jsonText = substr($text, $start, $end - $start + 1);
                $decoded = json_decode($jsonText, true);

                if (is_array($decoded) && isset($decoded['skills']) && is_array($decoded['skills'])) {
                    foreach ($decoded['skills'] as $skill) {
                        $skill = trim($skill);
                        if ($skill && !DB::table('keyphrasesdetails')
                            ->where('keyphrases_sn', $keyphrasesSn)
                            ->where('keyphrase_value', $skill)
                            ->exists()
                        ) {
                            DB::table('keyphrasesdetails')->insert([
                                'keyphrases_sn'   => $keyphrasesSn,
                                'course'          => $details->course ?? null,
                                'specialization'  => $details->specialization ?? null,
                                'work_industry'   => $details->work_industry ?? null,
                                'work_profile'    => $details->work_profile ?? null,
                                'year'            => $details->year ?? null,
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
