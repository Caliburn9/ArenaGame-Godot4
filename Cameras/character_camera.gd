extends Camera2D

@onready var topLeft = $Limits/TopLeft
@onready var bottomRight = $Limits/BottomRight

# Set coordinates of top-left marker2d
func set_top_left_positions(xx, yy):
	topLeft.position.x = xx
	topLeft.position.y = yy

# Set coordinates of bottom-right marker2d
func set_bottom_right_positions(xx, yy):
	bottomRight.position.x = xx 
	bottomRight.position.y = yy

# Take both marker2d coordinates and apply them to the camera
func set_limit_positions():
	limit_top = topLeft.position.y
	limit_left = topLeft.position.x
	limit_bottom = bottomRight.position.y 
	limit_right = bottomRight.position.x 
