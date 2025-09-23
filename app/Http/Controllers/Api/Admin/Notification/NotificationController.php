<?php

namespace App\Http\Controllers\Api\Admin\Notification;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class NotificationController extends Controller
{
    /**
     * Get a single notification by ID
     */

     public function index(Request $request)
{
    try {
        // Get limit and offset from request, default values
        $limit = $request->input('limit', 10);   // default 10
        $offset = $request->input('offset', 0);  // default 0

        // Fetch active notifications with limit & offset
        $notifications = DB::table('notifications')
            ->where('status', 1)
            ->orderBy('created_at', 'desc')
            ->limit($limit)
            ->offset($offset)
            ->get();

        // Fetch all active user categories once (id => name)
        $categoryMap = DB::table('user_categories')
            ->where('status', 1)
            ->pluck('category', 'usercategoryid')
            ->toArray();

        $highlights = $notifications->map(function ($item) use ($categoryMap) {
            // Decode the JSON array from DB
            $categories = json_decode($item->notificationCategory, true) ?? [];

            // If 0 exists, replace with all active category IDs
            if (in_array(0, $categories)) {
                $categories = array_keys($categoryMap);
            }

            // Map IDs to names
            $categoryNames = [];
            foreach ($categories as $catId) {
                if (isset($categoryMap[$catId])) {
                    $categoryNames[] = $categoryMap[$catId];
                }
            }

            return [
                'id'       => $item->notificationID,
                'title'    => $item->heading,
                'category' => $categoryNames,
            ];
        });

        return response()->json([
            'highlights' => $highlights
        ], 200);

    } catch (\Exception $e) {
        return response()->json([
            'status'  => 'error',
            'message' => $e->getMessage()
        ], 500);
    }}
     public function getNotification($id)
     {
         try {
             // Fetch the notification by ID
             $notification = DB::table('notifications')
                 ->where('notificationID', $id)
                 ->where('status', 1) // optional: only active
                 ->first();

             if (!$notification) {
                 return response()->json([
                     'status'  => 'error',
                     'message' => 'Notification not found'
                 ], 404);
             }

             // Fetch all active user categories (id => name)
             $categoryMap = DB::table('user_categories')
                 ->where('status', 1)
                 ->pluck('category', 'usercategoryid')
                 ->toArray(); // [1 => 'Free', 2 => 'Premium', ...]

             // Decode the JSON array from DB
             $categories = json_decode($notification->notificationCategory, true) ?? [];

             // If 0 exists, replace with all active IDs
             if (in_array(0, $categories)) {
                 $categories = array_keys($categoryMap);
             }

             // Map IDs to category names
             $categoryNames = [];
             foreach ($categories as $catId) {
                 if (isset($categoryMap[$catId])) {
                     $categoryNames[] = $categoryMap[$catId];
                 }
             }

             // Prepare response
             $response = [
                 'id'          => $notification->notificationID,
                 'title'       => $notification->heading,
                 'description' => $notification->description,
                 'category'    => $categoryNames,
                 'status'      => $notification->status ? 'Active' : 'Inactive',
                 'link'        => $notification->link,
                 'displayImage'=> $notification->displayImage,
                 'insideImage' => $notification->insideImage,
                 'showNote'    => $notification->showNote,
                 'thankNote'   => $notification->thankNote,
                 'type'        => $notification->type,
                 'linkHeading' => $notification->linkHeading,
             ];

             return response()->json($response, 200);

         } catch (\Exception $e) {
             return response()->json([
                 'status'  => 'error',
                 'message' => $e->getMessage()
             ], 500);
         }
     }

}
