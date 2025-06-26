extends Node2D

func _ready() -> void:
	GLOBAL.scene_player_actual = "INITIAL_HOUSE"
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		GLOBAL.scene_player_last = "INITIAL_HOUSE"
		get_tree().change_scene_to_file("res://scenes/worlds/main_world.tscn")
