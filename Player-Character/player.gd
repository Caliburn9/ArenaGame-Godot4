extends Node

#region Character
# Create character variable
var _character = null:
	set(value):
		_character = value
	get:
		return _character

# Character Scene and instance variable
var characterInstance
var characterScene: PackedScene = preload("res://Player-Character/character.tscn")

# Instantiate the character into the scene
func create_character(x, y, node) -> void:
	characterInstance = characterScene.instantiate()
	_character = characterInstance
	get_parent().get_node(node).call_deferred("add_child", characterInstance)
	characterInstance.global_position.x = x
	characterInstance.global_position.y = y
	characterInstance._player = self

# Set character camera limit positions 
# when character is created
# This should be called after create_character()
# and is the primary function for setting 
# the character camera's limits
func set_character_camera_limit_positions(tl_x, tl_y, br_x, br_y):
	characterInstance.camera_top_left_x = tl_x
	characterInstance.camera_top_left_y = tl_y
	characterInstance.camera_bottom_right_x = br_x
	characterInstance.camera_bottom_right_y = br_y

# Destroy character
func destroy_character() -> void:
	if _character != null:
		characterInstance.queue_free()
		remove_character()

# Check if character exists
func character_exists() -> bool:
	if _character != null:
		return true
	return false

# Remove the character reference
func remove_character() -> void:
	_character = null
#endregion

#region Input 
func input_get_action_strength(action) -> float: 
	return Input.get_action_strength(action)

func input_get_input(action) -> bool:
	return Input.is_action_just_pressed(action)

func input_get_input_pressed(action) -> bool:
	return Input.is_action_pressed(action)

func input_get_input_released(action) -> bool:
	return Input.is_action_just_released(action)
#endregion
