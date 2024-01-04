extends CharacterBody2D

enum States {
	MOVE,
	ATTACK,
	HURT
}

# Onready variables
@onready var sprite = $AnimatedSprite2D

# Variable
var state: States = States.MOVE

# Movement constants
const MAX_SPEED = 50
const ACCELERATION = 400
const FRICTION = 500

#region Player
var player = null:
	set(value):
		player = value
	get:
		return player

func player_exists() -> bool:
	return player != null && is_instance_valid(player)

func remove_player() -> void:
	if player_exists():
		player.remove_character()
		player = null
#endregion

#region Input 
func input_get_action_strength(action) -> float: 
	if player_exists():
		return player.input_get_action_strength(action)
	return 0

func input_get_input(action) -> bool:
	if player_exists():
		return player.input_get_input(action)
	return false

func input_get_input_pressed(action) -> bool:
	if player_exists():
		return player.input_get_input_pressed(action)
	return false

func input_get_input_released(action) -> bool:
	if player_exists():
		return player.input_get_input_released(action)
	return false
#endregion

#region States
func move_state(delta) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = input_get_action_strength("Right") - input_get_action_strength("Left")
	input_vector.y = input_get_action_strength("Down") - input_get_action_strength("Up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		move_and_slide()
		sprite.play("default")
		if input_vector.x == -1 or input_vector.x == 1:
			sprite.scale = Vector2(input_vector.x, 1)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		sprite.stop()
		sprite.frame = 0

func attack_state() -> void:
	pass

func hurt_state() -> void:
	pass
#endregion

func _physics_process(delta: float) -> void:
	match (state):
		States.MOVE:
			move_state(delta)
		States.ATTACK:
			attack_state()
		States.HURT:
			hurt_state()
