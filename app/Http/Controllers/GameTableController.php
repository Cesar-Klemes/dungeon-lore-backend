<?php

namespace App\Http\Controllers;

use App\Models\GameTable;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class GameTableController extends Controller
{
    public function create(Request $request)
    {
        $request->validate([
            'title' => 'required|string|max:255',
        ]);

        $userId = Auth::id();
        $count = GameTable::where('master_id', $userId)->count();

        if ($count >= 10) {
            return response()->json([
                'message' => 'The user has reached the limit of 10 gaming tables.',
            ], 422);
        }

        $gameTable = new GameTable($request->all());
        $gameTable->master_id = Auth::id();
        $gameTable->title = $request->title;
        $gameTable->description = $request->description;
        $gameTable->status = $request->status;
        $gameTable->save();

        return response()->json($gameTable, 201);
    }
}
