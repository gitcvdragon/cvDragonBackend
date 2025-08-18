<?php

namespace App\Http\Controllers\Api\Help;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Traits\ApiResponseTrait;
use Illuminate\Support\Facades\Validator;
class HelpController extends Controller
{
    use ApiResponseTrait;

    public function getHelpVideos(Request $request)
    {
        $limit = $request->query('limit', 10);
        $offset = $request->query('offset', 0);
        $helpVideos = DB::table('help-videos')
        ->select('videoID', 'heading', 'link', 'dateCreated')
            ->where('status', 1)
            ->limit($limit)
            ->offset($offset)
            ->get();
            return $this->successResponse([
            'help-videos' => $helpVideos


            ], 'All Data Fetched!!');

    }

    public function getHelpFaq(Request $request)
    {
        $limit = $request->query('limit', 10);
        $offset = $request->query('offset', 0);

        $helpFaq = DB::table('help-faq')
        ->select('faqID','faq',  'answer')
            ->where('status', 1)
            ->limit($limit)
            ->offset($offset)
            ->get();
            return $this->successResponse([
                'help-faq' => $helpFaq

            ], 'All Data Fetched!!');

    }

    public function getNotifications(Request $request)
    {
        $limit = $request->query('limit', 10);
        $offset = $request->query('offset', 0);

        $notifications = DB::table('notifications')
            ->select('id', 'displayImage')
            ->where('status', 1)
            ->limit($limit)
            ->offset($offset)
            ->get();
            return $this->successResponse([
            'notifications' => $notifications

            ], 'All Data Fetched!!');

    }
}
