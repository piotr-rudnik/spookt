class_name Bullet
extends KinematicBody

var speed = 1000
var bullet_damage = 10

func _physics_process(delta):
	
	var movement = global_transform.origin - to_global(Vector3(0,0,1) * speed)
	move_and_slide(movement, Vector3.UP)
	
	for i in get_slide_count():
		var col = get_slide_collision(i)
		if col.collider.has_method("take_damage"):
			col.collider.call("take_damage",bullet_damage)
		queue_free()
