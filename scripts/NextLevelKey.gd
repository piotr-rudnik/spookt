class_name NextLevelKey extends StaticBody

onready var mesh = get_node("eyestone")

func _physics_process(delta):
	mesh.rotation.y += delta
	get_node("eyestone/AnimationPlayer").play("idle")
