extends CharacterBody2D

# Velocidad del personaje
var vel = 100
@onready var player_animations:AnimatedSprite2D = $Sprite

func _physics_process(delta: float) -> void:
	# Reiniciar el vector de movimiento
	var movimiento = Vector2()

	# Detectar entrada del usuario
	if Input.is_action_pressed("ui_right"):
		player_animations.play("right")
		movimiento.x += vel
	elif Input.is_action_pressed("ui_left"):
		player_animations.play("left")
		movimiento.x -= vel
	elif Input.is_action_pressed("ui_up"):
		player_animations.play("up")
		movimiento.y -= vel
	elif Input.is_action_pressed("ui_down"):
		player_animations.play("down")
		movimiento.y += vel
	else :
		player_animations.stop()
	
	#if movimiento.x == 0 or movimiento.y == 0:
		#player_animations.stop()

	# Normalizar el vector de movimiento para evitar movimiento más rápido en diagonal
	if movimiento.length() > 0:
		movimiento = movimiento.normalized() * vel

	# Asignar el movimiento a la propiedad "velocity" de CharacterBody2D
	velocity = movimiento

	# Mover al personaje usando move_and_slide()
	move_and_slide()
