class_name QuestionActivator
extends Area2D

const QUESTION_FORM_SCENE = preload("res://scenes/questions/question_scene.tscn")

@export var shape:Shape2D
@onready var area:CollisionShape2D = $CollisionShape2D
@export var question_info:QuestionResource 

func _ready() -> void:
	area.shape = shape
	question_info = question_info.duplicate()

func _process(delta: float) -> void:
	if question_info.status ==true:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if (body.name=="Player"):
		var question_form = QUESTION_FORM_SCENE.instantiate()
		question_form.resource = question_info
		add_child(question_form)
		
