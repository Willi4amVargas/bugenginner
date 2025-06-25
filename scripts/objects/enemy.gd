class_name Enemy
extends Area2D

@export var enemy_stats:Entity
var original_values:Entity

@export var battle_escene:PackedScene = preload("res://scenes/battle_scenes/battle_scene.tscn")

func _process(delta: float) -> void:
	if enemy_stats.life <= 0:
		queue_free() 

func _ready() -> void:
	enemy_stats = enemy_stats.duplicate()
	original_values = enemy_stats.duplicate()

func _on_body_entered(body: Node2D) -> void:
	if (body.name=="Player"):
		var battle_scene = battle_escene.instantiate()
		battle_scene.enemy_stats = self
		battle_scene.player_stats = body
		add_child(battle_scene)
