extends Viewport

func on_size_changed():
	size = get_tree().get_root().size

func _ready():
	on_size_changed()
	get_tree().get_root().connect("size_changed",self,"on_size_changed")
