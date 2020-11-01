class_name EnemySpawn extends Spatial

var enemies = [
	preload("res://scenes/NPCFurry.tscn"),
	preload("res://scenes/NPCGuzik.tscn")
]

func _ready():
	enemies.shuffle()
	var inst = enemies[0].instance()
	inst.look_target_path = "../../Player"
	get_parent().call_deferred("add_child",inst)
	inst.transform.origin = transform.origin
