extends CharacterBody3D

#@export var camera : Camera3D

const GRAVITY = -9.81
const JUMP_SPEED = 10
const FLOOR_NORMAL = Vector3(0, 1, 0)

var is_grounded = false

signal set_movement_state(_movement_state: MovementState)
signal set_movement_direction(_movement_direction: Vector3)

@export var movement_states : Dictionary

var movement_direction : Vector3
#var camera_direction : Vector3

func _input(event):
	if event.is_action("movement"):
		# forward movement direction = camera direction exactly
		# left movement direction = camera direction - 90 degrees
		# right movement direction = camera direction + 90 degrees
		movement_direction.x = (Input.get_action_strength("left") - Input.get_action_strength("right"))
		movement_direction.z = (Input.get_action_strength("forward") - Input.get_action_strength("back"))
		#print("camera y rotation: ", camera.global_rotation_degrees.y)
		if Input.is_action_pressed("jump"):
				velocity.y = JUMP_SPEED
		if is_movement_ongoing():
			if Input.is_action_pressed("sprint"):
				set_movement_state.emit(movement_states["sprint"])
			else:
				if Input.is_action_pressed("walk"):
					set_movement_state.emit(movement_states["walk"])
				else:
					set_movement_state.emit(movement_states["run"])
		else:
			set_movement_state.emit(movement_states["stand"])

func _ready():
	set_movement_state.emit(movement_states["stand"])

func _physics_process(delta):
	if is_grounded:
		velocity.y = 0

	velocity.y += GRAVITY * delta
	move_and_slide()
	if is_movement_ongoing():
		set_movement_direction.emit(movement_direction)
	
func is_movement_ongoing() -> bool:
	return abs(movement_direction.x) > 0 or abs(movement_direction.z) > 0

func _on_FloorDetector_body_entered(body):
	is_grounded = true

func _on_FloorDetector_body_exited(body):
	is_grounded = false
