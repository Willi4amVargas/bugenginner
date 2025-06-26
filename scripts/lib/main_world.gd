extends Node2D

func _ready() -> void:
	GLOBAL.scene_player_actual = "MAIN_WORLD"

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name =="Player":
		var position_moved:Vector2 = Vector2(body.global_position.x, body.global_position.y + 10)
		GLOBAL.last_player_position = position_moved
		GLOBAL.scene_player_last = "MAIN_WORLD"
		get_tree().change_scene_to_file("res://scenes/worlds/initial_house.tscn")
