class_name Item
extends Spatial

var item_name
var model
var bullet

var bullet_damage
var shooting_speed

func use():
	
	var bullet_instance = bullet.instance()
	bullet_instance.bullet_damage = bullet_damage
	
	print(bullet_instance.transform.origin)
	get_viewport().add_child(bullet_instance)
	bullet_instance.global_transform = global_transform

func _ready():
	pass # Replace with function body.
