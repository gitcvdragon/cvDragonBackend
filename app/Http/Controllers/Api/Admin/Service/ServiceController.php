<?php

namespace App\Http\Controllers\Api\Admin\Service;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ServiceController extends Controller
{
    /**
     * List all services grouped by category
     */


     public function listServices()
     {
         try {
             // Step 1: Get all active services for microsite 'services'
             $rawServices = DB::table('microservice')
                 ->where('microsite', 'services')
                 ->where('status', 1)
                 ->orderBy('order-no', 'asc')
                 ->get();

             $sections = collect();

             // Step 2: Loop through each category
             $categories = $rawServices->pluck('category')->unique();

             foreach ($categories as $category) {
                 // Get the main service for this category
                 $mainService = DB::table('microservice')
                     ->where('status', 1)
                     ->where('microsite', $category)
                     ->where('category', 'main')
                     ->orderBy('order-no', 'asc')
                     ->first();

                 if (!$mainService) {
                     continue; // skip if no main service
                 }

                 // Get all other services for this category (excluding main)
                 $otherServices = DB::table('microservice')
                     ->where('status', 1)
                     ->where('microsite', $category)
                     ->where('category', '!=', 'main')
                     ->orderBy('order-no', 'asc')
                     ->get()
                     ->map(function ($service) {
                         return [
                             'id'            => $service->sn,
                             'title'         => $service->heading,
                             'description'   => $service->description,
                             'link'          => $service->link,
                             'price'         => (float) $service->cost,
                             'purchaseCount' => $service->purchases,
                             'rating'        => $service->rating,
                             'status'        => $service->status == 1 ? "Active" : "Inactive",
                             'banner'        => $service->banner,
                             'icon'          => $service->icon,
                             'duration'      => $service->duration,
                             'offer'         => $service->offer,
                             'discount'      => $service->discount,
                         ];
                     });

                 // Build section with main service as header and other services as rows
                 $sections->push([
                     'title'      => $mainService->heading,
                     'titleColor' => 'green', // you can customize
                     'rows'       => $otherServices,
                 ]);
             }

             return response()->json([
                 'sections' => $sections,
             ], 200);

         } catch (\Exception $e) {
             return response()->json([
                 'success' => false,
                 'message' => 'Something went wrong',
                 'error'   => $e->getMessage(),
             ], 500);
         }
     }


    /**
     * Get a single service detail
     */
    public function serviceDetail($id)
    {
        try {
            $service = DB::table('microservice')
                ->where('sn', $id)
                ->where('status', 1)
                ->first();

            if (!$service) {
                return response()->json([
                    'success' => false,
                    'message' => 'Service not found',
                ], 404);
            }

            return response()->json([
                'success' => true,
                'service' => [
                    'id'            => $service->sn,
                    'title'         => $service->heading,
                    'price'         => (float) $service->cost,
                    'purchaseCount' => $service->purchases,
                    'parentTitle'   => $service->category,
                    'titleColor'    => $service->color1,
                    'status'        => $service->status == 1 ? "Active" : "Inactive",
                    'description'   => $service->description,
                    'banner'        => $service->banner,
                ]
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Something went wrong!',
                'error'   => $e->getMessage(),
            ], 500);
        }
    }

}
