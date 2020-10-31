class_name Item
extends Spatial

var item_name
var model
var bullet

func use():
	var bullet_instance = bullet.instance()
	print(bullet_instance.transform.origin)
	get_viewport().add_child(bullet_instance)
	bullet_instance.global_transform = global_transform



func _ready():
	pass # Replace with function body.
