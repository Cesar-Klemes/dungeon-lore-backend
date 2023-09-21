<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    protected $table = 'users';
    protected $primaryKey = 'user_id';
    protected $fillable = [
        'name',
        'email',
        'encrypted_password',
        'created_at',
        'last_login_date',
        'bio',
        'avatar_url',
        'status'
    ];
    protected $hidden = [
        'encrypted_password',
        'remember_token',
    ];
    protected $casts = [
        'email_verified_at' => 'datetime',
        'created_at' => 'datetime',
        'last_login_date' => 'datetime'
    ];
    public function getAuthPassword()
    {
        return $this->encrypted_password;
    }
}
