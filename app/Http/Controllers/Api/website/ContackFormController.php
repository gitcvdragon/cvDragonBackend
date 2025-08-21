<?php

namespace App\Http\Controllers\Api\website;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Traits\ApiResponseTrait;

class ContackFormController extends Controller
{

    use ApiResponseTrait;

    public function submitContactForm(Request $request)
    {
        try {
            // Validate input
            $validated = $request->validate([
                'name' => 'required|string|max:100',
                'email' => 'required|email|max:100',
                'phone' => 'required|string|max:20',
                'service_id' => 'required|integer|exists:microservice,sn',
                'message' => 'required|string',
            ]);

            // Insert into database using DB facade
            $id = DB::table('contact_us')->insertGetId([
                'name' => $validated['name'],
                'email' => $validated['email'],
                'phone' => $validated['phone'],
                'service_id' => $validated['service_id'],
                'message' => $validated['message'],
                'submitted_at' => now(),
            ]);



            return $this->successResponse(
                // ['user' => $user],
                [],
                'Contact form submitted successfully!'
            );

        } catch (\Exception $e) {
            return $this->errorResponse(
                'Something went wrong! ' . $e->getMessage(),
                500
            );
        }
    }


}
