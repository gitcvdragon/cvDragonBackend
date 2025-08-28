<?php

namespace App\Http\Controllers\Api\Admin\User;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Traits\ApiResponseTrait;


class AllUserFetchController extends Controller
{
    use ApiResponseTrait;


    /**
    * Fetch all users with their category & pagination (limit, offset)
    */

    public function getUsers(Request $request)
    {
        try {
            $limit  = (int) $request->input('limit', 10);
            $offset = (int) $request->input('offset', 0);

            $users = DB::table('users as u')
            ->leftJoin('user_categories as uc', 'u.categoryid', '=', 'uc.usercategoryid')

            ->leftJoin('user-basic as ub', 'ub.id', '=', 'u.id')
            ->select(
                'u.id',
                'ub.fullName as name',
                'ub.emailAddress as userEmail',
                'ub.phoneNumber as userMobile',
                'ub.profileImageUrl as profileImg',
                'uc.category as accountType',
                DB::raw("DATE(ub.dateCreated) as dateOfRegistration"),
                'ub.wizardProfile'
            )
            ->where('u.status', 1)
            ->offset($offset)
            ->limit($limit)
            ->orderBy('u.id', 'desc')
            ->get();


            // Format for frontend JSON
            $data = $users->map(function ($user) {
                return [
                    'id'          => $user->id,
                    'name'        => $user->name,
                    'profileImg'  => $user->profileImg ?? '/assets/avatar.svg',
                    'accountType' => $user->accountType ?? 'Free',
                    'date'        => $user->dateOfRegistration,
                    'platformType'=> $user->platformType ?? 'email',
                    'actionIcons' => [
                        ['src' => '/assets/download-left.svg', 'onClick' => null],
                        ['src' => '/assets/link.svg', 'onClick' => null],
                        ['src' => '/assets/arrow-down.svg', 'onClick' => null],
                    ]
                ];
            });

            return $this->successResponse([
                'users' => $data,
                'pagination' => [
                    'limit'  => $limit,
                    'offset' => $offset,
                ]
            ], 'Users fetched successfully!');

        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong: ' . $e->getMessage(), 500);
        }
    }
    public function getDeletedUsers(Request $request)
    {
        try {
            $limit  = (int) $request->input('limit', 10);
            $offset = (int) $request->input('offset', 0);

            $users = DB::table('users as u')
                ->leftJoin('user_categories as uc', 'u.categoryid', '=', 'uc.usercategoryid')
                ->leftJoin('user-basic as ub', 'ub.id', '=', 'u.id')
                ->select(
                    'u.id',
                    'ub.fullName as name',
                    'ub.emailAddress as userEmail',
                    'ub.phoneNumber as userMobile',
                    'ub.profileImageUrl as profileImg',
                    'uc.category as accountType',
                    DB::raw("DATE(ub.dateCreated) as dateOfRegistration"),
                    'ub.wizardProfile'
                )
                ->where('u.status', 2)
                ->offset($offset)
                ->limit($limit)
                ->orderBy('u.id', 'desc')
                ->get();

            $data = $users->map(function ($user) {
                return [
                    'id'          => $user->id,
                    'name'        => $user->name,
                    'profileImg'  => $user->profileImg ?? '/assets/avatar.svg',
                    'accountType' => $user->accountType ?? 'Free',
                    'date'        => $user->dateOfRegistration,
                    'platformType'=> $user->platformType ?? 'email',
                    'actionIcons' => [
                        ['src' => '/assets/download-left.svg', 'onClick' => null],
                        ['src' => '/assets/link.svg', 'onClick' => null],
                        ['src' => '/assets/arrow-down.svg', 'onClick' => null],
                    ]
                ];
            });

            return $this->successResponse([
                'users' => $data,
                'pagination' => [
                    'limit'  => $limit,
                    'offset' => $offset,
                ]
            ], 'Deleted users fetched successfully!');

        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong: ' . $e->getMessage(), 500);
        }
    }


    public function deleteUser($id)
{
    try {
        $user = DB::table('users')->where('id', $id)->first();

        if (!$user) {
            return $this->errorResponse('User not found', 404);
        }

        // Update status to 2 (deleted)

            DB::table('user-basic')
            ->where('id', $id)
            ->update(['status' => 2]);
        DB::table('users')
            ->where('id', $id)
            ->update(['status' => 2]);

        DB::table('create-cvprofiles')
            ->where('id', $id)
            ->update(['status' => 2]);

        return $this->successResponse(null, 'User deleted successfully!');
    } catch (\Exception $e) {
        return $this->errorResponse('Something went wrong: ' . $e->getMessage(), 500);
    }
}


}
