extends Node2D
@onready var attackButton = $VBoxContainer/Button
@onready var playerStatsLabel= $CanvasLayer/PlayerStats
@onready var enemyStatsLabel= $CanvasLayer/EnemyStats
var playerStats = GLOBALENV.player_stadistics
var enemyStats = GLOBALENV.enemy_stadistics

func _ready() -> void:
	update_player_stats()
	update_enemy_stats()
	
func update_player_stats():
	playerStatsLabel.text = "VIDA: %d | ATAQUE: %d" % [playerStats.life, playerStats.attack]

func update_enemy_stats():
	enemyStatsLabel.text = "VIDA: %d | ATAQUE: %d" % [enemyStats.life, enemyStats.attack]

func _on_button_pressed() -> void:
	player_attack()
	update_enemy_stats()
	
func player_attack():
	if enemyStats.life - playerStats.attack < 0:
		get_tree().change_scene_to_file("res://scenes/main_world.tscn")
	else:
		enemyStats.life = enemyStats.life - playerStats.attack
	
	
