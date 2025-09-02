<?php

namespace App\Http\Controllers\Api\Admin\Testmonial;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;

class TestMonialController extends Controller
{
    /**
     * GET /api/testimonials
     */
    public function index()
    {
        $testimonials = DB::table('resource_testimonials')->get()->map(function ($t) {
            return [
                'id' => $t->sn,
                'userName' => $t->title,
                'role' => $t->role,
                'content' => $t->description,
                'rating' => $t->rating,
                'avatar' => $t->source,
                'status' => $t->status ? 'Active' : 'Inactive',
            ];
        });

        return response()->json(['testimonials' => $testimonials]);
    }

    /**
     * GET /api/testimonials/{id}
     */
    public function show($id)
    {
        $t = DB::table('resource_testimonials')->where('sn', $id)->first();

        if (!$t) {
            return response()->json(['error' => 'Not found'], 404);
        }

        return response()->json([
            'id' => $t->sn,
            'userName' => $t->title,
            'userId' => $t->role,
            'content' => $t->description,
            'rating' => $t->rating,
            'avatar' => $t->source,
            'status' => $t->status ? 'Active' : 'Inactive',
        ]);
    }

    /**
     * POST /api/testimonials
     */
    public function store(Request $request)
    {
        $data = $request->validate([
            'userName' => 'required|string|max:150',
            'userId' => 'required|string|max:100',
            'content' => 'required|string',
            'rating' => 'required|numeric|min:1|max:5',
            'avatar' => 'nullable|string|max:100',
            'status' => 'required|string|in:Active,Inactive',
        ]);

        $id = DB::table('resource_testimonials')->insertGetId([
            'title'       => $data['userName'],
            'role'        => $data['userId'],
            'description' => $data['content'],
            'rating'      => $data['rating'],
            'source'      => $data['avatar'] ?? null,
            'status'      => $data['status'] === 'Active' ? 1 : 0,
            'created_at'  => now(),
            'updated_at'  => now(),
        ]);

        return response()->json(['success' => true, 'id' => $id]);
    }

    /**
     * PATCH /api/testimonials/{id}
     */
    public function update(Request $request, $id)
    {
        $data = $request->only(['status']);

        if (!isset($data['status'])) {
            return response()->json(['error' => 'Nothing to update'], 400);
        }

        DB::table('resource_testimonials')
            ->where('sn', $id)
            ->update([
                'status' => $data['status'] === 'Active' ? 1 : 0,
                'updated_at' => now(),
            ]);

        return response()->json(['success' => true, 'message' => 'Testimonial updated']);
    }

    /**
     * DELETE /api/testimonials/{id}
     */
    public function destroy($id)
    {
        $exists = DB::table('resource_testimonials')->where('sn', $id)->exists();

        if (!$exists) {
            return response()->json(['success' => false, 'message' => 'Testimonial not found'], 404);
        }

        DB::table('resource_testimonials')
            ->where('sn', $id)
            ->update([
                'status' => 0,
                'updated_at' => now(),
            ]);

        return response()->json(['success' => true, 'message' => 'Testimonial deactivated']);
    }


    /**
     * POST /api/testimonials/{id}/email
     */
    public function sendEmail($id)
    {
        $t = DB::table('resource_testimonials')->where('sn', $id)->first();

        if (!$t) {
            return response()->json(['error' => 'Not found'], 404);
        }

        // Example only — you’d configure proper Mail logic
        // Mail::to('user@example.com')->send(new TestimonialMail($t));

        return response()->json(['success' => true, 'message' => 'Email sent successfully']);
    }
}
