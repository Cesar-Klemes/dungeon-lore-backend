<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GameTable extends Model
{
    use HasFactory;

    protected $table = 'game_table';
    protected $primaryKey = 'table_id';
    protected $fillable = ['master_id', 'title', 'description', 'creation_date', 'status'];
}
