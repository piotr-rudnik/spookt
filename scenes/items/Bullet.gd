class_name Bullet
extends KinematicBody

var speed = 100

func _ready():
	print("Bullet spawned")
	pass

func _physics_process(delta):
	
	var movement = global_transform.origin - to_global(Vector3(0,0,1) * speed)
	move_and_slide(movement, Vector3.UP)
	#print("dfg")
