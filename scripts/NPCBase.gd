extends KinematicBody

export(NodePath) var look_target_path = null
var look_target = null

var movement_speed = 1
var gravity = 9.8
var vspeed = 0

var walk_target = null
var walk_path = null
var path_point = 0
var target_position = null

func _ready():
	walk_target = global_transform.origin
	if look_target_path:
		look_target = get_node(look_target_path)
	#$RayCast.add_exception(self)
	$Timer.connect("timeout",self,"find_target")
	target_position = global_transform.origin

func find_target():
	if look_target:
		#walk_target = target_body.global_transform.origin
		#walk_target = get_node("../Navigation").get_closest_point(target_body.global_transform.origin)
		var me_point = get_node("../Navigation").get_closest_point(global_transform.origin)
		var you_point = get_node("../Navigation").get_closest_point(target_position)
		walk_path = get_node("../Navigation").get_simple_path(me_point,you_point)
		#print(walk_path)
		path_point = 1
		if walk_path:
			walk_target = walk_path[1]
			#print(walk_target)

func _physics_process(delta):
	$RayCast.cast_to = look_target.global_transform.origin - $RayCast.global_transform.origin
	$RayCast.force_raycast_update()
	var target_body = $RayCast.get_collider()
	if target_body and target_body.name == "Player":
		target_position = target_body.global_transform.origin
	vspeed -= gravity * delta
	if walk_path:
		if get_node("../Navigation").get_closest_point(global_transform.origin).distance_squared_to(walk_target) < (0.4*0.4):
			if path_point < len(walk_path)-1:
				path_point += 1
		walk_target = walk_path[path_point]
	var movement_vector = (walk_target - global_transform.origin).normalized()
	move_and_slide(movement_vector * movement_speed + Vector3(0,vspeed,0),Vector3(0,1,0),true)
	if is_on_floor():
		vspeed = 0
