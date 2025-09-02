<?php

namespace App\Http\Controllers\Api\Admin\Feedback;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;

class FeedbackController extends Controller
{
    public function index()
    {
        $feedback = DB::table('user-feedback')->get()->map(function ($f) {
            return [
                'id'       => $f->feedbackid,
                'userName' => $f->userName,
                'userId'   => $f->id,
                'rating'   => $f->rating,
                'date'     => $f->dateCreated,
                'content'  => $f->feedback,
                'status'   => $f->status ? 'Active' : 'Inactive',
            ];
        });

        return response()->json(['feedback' => $feedback]);
    }

    public function show($id)
    {
        $f = DB::table('user-feedback')->where('feedbackid', $id)->first();

        if (!$f) {
            return response()->json(['error' => 'Not found'], 404);
        }

        return response()->json([
            'id'         => $f->feedbackid,
            'name'       => $f->userName,
            'role'       => $f->id,
            'testimonial'=> $f->feedback,
            'rating'     => $f->rating,
            'date'       => $f->dateCreated,
            'status'     => $f->status ? 'Active' : 'Inactive',
            'avatar'     => '/assets/avatar.svg'
        ]);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'name'    => 'required|string|max:100',
            'userId'  => 'required|string|max:50',
            'content' => 'required|string',
            'rating'  => 'required|numeric|min:1|max:5',
            'date'    => 'required|date',
            'status'  => 'required|string|in:Active,Inactive',
        ]);

        $id = DB::table('user-feedback')->insertGetId([
            'userName'    => $data['name'],
            'id'          => $data['userId'],
            'feedback'    => $data['content'],
            'rating'      => $data['rating'],
            'dateCreated' => $data['date'],
            'status'      => $data['status'] === 'Active' ? 1 : 0,
        ]);

        return response()->json(['success' => true, 'id' => $id]);
    }

    public function update(Request $request, $id)
    {
        $data = $request->only(['status']);

        if (!isset($data['status'])) {
            return response()->json(['error' => 'Nothing to update'], 400);
        }

        DB::table('user-feedback')
            ->where('feedbackid', $id)
            ->update([
                'status'     => $data['status'] === 'Active' ? 1 : 0,
                'dateResolved' => now(),
            ]);

        return response()->json(['success' => true, 'message' => 'Feedback updated']);
    }

    public function destroy($id)
    {
        $exists = DB::table('user-feedback')->where('feedbackid', $id)->exists();

        if (!$exists) {
            return response()->json(['success' => false, 'message' => 'Feedback not found'], 404);
        }

        DB::table('user-feedback')
            ->where('feedbackid', $id)
            ->update([
                'status' => 0,
                'dateResolved' => now(),
            ]);

        return response()->json(['success' => true, 'message' => 'Feedback deleted']);
    }

    public function sendEmail($id)
    {
        $f = DB::table('user-feedback')->where('feedbackid', $id)->first();

        if (!$f) {
            return response()->json(['error' => 'Not found'], 404);
        }

        // Example only — replace with real mail logic
        // Mail::to($f->userEmail)->send(new FeedbackMail($f));

        return response()->json(['success' => true, 'message' => 'Email sent successfully']);
    }
}
