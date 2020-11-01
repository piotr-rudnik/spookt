extends Area

export(Resource) var next_scene

func on_body_enter(body):
	if body.name == "Player":
		if body.get("has_key"):
			get_node("..").queue_free()
			var scn = next_scene.instance()
			get_parent().get_parent().add_child(scn)
			get_node("../../Player").global_transform.origin = scn.get_node("PlayerPos").global_transform.origin

func _ready():
	connect("body_entered",self,"on_body_enter")
