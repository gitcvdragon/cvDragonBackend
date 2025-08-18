<?php

namespace App\Http\Controllers\Api\website;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Traits\ApiResponseTrait;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
class MyDocumentsController extends Controller
{
    use ApiResponseTrait;

    public function uploadDocument(Request $request)
{
    try {
        // Validation
        $request->validate([
            'documentTitle'      => 'required|string|max:255',
            'documentSection'    => 'nullable|integer',
            'documentSubSection' => 'nullable|integer',
            'documentFile'       => 'required|string|',
        ]);

        $userId = auth()->id();

        // Save record in DB
        $document = \DB::table('user-documents')->insertGetId([
            'documentTitle'      => $request->documentTitle,
            'documentLocation'   => $request->documentFile,
            'documentSection'    => $request->documentSection,
            'documentSubSection' => $request->documentSubSection,
            'id'                 => $userId,
            'date'               => now(),
            'status'             => 1,
        ]);


    return $this->successResponse(
        [
            'documentID'      => $document,

        ],
       'Document uploaded successfully',
    );

} catch (\Exception $e) {
    return $this->errorResponse(
        'Something went wrong! ' . $e->getMessage(),
        500
    );
}
}

public function getMyDocuments()
{
    try {
        $userId = auth()->id();

        $documents = \DB::table('user-documents as ud')
            ->join('resource-section as rs', 'ud.documentSection', '=', 'rs.id')
            ->join('master_cv_sections as mcs', 'rs.master_cv_sections_id', '=', 'mcs.id')

            ->where('ud.id', $userId)
            ->where('ud.status', 1)
            ->select(
                'ud.documentID',
                'ud.documentTitle',
                'ud.documentLocation',
                'ud.date',
                'ud.status',
                'mcs.heading as sectionName',
                'rs.sectionName as subSectionName'
            )
            ->orderBy('ud.date', 'desc')
            ->get();

        return $this->successResponse(
            ['documents' => $documents],
            'Documents fetched successfully!'
        );

    } catch (\Exception $e) {
        return $this->errorResponse(
            'Something went wrong! ' . $e->getMessage(),
            500
        );
    }
}

public function deleteDocument($documentId)
{
    try {
        // $request->validate([
        //     'documentID' => 'required|integer',
        // ]);

        $userId = auth()->id();
        // $documentId = $request->documentID;

        $updated = \DB::table('user-documents')
            ->where('id', $userId)
            ->where('documentID', $documentId)
            ->update(['status' => 0]);

        if ($updated) {
            return $this->successResponse([], 'Document deleted successfully!');
        } else {
            return $this->errorResponse('Document not found or already deleted.', 404);
        }

    } catch (\Exception $e) {
        return $this->errorResponse(
            'Something went wrong! ' . $e->getMessage(),
            500
        );
    }
}


}
