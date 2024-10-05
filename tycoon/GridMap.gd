extends GridMap


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		#print("Mouse Click/Unclick at: ", event.position)
		print(get_viewport().get_mouse_position())
	#elif event is InputEventMouseMotion:
		#print("Mouse Motion at: ", event.position)
		
	#print(get_viewport().get_mouse_position())

# Called every frame. 'delta' is the elapsed time since the previous frame.
