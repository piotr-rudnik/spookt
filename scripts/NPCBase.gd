class_name NPCBase extends KinematicBody

export(NodePath) var look_target_path = null
var look_target = null

var movement_speed = 6
var gravity = 9.8
var vspeed = 0

var hp = 100
var walk_target = null
var walk_path = null
var path_point = 0
var target_position = null

var current_attack = null

var is_hurt = false
var dead = false

var sees_player = false

export(String) var walk_animation = "walk"
export(String) var idle_animation = "idle"
export(Array) var hurt_animations = ["hurt"]
export(String) var die_animation = "die"
var attacks = []

func play_idle_sound():
	if not dead:
		if not sees_player:
			$IdleSoundPlayer.play()
		$IdleSoundTimer.wait_time = 10 + randf()*10.0

func take_damage(damage):
	if not dead:
		hp -= damage
		hurt_animations.shuffle()
		if hp > 0:
			get_node("Mesh/AnimationPlayer").play(hurt_animations[0])
			is_hurt = true
		else:
			get_node("Mesh/AnimationPlayer").play(die_animation)
			dead = true
			$CollisionShapeDead.disabled = false
			$CollisionShape.disabled = true

func on_attack_timer():
	if current_attack["action"]:
		call(current_attack["action"])

func _ready():
	walk_target = to_global(Vector3(0,0,0.1))#global_transform.origin
	if look_target_path:
		look_target = get_node(look_target_path)
	#$RayCast.add_exception(self)
	$Timer.connect("timeout",self,"find_target")
	$AttackTimer.connect("timeout",self,"on_attack_timer")
	get_node("Mesh/AnimationPlayer").connect("animation_finished",self,"anim_end")
	target_position = global_transform.origin
	find_target()
	
	$IdleSoundTimer.connect("timeout",self,"play_idle_sound")

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

func anim_end(what):
	current_attack = null
	is_hurt = false

func _physics_process(delta):
	vspeed -= gravity * delta
	var movement_vector = Vector3(0,vspeed,0)
	
	if not dead:
		$RayCast.cast_to = look_target.global_transform.origin - $RayCast.global_transform.origin
		$RayCast.force_raycast_update()
		var target_body = $RayCast.get_collider()
		if target_body and target_body.name == "Player":
			target_position = target_body.global_transform.origin
		if walk_path:
			if get_node("../Navigation").get_closest_point(global_transform.origin).distance_squared_to(walk_target) < (0.4*0.4):
				if path_point < len(walk_path)-1:
					path_point += 1
			walk_target = walk_path[path_point]
		if not is_hurt:
			if not current_attack:
				if target_body and target_body.name == "Player":
					sees_player = true
					var target_dist_sqr = global_transform.origin.distance_squared_to($RayCast.get_collision_point())
					for attack in attacks:
						if attack["min_range"]*attack["min_range"] >= target_dist_sqr:
							current_attack = attack
							$AttackTimer.wait_time = attack["time"]
							$AttackTimer.start()
							break
				else:
					sees_player = false
			if current_attack:
				get_node("Mesh/AnimationPlayer").play(current_attack["anim"])
				get_node("DirectionPointer").look_at(target_body.global_transform.origin,Vector3(0,1,0))
				get_node("DirectionPointer").rotation_degrees.y += 180
			elif get_node("../Navigation").get_closest_point(global_transform.origin).distance_squared_to(walk_target) > (0.3*0.3):
				movement_vector = (walk_target - global_transform.origin).normalized()
				get_node("DirectionPointer").look_at(global_transform.origin - movement_vector * Vector3(1,0,1),Vector3(0,1,0))
				get_node("Mesh/AnimationPlayer").play(walk_animation)
			else:
				get_node("Mesh/AnimationPlayer").play(idle_animation)
	move_and_slide(movement_vector * movement_speed + Vector3(0,vspeed,0),Vector3(0,1,0),true)
	if is_on_floor():
		vspeed = 0
	get_node("Mesh").rotation.y = lerp_angle(get_node("Mesh").rotation.y,get_node("DirectionPointer").rotation.y,delta*10)
