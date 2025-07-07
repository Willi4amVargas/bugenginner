extends Node2D

@onready var limit_area:Area2D = $CameraLimits
@onready var camera:Camera2D = $Player/Camera2D

func _ready() -> void:
	GLOBAL.scene_player_actual = "MAIN_WORLD"
	_set_camera_limits()

## Esta funcion solo marca el limite de la camara segun el Area2D designada
func _set_camera_limits():
	# Obtén el rectángulo de colisión de los límites
	var shape = limit_area.get_node("CollisionShape2D").shape
	var extents = shape.extents  # Tamaño del área
	var pos = limit_area.position  # Posición del área

	# Aplica los límites a la cámara
	camera.limit_left = pos.x - extents.x
	camera.limit_right = pos.x + extents.x
	camera.limit_top = pos.y - extents.y
	camera.limit_bottom = pos.y + extents.y
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name =="Player":
		var position_moved:Vector2 = Vector2(body.global_position.x, body.global_position.y + 10)
		GLOBAL.last_player_position = position_moved
		GLOBAL.scene_player_last = "MAIN_WORLD"
		get_tree().change_scene_to_file("res://scenes/worlds/initial_house.tscn")
