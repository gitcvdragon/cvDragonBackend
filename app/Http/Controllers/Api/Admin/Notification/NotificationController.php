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

     public function index()
     {
         try {
             // Fetch active notifications
             $notifications = DB::table('notifications')
                 ->where('status', 1)
                 ->orderBy('created_at', 'desc')
                 ->get();

             // Fetch all active user categories once (id => name)
             $categoryMap = DB::table('user_categories')
                 ->where('status', 1)
                 ->pluck('category', 'usercategoryid')
                 ->toArray(); // e.g., [1 => 'Free', 2 => 'Premium']

             $highlights = $notifications->map(function ($item) use ($categoryMap) {
                 // Decode the JSON array from the DB
                 $categories = json_decode($item->notificationCategory, true) ?? [];

                 // If 0 exists, replace with all active category IDs
                 if (in_array(0, $categories)) {
                     $categories = array_keys($categoryMap); // all IDs
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
         }
     }
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
