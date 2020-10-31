class_name Item
extends Spatial

var item_name
var model
var bullet

func use():
	var bullet_instance = bullet.instance()
	get_tree().get_root().add_child(bullet_instance)


func _ready():
	pass # Replace with function body.
