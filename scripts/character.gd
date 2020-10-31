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

var inventory = []
var current_item

signal item_change

func set_current_item(item):
	print("Setting new item " + item.to_string())
	var origin = $Head.get_node("current_item").transform.origin
	item.transform.origin = origin
	$Head.get_node("current_item").replace_by(item)
	print("Event item_change")
	emit_signal("item_change", item.item_name)

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	set_current_item(Weapon1.new())

func _input(event):
	
	######################################
	## Action keys
	######################################
	if Input.is_action_pressed("ui_weapon_change"):
		set_current_item(Weapon1.new())
	
	######################################
	## Mouse input
	######################################
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * mouse_sensitivity / 10
		$Head.rotation_degrees.x = clamp($Head.rotation_degrees.x - event.relative.y * mouse_sensitivity / 10, -90, 90)
		$Head.rotation_degrees.y = clamp($Head.rotation_degrees.y - event.relative.y * mouse_sensitivity / 10, -90, 90)

	######################################
	## Movement input
	######################################
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
	

