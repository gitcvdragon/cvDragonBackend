<?php

namespace App\Services;

use Google\Auth\Credentials\ServiceAccountCredentials;
use Illuminate\Support\Facades\Http;

class GeminiService
{
    protected $projectId;
    protected $location;
    protected $model;
    protected $keyFile;

    public function __construct()
    {
        $this->projectId = env('GEMINI_PROJECT_ID');
        $this->location = env('GEMINI_LOCATION', 'us-central1');
        $this->model = env('GEMINI_MODEL', 'gemini-1.5-t');
        $this->keyFile = storage_path('app/gemini-key.json');
    }

    protected function getAccessToken()
    {
        $credentials = new ServiceAccountCredentials(
            null,
            [
                'keyFile' => $this->keyFile,
                'scopes' => ['https://www.googleapis.com/auth/cloud-platform'],
            ]
        );

        $token = $credentials->fetchAuthToken();
        return $token['access_token'] ?? null;
    }

    public function query($prompt, $maxTokens = 300, $temperature = 0.7)
    {
        $accessToken = $this->getAccessToken();
        if (!$accessToken) return ['error' => 'Unable to fetch access token'];

        $url = "https://{$this->location}-aiplatform.googleapis.com/v1/projects/{$this->projectId}/locations/{$this->location}/publishers/google/models/{$this->model}:predict";

        $response = Http::withHeaders([
            'Authorization' => 'Bearer ' . $accessToken,
            'Content-Type' => 'application/json',
        ])->post($url, [
            "instances" => [["prompt" => $prompt]],
            "parameters" => [
                "temperature" => $temperature,
                "maxOutputTokens" => $maxTokens
            ]
        ]);

        return $response->successful() ? $response->json() : ['error' => $response->body()];
    }
}
