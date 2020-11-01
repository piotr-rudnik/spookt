extends Viewport


func on_size_changed():
	print("asdf")
	size = get_tree().get_root().size
	
	var sprite = get_node("main_menu_background")
	var viewportWidth = get_viewport().size.x
	var viewportHeight = get_viewport().size.y
	
	var x_scale = viewportWidth / sprite.texture.get_size().x
	var y_scale = viewportHeight / sprite.texture.get_size().y

	# Optional: Center the sprite, required only if the sprite's Offset>Centered checkbox is set
	#$Sprite.set_position(Vector2(viewportWidth/2, viewportHeight/2))
	#$Sprite.set_scale(Vector2(scale, scale))
	
	get_node("main_menu_background").set_scale(Vector2(x_scale, y_scale))

func _ready():
	on_size_changed()
	get_tree().get_root().connect("size_changed",self,"on_size_changed")
