extends CharacterBody3D

#camera parameters
@export var camera_target: Node3D
@export var camera_parent: Node3D
var camera_T = float()
var cam_speed = float()

# Player parameter
var inputdir = Vector3()

# Animation condition states
var anim_canmove = bool()

# Input
var horizontal = float()
var vertical = float()
# Physics values
var direction = Vector3()
var vertical_velocity = Vector3()
var turn_speed = 10
var root_velocity = Vector3()

func angle_rotation():
	var target_direction = (Vector3.BACK * inputdir.z + Vector3.RIGHT * inputdir.x).rotated(Vector3.UP, camera_T)
	var cam_direction = Vector3.BACK.rotated(Vector3.UP, camera_T)
	var forward_direction = global_transform.basis.z.normalized()
	
	#angle_diff = rad_to_deg(forward_direction.signed_angle_to(target_direction, Vector3.UP))
	#cam_angle_diff = rad_to_deg(forward_direction.signed_angle_to(cam_direction, Vector3.UP))

func camera_smooth_follow(delta):
	var cam_offset = Vector3(-1, 1.5, 0).rotated(Vector3.UP, camera_T)
	cam_speed = 250
	var cam_timer = clamp(delta * cam_speed / 20, 0, 1)
	camera_parent.global_transform.origin = camera_parent.global_transform.origin.lerp(self.global_transform.origin + cam_offset, cam_timer)

func _process(delta):
	horizontal = Input.get_axis("ui_right", "ui_left")
	vertical = Input.get_axis("ui_down", "ui_up")
	

func _physics_process(delta):
	camera_smooth_follow(delta)
	camera_T = camera_target.global_transform.basis.get_euler().y
	inputdir = Vector3(horizontal, 0, vertical).normalized()
	
	if(inputdir != Vector3.ZERO):
		direction = Vector3(horizontal,0,vertical).rotated(Vector3.UP, camera_T).normalized()
		anim_canmove = true
	else:
		anim_canmove = false
	
	velocity.x = horizontal * turn_speed
	velocity.z = vertical * turn_speed
	rotation.y = lerp_angle(rotation.y, atan2(direction.x, direction.z), turn_speed * delta)
	move_and_slide()
	angle_rotation()
