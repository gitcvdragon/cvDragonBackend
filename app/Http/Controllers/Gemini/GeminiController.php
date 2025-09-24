<?php

namespace App\Http\Controllers\Gemini;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Services\GeminiService;

class GeminiController extends Controller
{
    protected $gemini;

    public function __construct(GeminiService $gemini)
    {
        $this->gemini = $gemini;
    }

    public function search(Request $request)
    {
        $query = $request->input('query');

        if (!$query) return response()->json(['error' => 'Query is required'], 400);

        $result = $this->gemini->query($query);
        return response()->json($result);
    }
}
