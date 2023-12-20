extends Node

# Create character variable
# The setter and getter functions assert false to 
# create a "false private" variable that cannot
# be accessed outside the script
var character = null:
	set(value):
		assert(false)
	get:
		assert(false)

var characterInstance
var characterScene: PackedScene = preload("res://Character/Character.tscn")

# Instantiate the character into the scene
func create_character():
	characterInstance = characterScene.instantiate()
	character = characterInstance

# Destroy character
func destroy_character():
	if character != null:
		characterInstance.queue_free()
		remove_character()

# Remove the character reference
func remove_character():
	character = null

#region handling input 
#endregion
