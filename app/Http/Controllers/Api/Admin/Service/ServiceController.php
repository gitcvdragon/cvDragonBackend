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
            $rawServices = DB::table('microservice')
                ->where('microsite', 'services')
                ->where('status', 1)
                ->orderBy('order-no', 'asc')
                ->get();

            $grouped = $rawServices->groupBy('category')->map(function ($items, $category) {
                return [
                    'title'      => $category,
                    'titleColor' => $items->first()->color1,
                    'rows'       => $items->map(function ($service) {
                        return [
                            'id'            => $service->sn,
                            'title'         => $service->heading,
                            'price'         => (float) $service->cost,
                            'purchaseCount' => $service->purchases,
                            'color'         => $service->color2,
                            'icon'          => $service->icon,
                            'description'   => $service->description,
                            'rating'        => $service->rating,
                            'button'        => $service->button,
                            'link'          => $service->link,
                            'textDown'      => $service->textDown,
                            'textRight'     => $service->textRight,
                            'image'         => $service->image,
                        ];
                    }),
                ];
            })->values();

            return response()->json([
                'success'  => true,
                'sections' => $grouped,
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Something went wrong!',
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
