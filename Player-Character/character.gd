extends Node2D

#region player
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
