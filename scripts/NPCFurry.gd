extends NPCBase

var attack_scene = preload("res://scenes/FurryAttack.tscn")

func _ready():
	hp = 100
	$RayCast.transform.origin.y = 1
	hurt_animations = ["hurt1","hurt2"]
	attacks = [
		{
			"anim": "attack",
			"time": 1,
			"action": "attack",
			"min_range": 6,
		}
	]

func attack():
	var inst = attack_scene.instance()
	inst.time = 0.3
	inst.transform.origin.z = 6
	inst.transform.origin.y = 2
	inst.bodies_collided = [self]
	get_node("Mesh").add_child(inst)
