extends Node2D

@export var level_name = ""

#var xx = get_viewport().size.x / 2
#var yy = get_viewport().size.y / 2

var xx = 10
var yy = 10

func _physics_process(delta: float) -> void:
	if Player.input_get_input("ui_accept"):
		Player.create_character(xx, yy, level_name) 
		Player.set_character_camera_limit_positions(0, 0, 511, 416)
	
	if Player.input_get_input("ui_cancel"):
		Player.destroy_character()
