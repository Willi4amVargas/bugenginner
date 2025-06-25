class_name BattleScene
extends CanvasLayer


var enemy_stats: Enemy
var player_stats: Player

var player_initial_life:float
var enemy_initial_life:float


@onready var player_label:Label = $GridContainer/LabelContainer/PlayerContainer/Player
@onready var enemy_label:Label = $GridContainer/LabelContainer/EnemyContainer/Enemy

@onready var player_life_color:ColorRect = $GridContainer/LabelContainer/PlayerContainer/MarginContainer/PlayerLife
@onready var enemy_life_color:ColorRect = $GridContainer/LabelContainer/EnemyContainer/MarginContainer/EnemyLife

var player_initial_life_w:float 
var enemy_initial_life_w:float

@onready var button_action1 = $GridContainer/ActionsContainer/Action1
@onready var button_action2 = $GridContainer/ActionsContainer/Action2
@onready var button_action3 = $GridContainer/ActionsContainer/Action3
@onready var button_action4 = $GridContainer/ActionsContainer/Action4

func _ready() -> void:
	start_battle()
	button_action1.process_mode = Node.PROCESS_MODE_ALWAYS
	button_action2.process_mode = Node.PROCESS_MODE_ALWAYS
	button_action3.process_mode = Node.PROCESS_MODE_ALWAYS
	button_action4.process_mode = Node.PROCESS_MODE_ALWAYS
	
	player_life_color.color = player_stats.player_stats.life_color
	enemy_life_color.color = enemy_stats.enemy_stats.life_color
	
	player_initial_life = player_stats.player_stats.life
	enemy_initial_life = enemy_stats.enemy_stats.life
	
	enemy_label.text = str(enemy_stats.enemy_stats.name)
	player_label.text = str(player_stats.player_stats.name)


func update_life()->void:
	if !player_initial_life_w or !enemy_initial_life_w:
		player_initial_life_w = player_life_color.size.x + player_life_color.size.x * 0.1
		enemy_initial_life_w = enemy_life_color.size.x + enemy_life_color.size.x * 0.1
	
	#print("life H PLAYER: ", player_initial_life_w)
	#print("life H ENEMY: ", enemy_initial_life_w)
	
	
	var enemy_life_percent:float = 1 - (enemy_stats.enemy_stats.life / enemy_initial_life)
	var player_life_percent:float = 1 - (player_stats.player_stats.life / player_initial_life)
	
	var enemy_width_to_reduce = enemy_initial_life_w * enemy_life_percent
	enemy_life_color.size.x -= enemy_width_to_reduce
	
	var player_width_to_reduce = player_initial_life * player_life_percent
	player_life_color.size.x -= player_width_to_reduce
	
	print("life H ACTUAL PLAYER: ", player_life_color.size.x)
	print("life H ACTUAL ENEMY: ", enemy_life_color.size.x)

func start_battle():
	get_tree().paused = true

func disable_battle():
	get_tree().paused = false

func make_action_and_comprobe_status(emisor:Entity, receptor:Entity):
	receptor.make_damage(emisor.damage)
	if receptor.life <= 0:
		disable_battle()
		queue_free()

func _on_action_1_pressed() -> void:
	make_action_and_comprobe_status(player_stats.player_stats, enemy_stats.enemy_stats)
	update_life()
	print("VIDA DEL ENEMIGO: ", enemy_stats.enemy_stats.life)
	print("VIDA DEL JUGADOR: ", player_stats.player_stats.life)

func _on_action_2_pressed() -> void:
	make_action_and_comprobe_status(enemy_stats.enemy_stats, player_stats.player_stats)
	print("VIDA DEL ENEMIGO: ", enemy_stats.enemy_stats.life)
	print("VIDA DEL JUGADOR: ", player_stats.player_stats.life)

func _on_action_3_pressed() -> void:
	print("ENEMIGO DEBERIA SER ELIMINADO")
	enemy_stats.queue_free()
	disable_battle()


func _on_action_4_pressed() -> void:
	pass # Replace with function body.
