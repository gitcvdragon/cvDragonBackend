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
        $query = $request->input('q', null);

        // Step 0: Fetch prompt from the prompts table
        $promptRow = DB::table('prompts')
            ->where('keyphrases_sn', $keyphrasesSn)
            ->where('is_active', 1)
            ->first();

        // Step 1: Check DB for existing skills
        $existingSkills = DB::table('keyphrasesdetails')
            ->where('keyphrases_sn', $keyphrasesSn)
            ->pluck('keyphrase_value')
            ->filter()
            ->toArray();

        // If no active prompt, return only DB values
        if (!$promptRow) {
            return response()->json([
                'keyphrases_sn' => $keyphrasesSn,
                'skills' => $existingSkills,
                'source' => 'database_only'
            ]);
        }

        // If already 20+ skills in DB, return them
        if (count($existingSkills) >= 20) {
            return response()->json([
                'keyphrases_sn' => $keyphrasesSn,
                'skills' => $existingSkills,
                'source' => 'database'
            ]);
        }

        // Step 2: Build AI prompt
        $aiPrompt = $promptRow->prompt_text;
        if ($query) {
            $aiPrompt .= "\n\nText to extract skills from: \"$query\"";
        }

        // Call Gemini AI
        $response = Http::withHeaders([
            'Content-Type' => 'application/json',
            'X-Goog-Api-Key' => env('GEMINI_API_KEY'),
        ])->post('https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent', [
            "contents" => [
                [
                    "parts" => [
                        ["text" => $aiPrompt]
                    ]
                ]
            ]
        ]);

        $json = $response->json();

        $skills = [];
        if (isset($json['candidates'][0]['content']['parts'][0]['text'])) {
            $text = $json['candidates'][0]['content']['parts'][0]['text'];
            $skills = json_decode($text, true) ?? [$text]; // fallback if JSON fails
        }

        // Step 3: Insert new skills into DB (skip duplicates)
        foreach ($skills as $skill) {
            if (!in_array($skill, $existingSkills)) {
                DB::table('keyphrasesdetails')->insert([
                    'keyphrases_sn'   => $keyphrasesSn,
                    'course'          => null,
                    'specialization'  => null,
                    'work_industry'   => null,
                    'work_profile'    => null,
                    'year'            => null,
                    'keyphrase_value' => $skill,
                    'keyphrase_status'=> 1,
                    'created_at'      => now(),
                ]);
            }
        }

        return response()->json([
            'keyphrases_sn' => $keyphrasesSn,
            'skills' => $skills,
            'source' => 'ai'
        ]);
    }
}
