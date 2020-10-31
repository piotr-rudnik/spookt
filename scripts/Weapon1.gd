class_name Weapon1 
extends Item

var shot_timer = null

var can_shoot = true
func shoot_reset():
	can_shoot = true

func _init():
	model = load("res://scenes/pizza.tscn")
	bullet = load("res://scenes/items/Bullet.tscn")
	item_name = "Weapon1"

func use():
	if can_shoot:
		var bullet_instance = bullet.instance()
		print(bullet_instance.transform.origin)
		get_viewport().add_child(bullet_instance)
		bullet_instance.global_transform = global_transform
		shot_timer.start()
		can_shoot = false

func _ready():
	var mesh_instance = model.instance()
	add_child(mesh_instance)
	
	shot_timer = Timer.new()
	shot_timer.wait_time = 0.2
	shot_timer.one_shot = false
	add_child(shot_timer)
	shot_timer.connect("timeout",self,"shoot_reset")
