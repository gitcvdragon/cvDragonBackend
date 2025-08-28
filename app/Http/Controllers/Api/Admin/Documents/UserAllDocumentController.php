<?php

namespace App\Http\Controllers\Api\Admin\Documents;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class UserAllDocumentController extends Controller
{
    public function index()
    {
        $users = DB::table('user-documents as d')
            ->join('user-basic as u', 'u.id', '=', 'd.id')
            ->select(
                'u.id as userId',
                'u.fullName as userName',
                DB::raw('COUNT(d.documentID) as documentCount'),
                DB::raw('MAX(d.date) as lastUpdated')
            )
            ->where('d.status', 1)
            ->groupBy('u.id', 'u.fullName')
            ->get();

        return response()->json(['users' => $users]);
    }

    public function userDocuments($userId)
    {
        $documents = DB::table('user-documents as d')
            ->leftJoin('resource-section as s', 's.id', '=', 'd.documentSection')
            ->select(
                'd.documentID as id',
                'd.documentTitle as documentName',
                DB::raw("CASE
                    WHEN d.documentLocation LIKE '%.pdf' THEN 'PDF'
                    WHEN d.documentLocation LIKE '%.doc%' THEN 'DOCX'
                    ELSE 'Other'
                END as type"),
                DB::raw('DATE(d.date) as date'),
                's.sectionName as section',
                'd.documentSubSection as subsection'
            )
            ->where('d.id', $userId)
            ->where('d.status', 1)
            ->orderBy('d.date', 'desc')
            ->get();

        return response()->json([
            'userId' => $userId,
            'documents' => $documents
        ]);
    }

    public function store(Request $request, $userId)
    {
        $file = $request->file('file');
        $path = $file->store('documents'); // stored in storage/app/documents

        $id = DB::table('user-documents')->insertGetId([
            'documentTitle'     => $file->getClientOriginalName(),
            'documentLocation'  => $path,
            'documentSection'   => $request->section,
            'documentSubSection'=> $request->subsection,
            'id'                => $userId,
            'date'              => now(),
            'status'            => 1,
        ]);

        return response()->json([
            'id' => $id,
            'message' => 'Document uploaded successfully'
        ]);
    }

    public function update(Request $request, $userId, $docId)
    {
        DB::table('user-documents')
            ->where('id', $userId)
            ->where('documentID', $docId)
            ->update([
                'documentTitle'     => $request->name,
                'documentSection'   => $request->section,
                'documentSubSection'=> $request->subsection,
                'date'              => now()
            ]);

        return response()->json([
            'id' => $docId,
            'message' => 'Document updated successfully'
        ]);
    }

    public function destroy($userId, $docId)
    {
        DB::table('user-documents')
            ->where('id', $userId)
            ->where('documentID', $docId)
            ->update(['status' => 0]);

        return response()->json([
            'id' => $docId,
            'message' => 'Document deleted successfully'
        ]);
    }
}
