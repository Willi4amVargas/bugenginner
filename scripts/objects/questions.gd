class_name QuestionForm
extends CanvasLayer

var resource: QuestionResource

@onready var background:TextureRect = $TextureRect
@onready var question: Label = $VBoxContainer/CenterContainer/Label
@onready var answers_menu_button: MenuButton = $VBoxContainer/CenterContainer2/MenuButton

@onready var status_answer:Label = $VBoxContainer/CenterContainer3/Label

var allAnswers:Array[String]

func _ready() -> void:
	# Detener el arbol de eventos del juego :p
	get_tree().paused = true
	answers_menu_button.process_mode = Node.PROCESS_MODE_ALWAYS
	background.texture = resource.background
	question.text = resource.question
	
	allAnswers.append(resource.correct_answer)
	allAnswers.append_array(resource.wrong_answers)
		
	# Mezclar las respuestas aleatoriamentea
	allAnswers.shuffle()
	for i in allAnswers.size():
		answers_menu_button.get_popup().add_item(allAnswers[i], i)
	
	answers_menu_button.get_popup().id_pressed.connect(_on_item_selected)

func _on_item_selected(id: int) -> void:
	if allAnswers[id] == resource.correct_answer:
		status_answer.text = "¡Respuesta Correcta!"
		status_answer.add_theme_color_override("font_color",Color(0,255,0,1))
		
		await get_tree().create_timer(1.3).timeout
		resource.status = true
		get_tree().paused = false
		queue_free() 
	else:
		status_answer.text = "Respuesta Incorrecta"
		status_answer.add_theme_color_override("font_color",Color(255,0,0,1))
