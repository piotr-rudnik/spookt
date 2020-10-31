extends KinematicBody

var speed = 8
var ground_acceleration = 8
var air_acceleration = 2
var acceleration = ground_acceleration
var jump = 4.5
var gravity = 9.8
var stick_amount = 10
var mouse_sensitivity = 10
var hp = 100
var grounded = true

var inventory = []
var weapons = []

signal item_change
signal player_hp_change

var can_change_weapon = true

onready var current_item = get_node("Head/current_item")

func take_damage(damage):
	hp -= damage
	emit_signal("player_hp_change", hp)

func change_weapon_next():
	set_current_item(_get_next_weapon())

func _get_next_weapon():
	var current_weapon_index = weapons.find(current_item)	
	
	if current_weapon_index + 1 == weapons.size():
		return weapons[0]
	
	return weapons[current_weapon_index + 1]
	
func set_current_item(item):
	print("Setting new item " + item.to_string())
	var origin = current_item.transform.origin
	item.transform.origin = origin
	$Head.remove_child(current_item)
	current_item = item
	$Head.add_child(current_item)
	emit_signal("item_change", item.item_name)

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	weapons.append(Weapon1.new())
	weapons.append(Weapon2.new())
	set_current_item(weapons[0])

func _input(event):

	######################################
	## Mouse input
	######################################
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * mouse_sensitivity / 10
		$Head.rotation_degrees.x = clamp($Head.rotation_degrees.x - event.relative.y * mouse_sensitivity / 10, -90, 90)

func _physics_process(delta):
	
	######################################
	## Action keys
	######################################
	if Input.is_action_pressed("ui_weapon_change"):
		if can_change_weapon:
			change_weapon_next()
			can_change_weapon = false
	
	if !Input.is_action_pressed("ui_weapon_change"):
		can_change_weapon = true

	if Input.is_action_pressed("ui_shoot"):
		current_item.use()
	
	######################################
	## Movement input
	######################################
	var movement_vector = Vector3(
		float(Input.is_action_pressed("ui_right")) - float(Input.is_action_pressed("ui_left")),
		0,
		float(Input.is_action_pressed("ui_down")) - float(Input.is_action_pressed("ui_up"))
		).normalized() * speed
	move_and_slide(movement_vector.rotated(Vector3(0,1,0),rotation.y),Vector3(0,1,0))
