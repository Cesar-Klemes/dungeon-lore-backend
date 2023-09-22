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
            // Outras regras de validação
        ]);

        $gameTable = new GameTable($request->all());
        $gameTable->master_id = Auth::id(); // Define o usuário logado como mestre
        $gameTable->title = $request->title;
        $gameTable->description = $request->description;
        $gameTable->save();

        return response()->json($gameTable, 201);
    }
}
