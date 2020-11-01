class_name Item
extends Spatial

var item_name
var model
var bullet

var bullet_damage
var shooting_speed

func spawn_bullet(speed):
	var bullet_instance = bullet.instance()
	print(bullet_instance.transform.origin)
	get_viewport().add_child(bullet_instance)
	bullet_instance.global_transform = global_transform

var actions = [
	[0.2, "spawn_bullet", [100]]
]

var shot_timer = null

var can_shoot = true
func shoot_reset():
	can_shoot = true

func use():
	if can_shoot:
		callv(actions[0][1],actions[0][2])
		shot_timer.start()
		can_shoot = false

func _ready():
	actions.shuffle()
	shot_timer = Timer.new()
	shot_timer.wait_time = actions[0][0]
	shot_timer.one_shot = true
	add_child(shot_timer)
	shot_timer.connect("timeout",self,"shoot_reset")

	var mesh_instance = model.instance()
	add_child(mesh_instance)
