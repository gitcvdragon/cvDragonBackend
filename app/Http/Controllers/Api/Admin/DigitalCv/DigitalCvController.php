<?php

namespace App\Http\Controllers\Api\Admin\DigitalCv;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\{CreateCvuserprofile, CvImages, CvInterest, CvLanguages, CVSkill, CvTechnical, User};

class DigitalCvController extends Controller
{
    /**
     * List all active users with their public profile status
     */
    public function listUsers(Request $request)
    {
        $limit  = $request->input('limit', 10);   // default 10
        $offset = $request->input('offset', 0);   // default 0

        $users = DB::table('users as u')
            ->leftJoin('user-basic as ub', 'ub.id', '=', 'u.id')
            ->leftJoin('create-cvprofile as ucv', 'ub.publicProfile', '=', 'ucv.cvid')
            ->leftJoin('resource_profile_design_categories as rpd', 'rpd.id', '=', 'ucv.design')
            ->select(
                'u.id as userId',
                'ub.fullName as userName',
                'rpd.image',
                DB::raw('DATE(ub.dateCreated) as creationDate'),
                DB::raw("CASE
                            WHEN ub.publicProfileStatus = 1 THEN 'Active'
                            ELSE 'Inactive'
                         END as status")
            )
            ->where('u.status', 1)
            ->where('ucv.status', 1)
            ->where('rpd.status', 1)
            ->where('ub.status', 1)
            ->orderBy('ub.dateCreated', 'desc')
            ->limit($limit)
            ->offset($offset)
            ->get();

        return response()->json([
            'cvs' => $users
        ]);
    }

public function DigitalCv(Request $request, $userId)
{
    $user = \DB::table('user-basic')->where('id', $userId)->first();

    if (!$user) {
        return $this->errorResponse('User not found', 404);
    }

    if ($user->publicProfileStatus != 1) {
        return $this->errorResponse('User profile is not public', 403);
    }

    $profile = CreateCvuserprofile::with('cvProfileSection')
        ->where('status', 1)
        ->when(!empty($user->publicProfile), function ($query) use ($user) {
            $query->where('cvid', $user->publicProfile);
        }, function ($query) use ($userId) {
            $query->where('id', $userId);
        })
        ->first();

    if (!$profile) {
        return $this->successResponse(null, 'No Profile Found!!');
    }

    $response = [
        "id"            => $profile->cvid,
        "userId"        => $profile->userId,
        "userName"      => $user->fullName,
        "showMobile"      => $user->showMobile,
        "showEmail"      => $user->showEmail,
        "creationDate"  => $profile->created_at ? $profile->created_at->format('Y-m-d') : null,
        "status"        => $profile->status == 1 ? "Active" : "Inactive",
        "sections"      => $profile->cvProfileSection->map(function ($section) {
            return [
                "title"   => $section->showName,
                "content" => $section->subsection,
            ];
        }),
    ];

    return response()->json($response, 200);
}

}
