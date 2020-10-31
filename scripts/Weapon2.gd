class_name Weapon2
extends Item

func _init():
	model = load("res://models/items/weapon2.glb")
	item_name = "Weapon2"

func _ready():
	var mesh_instance = model.instance()
	add_child(mesh_instance)
