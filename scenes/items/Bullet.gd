class_name Bullet
extends KinematicBody

func _ready():
	print("Bullet spawned")
	pass

func _physics_process(delta):
	var movement = Vector3(1,0,0)
	move_and_slide(movement, Vector3.UP)
