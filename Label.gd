extends Label

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(String) var character_path_string
var character 

# Called when the node enters the scene tree for the first time.
func _ready():
	print("label ready")
	character = get_node(character_path_string)
	character.connect("item_change", self, "_on_character_item_change")
	on_size_changed()
	get_tree().get_root().connect("size_changed",self,"on_size_changed")

func _on_character_item_change():
	print("Item changed")
	
	
func on_size_changed():
	rect_position = get_tree().get_root().size - rect_size


