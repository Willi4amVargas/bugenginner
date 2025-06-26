class_name Player
extends CharacterBody2D

@export var player_stats:Entity
# Velocidad del personaje
@onready var player_animations:AnimatedSprite2D = $Sprite

# ESTO ES HUELE A PUPU PERO NOSE CMO MAS HACERLO POR AHORA :p 
# (nadie mas va a tocar el codigo)
func _ready() -> void:
	if GLOBAL.scene_player_last == "INITIAL_HOUSE":
		self.position = GLOBAL.last_player_position

func _physics_process(_delta: float) -> void:
	# Reiniciar el vector de movimiento
	var movimiento = Vector2()

	# Detectar entrada del usuario
	if Input.is_action_pressed("ui_right"):
		player_animations.play("right")
		movimiento.x += player_stats.entity_velocity
	elif Input.is_action_pressed("ui_left"):
		player_animations.play("left")
		movimiento.x -= player_stats.entity_velocity
	elif Input.is_action_pressed("ui_up"):
		player_animations.play("up")
		movimiento.y -= player_stats.entity_velocity
	elif Input.is_action_pressed("ui_down"):
		player_animations.play("down")
		movimiento.y += player_stats.entity_velocity
	else :
		player_animations.stop()
	
	#if movimiento.x == 0 or movimiento.y == 0:
		#player_animations.stop()

	# Normalizar el vector de movimiento para evitar movimiento más rápido en diagonal
	if movimiento.length() > 0:
		movimiento = movimiento.normalized() * player_stats.entity_velocity

	# Asignar el movimiento a la propiedad "velocity" de CharacterBody2D
	velocity = movimiento

	# Mover al personaje usando move_and_slide()
	move_and_slide()
