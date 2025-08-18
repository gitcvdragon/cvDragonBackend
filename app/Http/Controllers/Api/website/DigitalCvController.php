<?php

namespace App\Http\Controllers\Api\website;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Traits\ApiResponseTrait;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class DigitalCvController extends Controller
{
    use ApiResponseTrait;


    public function createDigitalCv(Request $request)
    {
        try {
            $id = auth()->id();

            $validator = Validator::make($request->all(), [
                'username'            => 'required|string|max:255',
                'profileImageUrl'     => 'nullable|url',
                'profileVideoURL'     => 'nullable|url',
                'publicProfileStatus' => 'nullable|in:0,1',
                'publicProfile'       => 'nullable|max:255',
                'publicProfileDesign' => 'nullable|max:255',
                'showMobile'          => 'nullable|in:0,1',
                'showProfile'         => 'nullable|in:0,1',
                'showEmail'           => 'nullable|in:0,1',
            ]);

            if ($validator->fails()) {
                return $this->errorResponse($validator->errors()->first(), 422);
            }

            \DB::table('users')
                ->where('id', $id)
                ->update([
                    'username' => $request->username,
                ]);

            $updateData = $request->only([
                'profileImageUrl',
                'profileVideoURL',
                'publicProfileStatus',
                'publicProfile',
                'publicProfileDesign',
                'showMobile',
                'showProfile',
                'showEmail',
            ]);

            if (!empty($updateData)) {
                \DB::table('user-basic')
                    ->where('id', $id)
                    ->update($updateData);
            }

            $user = \DB::table('user-basic')->where('id', $id)->first();

            return $this->successResponse(
                // ['user' => $user],
                [],
                'Data updated successfully!'
            );

        } catch (\Exception $e) {
            return $this->errorResponse(
                'Something went wrong! ' . $e->getMessage(),
                500
            );
        }
    }


    public function showDigitalCv(Request $request)
    {
        try {
            $id = auth()->id();

            $user = UserBasic::findOrFail($id);

            $user->showProfile = $user->showProfile == 1 ? 0 : 1;

            $user->save();

            return $this->successResponse(
                ['user' => $user],
                'Profile visibility toggled successfully!'
            );

        } catch (\Exception $e) {
            return $this->errorResponse(
                'Something went wrong! ' . $e->getMessage(),
                500
            );
        }
    }


}
