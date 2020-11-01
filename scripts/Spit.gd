class_name Spit
extends KinematicBody

var speed = 20
var bullet_damage = 10

var gravity = 3
var vspeed = 1

func _ready():
	#add_collision_exception_with(get_node("../Player"))
	pass

func _physics_process(delta):
	vspeed -= gravity * delta
	var movement = global_transform.origin - to_global(Vector3(0,0,-1) * speed) + Vector3(0,vspeed,0)
	move_and_slide(movement, Vector3.UP)
	
	for i in get_slide_count():
		var col = get_slide_collision(i)
		if col.collider.has_method("take_damage"):
			col.collider.call("take_damage",bullet_damage)
		queue_free()
