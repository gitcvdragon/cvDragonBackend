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

    // public function urlImport(string $url): array
    // {
    //     $response = Http::get($url);
    //     return $response->json() ?? [];
    // }

    // public function urlExport(array $data): string
    // {
    //     return urlencode(json_encode($data));
    // }

    // public function sendWelcomeEmail(string $fullName, ?string $email, string $id, string $authkey): void
    // {
    //     if (!$email) return;

    //     $contents = $this->urlExport([
    //         'name' => $fullName,
    //         'email' => $email
    //     ]);

    //     $url = config('services.email.url') . "?id={$id}&authkey={$authkey}&data=registration&contents={$contents}";

    //     Http::get($url);
    // }

    // public function sendWelcomeWhatsApp(string $fullName, string $countryCode, ?string $phoneNumber, string $id): void
    // {
    //     if (!$phoneNumber) return;

    //     $fullWAData = [
    //         'phoneNumber' => $countryCode . $phoneNumber,
    //         'userName' => $fullName,
    //         'headerImage' => 'https://cvdragon.com/data/facebook/resources/whycvDragon.jpg',
    //     ];

    //     $contents = $this->urlExport($fullWAData);

    //     $url = config('services.whatsapp.url') . "?entryID=105486032380156&id={$id}&authkey=1&WATemplate=welcomemessage&contents={$contents}";

    //     Http::get($url);
    // }

   
}
