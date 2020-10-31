extends Camera

var mouse_sensitivity = 0.004
var movement_speed = 128

func _physics_process(delta):
	var mouse_move = get_viewport().size/2 - get_viewport().get_mouse_position()
	get_viewport().warp_mouse(get_viewport().size/2)
	
	rotation.y += mouse_move.x * mouse_sensitivity
	rotation.x += mouse_move.y * mouse_sensitivity
	rotation_degrees.x = clamp(rotation_degrees.x,-89.5,89.5)
	
	var move_z = Vector3(0,0,1) * (float(Input.is_action_pressed("ui_down")) - float(Input.is_action_pressed("ui_up")))
	var move_x = Vector3(1,0,0) * (float(Input.is_action_pressed("ui_right")) - float(Input.is_action_pressed("ui_left")))
	
	global_transform.origin = to_global((move_z+move_x) * delta)
