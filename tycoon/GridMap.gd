extends GridMap

var plane : Plane
@export var view_camera : Camera3D
@export var selector : Node3D
var gridmap_position : Vector3
var world_position : Vector3

# Called when the node enters the scene tree for the first time.
func _ready():
	plane = Plane(Vector3.UP, Vector3.ZERO)

func _input(event):
	if event is InputEventMouseButton:
		# plant a carrot
		if (world_position.x != null):
			if (world_position.z != null):
				set_cell_item(gridmap_position, 4, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	world_position = plane.intersects_ray(
		view_camera.project_ray_origin(get_viewport().get_mouse_position()),
		view_camera.project_ray_normal(get_viewport().get_mouse_position()))
	
	gridmap_position = Vector3(round(world_position.x), 0, round(world_position.z))
	if (world_position.x != null):
		if (world_position.z != null):
			selector.position = lerp(selector.position, gridmap_position, delta * 40)
	#print(gridmap_position)
