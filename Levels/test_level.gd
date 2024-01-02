extends Node2D

func _physics_process(delta: float) -> void:
	if Player.input_get_input("ui_accept"):
		Player.create_character(get_viewport().size.x / 2, get_viewport().size.y / 2) 
	
	if Player.input_get_input("ui_cancel"):
		Player.destroy_character()
