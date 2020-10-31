extends KinematicBody

var speed = 8
var ground_acceleration = 8
var air_acceleration = 2
var acceleration = ground_acceleration
var jump = 4.5
var gravity = 9.8
var stick_amount = 10
var mouse_sensitivity = 10

var direction = Vector3()
var velocity = Vector3()
var movement = Vector3()
var gravity_vec = Vector3()
var grounded = true

signal item_change


func set_item():
	pass
	


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event):
	emit_signal("item_change")
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * mouse_sensitivity / 10
		$Head.rotation_degrees.x = clamp($Head.rotation_degrees.x - event.relative.y * mouse_sensitivity / 10, -90, 90)
		$Head.rotation_degrees.y = clamp($Head.rotation_degrees.y - event.relative.y * mouse_sensitivity / 10, -90, 90)
		#print("Mouse rotation")
		#print(event.to_string())

	direction = Vector3()
	
	if Input.is_action_pressed("ui_up"):
		#print("up")
		direction.z = -speed
	if Input.is_action_pressed("ui_down"):
		#print("down")
		direction.z = speed
	if Input.is_action_pressed("ui_left"):
		#print("left")
		direction.x = -speed
	if Input.is_action_pressed("ui_right"):
		print("right")
		direction.x = speed
	
	#direction.z = -Input.is_action_pressed("ui_up") + Input.is_action_pressed("ui_down")
	#direction.x = -Input.is_action_pressed("ui_left") + Input.is_action_pressed("ui_right")
	direction = direction.normalized().rotated(Vector3.UP, rotation.y)

func _physics_process(delta):

	"""	
	if is_on_floor():
		gravity_vec = -get_floor_normal() * stick_amount
		acceleration = ground_acceleration
		grounded = true
	else:
		if grounded:
			gravity_vec = Vector3.ZERO
			grounded = false
		else:
			gravity_vec += Vector3.DOWN * gravity * delta
			acceleration = air_acceleration

	if Input.is_action_just_pressed("jump") and is_on_floor():
		grounded = false
		gravity_vec = Vector3.UP * jump
	"""
	
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	movement.z = velocity.z + gravity_vec.z
	movement.x = velocity.x + gravity_vec.x
	movement.y = gravity_vec.y

	#print("Move")
	#print(movement)
	move_and_slide(movement, Vector3.UP)
	

