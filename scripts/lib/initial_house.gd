extends Node2D

var initial_position: Vector2 = Vector2(-9999, -9999)

func _ready() -> void:
	GLOBAL.scene_player_actual = "INITIAL_HOUSE"
	
	
	if initial_position != Vector2(-9999,-9999):
		$Player.position = initial_position
	else:
		$Player.position = Vector2(214,252)

	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		GLOBAL.scene_player_last = "INITIAL_HOUSE"
		get_tree().change_scene_to_file("res://scenes/worlds/main_world.tscn")
