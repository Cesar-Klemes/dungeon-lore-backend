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
        Schema::table('game_table', function (Blueprint $table) {
            $table->renameColumn('creation_date', 'created_at'); // Renomeia a coluna
            $table->timestamp('updated_at')->nullable(); // Adiciona a nova coluna
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('game_table', function (Blueprint $table) {
            Schema::table('game_table', function (Blueprint $table) {
                $table->renameColumn('created_at', 'creation_date'); // Reverte o nome da coluna ao estado original
                $table->dropColumn('updated_at'); // Remove a coluna adicionada
            });
        });
    }
};
