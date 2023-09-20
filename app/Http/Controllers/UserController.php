<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    public function register(Request $request)
    {
        // Validação dos dados recebidos
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'encrypted_password' => 'required|string|min:8',
            'bio' => 'nullable|string|max:1000',
            'avatar_url' => 'nullable|string',
            'status' => 'required|string|max:50',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 400);
        }

        // Criação do usuário
        $user = new User;
        $user->name = $request->name;
        $user->email = $request->email;
        $user->encrypted_password = Hash::make($request->encrypted_password);
        $user->bio = $request->bio;
        $user->avatar_url = $request->avatar_url;
        $user->status = $request->status;
        $user->save();

        return response()->json(['message' => 'User registered successfully!', 'user' => $user], 201);
    }
}