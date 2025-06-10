<?php

namespace App\Services;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;

class UserService
{
    public function getSectionsByType(int $type): array
    {
        $baseSections = [
            "51099", "51100", "51101", "51102", "51103", "51106",
            "51108", "51109", "51110", "51111", "51114", "51118",
            "51119", "51120", "51121", "51123"
        ];

        return match ($type) {
            1 => $baseSections,
            2 => array_merge($baseSections, ["51123"]),
            3 => array_merge(array_diff($baseSections, ["51106"]), ["51104"]),
            default => [],
        };
    }

    public function urlImport(string $url): array
    {
        $response = Http::get($url);
        return $response->json() ?? [];
    }
}
