<?php

namespace App\Http\Controllers\Api\Menu;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class MenuController extends Controller
{
    public function groupByIndex()
    {

        $items = DB::table('resource-menu')
            ->where('status', 1)
            ->orderBy('orderMenu')
            ->get();


        $menuMap = [];
        foreach ($items as $item) {
            $item->Submenu = [];
            $menuMap[$item->content] = $item;
        }
        $tree = [];
        foreach ($items as $item) {
            if (isset($menuMap[$item->index])) {

                $menuMap[$item->index]->Submenu[] = $item;
            } else {

                $tree[] = $item;
            }
        }

        $groupedTree = collect($tree)->groupBy('index');

        return response()->json($groupedTree);
    }

}
