class_name Weapon2
extends Item

func _init():
	model = load("res://scenes/skorpion.tscn")
	bullet = load("res://scenes/items/Bullet.tscn")
	item_name = "Skorpion"
	#bullet_damage = 20
	#shooting_speed = 0.2
