class_name Item
extends KinematicBody

var item_name
var model
var bullet

func use():
	var bullet_instance = bullet.instance()
	bullet_instance.transform.origin = transform.origin
	get_viewport().add_child(bullet_instance)

func _ready():
	pass # Replace with function body.
