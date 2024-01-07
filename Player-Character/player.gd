extends Node

#region Character
# Create character variable
var character = null:
	set(value):
		character = value
	get:
		return character

# Character Scene and instance variable
var characterInstance
var characterScene: PackedScene = preload("res://Player-Character/character.tscn")

# Instantiate the character into the scene
func create_character(x, y, node) -> void:
	characterInstance = characterScene.instantiate()
	character = characterInstance
	get_parent().get_node(node).call_deferred("add_child", characterInstance)
	characterInstance.global_position.x = x
	characterInstance.global_position.y = y
	characterInstance.player = self

# Set character camera limit positions 
# when character is created
func set_character_camera_limit_positions(tl_x, tl_y, br_x, br_y):
	characterInstance.camera_top_left_x = tl_x
	characterInstance.camera_top_left_y = tl_y
	characterInstance.camera_bottom_right_x = br_x
	characterInstance.camera_bottom_right_y = br_y

# Destroy character
func destroy_character() -> void:
	if character != null:
		characterInstance.queue_free()
		remove_character()

# Remove the character reference
func remove_character() -> void:
	character = null
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
