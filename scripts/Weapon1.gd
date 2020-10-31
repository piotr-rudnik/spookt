class_name Weapon1 
extends Item

func _init():
	model = load("res://scenes/pizza.tscn")
	bullet = load("res://scenes/items/Bullet.tscn")
	item_name = "Pizza"
	bullet_damage = 10

func _ready():
	var mesh_instance = model.instance()
	add_child(mesh_instance)
