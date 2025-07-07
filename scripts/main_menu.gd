extends Button

func _on_pressed() -> void:
	var main_scene_resource = load("res://scenes/worlds/initial_house.tscn")
	
	var main_scene_instance = main_scene_resource.instantiate()
	main_scene_instance.initial_position = Vector2(460, 80)
	get_tree().root.add_child(main_scene_instance)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = main_scene_instance
