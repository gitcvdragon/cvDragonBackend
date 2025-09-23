<?php

namespace App\Traits;

trait ApiResponseTrait
{
    /**
     * Return a success response.
     *
     * @param mixed $data
     * @param string $message
     * @param int $statusCode
     * @return \Illuminate\Http\JsonResponse
     */
    public function successResponse($data = null, $message = 'Success', $statusCode = 200)
    {
        return response()->json([
            'status'        => 'success',

            'success' => true,
            'message' => $message,
            'data' => $data,
            'meta' => [
                'version' =>  env('API_VER', '1_0_0'),
                'developer' =>  config('app.developer', 'DEVELOPER'),
            ],
        ], $statusCode);
    }

    /**
     * Return an error response.
     *
     * @param string $message
     * @param int $statusCode
     * @param mixed $errors
     * @return \Illuminate\Http\JsonResponse
     */
    public function errorResponse($message = 'An error occurred', $statusCode = 500, $errors = null)
    {
        return response()->json([
            'status'        => 'error',

            'success' => false,
            'message' => $message,
            'errors' => $errors,
            'meta' => [
                'version' =>  env('API_VER', '1_0_0'),
                'developer' =>  config('app.developer', 'DEVELOPER'),
            ],
        ], $statusCode);
    }

    /**
     * Return a validation error response.
     *
     * @param mixed $errors
     * @param string $message
     * @param int $statusCode
     * @return \Illuminate\Http\JsonResponse
     */
    public function validationErrorResponse($errors, $message, $statusCode = 422)
    {
        return response()->json([
            'status'        => 'error',

            'success' => false,
            'message' => $message,
            'errors' => $errors,
            'meta' => [
                'version' =>  env('API_VER', '1_0_0'),
                'developer' =>  config('app.developer', 'DEVELOPER'),
            ],
        ], $statusCode);
    }
}
