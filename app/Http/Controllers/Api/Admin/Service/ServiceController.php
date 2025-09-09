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
    use Illuminate\Support\Facades\DB;

    public function getServicesByCategory($category)
    {
        try {
            // Step 1: Get all active services for microsite 'services'
            $rawServices = DB::table('microservice')
                ->where('microsite', 'services')
                ->where('status', 1)
                ->orderBy('order-no', 'asc')
                ->get();

            $filteredServices = [];

            // Step 2: Loop through each service and filter by category
            foreach ($rawServices as $service) {
                if ($service->microsite === $category) {
                    $filteredServices[] = [
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
                }
            }

            return response()->json([
                'success'  => true,
                'category' => $category,
                'rows'     => $filteredServices,
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
