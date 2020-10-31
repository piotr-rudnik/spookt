class_name Weapon2
extends Item

func _init():
	model = load("res://scenes/skorpion.tscn")
	bullet = load("res://scenes/items/Bullet.tscn")
	item_name = "Skorpion"
	bullet_damage = 20

func _ready():
	var mesh_instance = model.instance()
	add_child(mesh_instance)
