<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Schema::rename('user', 'users');  // Renomeia a tabela para 'users'

        Schema::table('users', function (Blueprint $table) {
            $table->renameColumn('creation_date', 'created_at');  // Renomeia a coluna
            // $table->timestamp('updated_at')->nullable();  // Adiciona a coluna updated_at
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        //
    }
};
