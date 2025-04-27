class_name BattleScene
extends CanvasLayer


var enemy_stats: Enemy
var player_stats: Player

@onready var player_label:Label = $GridContainer/LabelContainer/PlayerContainer/Player
@onready var enemy_label:Label = $GridContainer/LabelContainer/EnemyContainer/Enemy

@onready var player_life_color:ColorRect = $GridContainer/LabelContainer/PlayerContainer/PlayerLife
@onready var enemy_life_color:ColorRect = $GridContainer/LabelContainer/EnemyContainer/EnemyLife

@onready var button_action1 = $GridContainer/ActionsContainer/Action1
@onready var button_action2 = $GridContainer/ActionsContainer/Action2
@onready var button_action3 = $GridContainer/ActionsContainer/Action3
@onready var button_action4 = $GridContainer/ActionsContainer/Action4

func _ready() -> void:
	get_tree().paused = true
	start_battle()
	button_action1.process_mode = Node.PROCESS_MODE_ALWAYS
	button_action2.process_mode = Node.PROCESS_MODE_ALWAYS
	button_action3.process_mode = Node.PROCESS_MODE_ALWAYS
	button_action4.process_mode = Node.PROCESS_MODE_ALWAYS
	
	enemy_label.text = str(enemy_stats.enemy_stats.name)
	player_label.text = str(player_stats.player_stats.name)
	
	player_life_color.color = player_stats.player_stats.life_color
	enemy_life_color.color = enemy_stats.enemy_stats.life_color
	#update_labels()

func win()->void:
	disable_battle()

func lose() -> void:
	queue_free()
	disable_battle()
	
func start_battle():
	# Crear ColorRect dinámicamente con mejor configuración
	var dim = ColorRect.new()
	dim.name = "BattleDim"  # Nombre único para referencia
	dim.color = Color(0, 0, 0, 0.8)
	dim.size = Vector2(100, 200)

	# Configurar anclaje para que cubra toda la pantalla
	dim.anchor_right = 1.0
	dim.anchor_bottom = 1.0

	# Añadir como primer hijo (debajo de la UI)
	add_child(dim)
	move_child(dim, 0)  # Lo envía al fondo

	# Animación suave
	var tween = create_tween()
	tween.tween_property(dim, "color:a", 0.7, 0.3)

func disable_battle():
	# Eliminar overlay si existe
	var dim = get_node_or_null("BattleDim")
	if dim:
		dim.queue_free()
	get_tree().paused = false

func make_action_and_comprobe_status(emisor:Entity, receptor:Entity):
	receptor.make_damage(emisor.damage)
	if receptor.life <= 0:
		disable_battle()
		queue_free()

func _on_action_1_pressed() -> void:
	make_action_and_comprobe_status(player_stats.player_stats, enemy_stats.enemy_stats)
	print("VIDA DEL ENEMIGO: ", enemy_stats.enemy_stats.life)
	print("VIDA DEL JUGADOR: ", player_stats.player_stats.life)

func _on_action_2_pressed() -> void:
	make_action_and_comprobe_status(enemy_stats.enemy_stats, player_stats.player_stats)
	print("VIDA DEL ENEMIGO: ", enemy_stats.enemy_stats.life)
	print("VIDA DEL JUGADOR: ", player_stats.player_stats.life)

func _on_action_3_pressed() -> void:
	print("ENEMIGO DEBERIA SER ELIMINADO")
	enemy_stats.queue_free()


func _on_action_4_pressed() -> void:
	pass # Replace with function body.
