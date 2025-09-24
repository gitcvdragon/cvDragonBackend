<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;

class GeminiService
{
    protected $apiKey;
    protected $apiUrl;

    public function __construct()
    {
        $this->apiKey = env('GEMINI_API_KEY');
        $this->apiUrl = env('GEMINI_API_URL');
    }

    /**
     * Send a query to Gemini API
     */
    public function query($prompt, $maxTokens = 300)
    {
        $response = Http::withHeaders([
            'Authorization' => 'Bearer ' . $this->apiKey,
            'Content-Type' => 'application/json',
        ])->post($this->apiUrl, [
            'prompt' => $prompt,
            'maxOutputTokens' => $maxTokens,
        ]);

        if ($response->successful()) {
            return $response->json();
        }

        return [
            'error' => $response->body()
        ];
    }
}
