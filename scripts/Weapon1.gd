class_name Weapon1 
extends Item

func _init():
	model = load("res://models/items/weapon1.glb")
	bullet = load("res://models/ammo1.glb")
	item_name = "Weapon1"

func _ready():
	var mesh_instance = model.instance()
	add_child(mesh_instance)

func use():
	var bullet_instance = bullet.instance()
	get_tree().get_root().add_child(bullet_instance)
