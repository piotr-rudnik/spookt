extends Area

var bodies_collided = []
export(float) var damage = 1
export(float) var time = 1

func _physics_process(delta):
	for body in get_overlapping_bodies():
		if not (body in bodies_collided):
			if body.has_method("take_damage"):
				body.call("take_damage",damage)
			print(body.name)
			bodies_collided.append(body)

func destroy():
	queue_free()

func _ready():
	$Timer.connect("timeout",self,"destroy")
	$Timer.wait_time = time
	$Timer.start()
