extends CharacterBody2D

enum States {
	MOVE,
	ATTACK,
	HURT
}

# Onready variables
@onready var sprite = $AnimatedSprite2D
@onready var camera = $CharacterCamera

# Variables
var state: States = States.MOVE
var camera_top_left_x = 0
var camera_top_left_y = 0
var camera_bottom_right_x = 0
var camera_bottom_right_y = 0

# Movement constants
const MAX_SPEED = 50
const ACCELERATION = 400
const FRICTION = 500

func _ready() -> void:
	# Setting character camera limits after this
	# character is instantiated and ready
	set_camera_limit_positions(camera_top_left_x, camera_top_left_y, camera_bottom_right_x, camera_bottom_right_y)

func _physics_process(delta: float) -> void:
	# State Switching
	match (state):
		States.MOVE:
			move_state(delta)
		States.ATTACK:
			attack_state()
		States.HURT:
			hurt_state()

#region Player
var _player = null:
	set(value):
		_player = value
	get:
		return _player

# Check if character is connected to a player
func player_exists() -> bool:
	return _player != null && is_instance_valid(_player)

# Remove player references from this character
# and vice versa
func remove_player() -> void:
	if player_exists():
		_player.remove_character()
		_player = null
#endregion

#region Input 
func input_get_action_strength(action) -> float: 
	if player_exists():
		return _player.input_get_action_strength(action)
	return 0

func input_get_input(action) -> bool:
	if player_exists():
		return _player.input_get_input(action)
	return false

func input_get_input_pressed(action) -> bool:
	if player_exists():
		return _player.input_get_input_pressed(action)
	return false

func input_get_input_released(action) -> bool:
	if player_exists():
		return _player.input_get_input_released(action)
	return false
#endregion

#region States
# Move State
func move_state(delta) -> void:
	# Get input vector from the difference between
	# input action strengths of direction buttons
	# and normalize it to 1
	var input_vector = Vector2.ZERO
	input_vector.x = input_get_action_strength("Right") - input_get_action_strength("Left")
	input_vector.y = input_get_action_strength("Down") - input_get_action_strength("Up")
	input_vector = input_vector.normalized()
	
	# Control character movement 
	# and the playing of movement animation
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

# Attack State
func attack_state() -> void:
	pass

# Hurt State
func hurt_state() -> void:
	pass
#endregion

#region Character Functions
# Call necessary camera limit functions in
# character camera node
func set_camera_limit_positions(tl_x, tl_y, br_x, br_y):
	camera.set_top_left_positions(tl_x, tl_y)
	camera.set_bottom_right_positions(br_x, br_y)
	camera.set_limit_positions()
#endregion
