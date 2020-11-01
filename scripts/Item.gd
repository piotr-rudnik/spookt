class_name Item
extends Spatial

var item_name
var model
var bullet

#var bullet_damage
#var shooting_speed

var mesh_instance
var sound_player

func spawn_bullet(speed,damage):
	var bullet_instance = bullet.instance()
	print(bullet_instance.transform.origin)
	get_viewport().add_child(bullet_instance)
	bullet_instance.global_transform = global_transform
	bullet_instance.speed = speed
	bullet_instance.bullet_damage = damage

func play_sound():
	sound_player.play()

func heal(n):
	var inst = SoundPlayer.new()
	inst.stream = load("res://sound/eat_.wav")
	get_parent().add_child(inst.stream)
	get_node("../../Player").hp += n
	get_node("../../Player").emit_signal("player_hp_change",get_node("../../Player").hp)
	queue_free()

var ammo = 0

var actions = [
	[0.2, "spawn_bullet", [250,10], 30, load("res://sound/gune.wav")],
	[1, "play_sound", [], 16000, load("res://sound/horn.wav")],
	[1, "heal", [10], load("res://sound/eat_.wav")]
]

var models = [
	["Pizza",load("res://scenes/pizza.tscn")],
	["Skorpion",load("res://scenes/skorpion.tscn")],
	["Flintlock",load("res://scenes/flintlock.tscn")]
]

var shot_timer = null

var can_shoot = true
func shoot_reset():
	can_shoot = true

func use():
	if can_shoot:
		if ammo > 0:
			sound_player.play()
			callv(actions[0][1],actions[0][2])
			shot_timer.start()
			can_shoot = false
			ammo -= 1

func _ready():
	randomize()
	actions.shuffle()
	shot_timer = Timer.new()
	shot_timer.wait_time = actions[0][0]
	shot_timer.one_shot = true
	add_child(shot_timer)
	shot_timer.connect("timeout",self,"shoot_reset")

	models.shuffle()
	model = models[0][1]
	item_name = models[0][0]

	mesh_instance = model.instance()
	add_child(mesh_instance)
	
	bullet = load("res://scenes/items/Bullet.tscn")
	
	ammo = actions[0][3]
	
	sound_player = AudioStreamPlayer.new()
	sound_player.stream = actions[0][4]
	add_child(sound_player)
