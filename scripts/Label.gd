extends Label

export(String) var character_path_string
var character 
var item_name = "Nice"
var hp = 100

func _ready():
	character = get_node(character_path_string)
	character.connect("item_change", self, "_on_character_item_change")
	character.connect("player_hp_change", self, "_on_character_hp_change")
	on_size_changed()
	get_tree().get_root().connect("size_changed",self,"on_size_changed")

func _on_character_hp_change(new_hp):
	hp = new_hp
	update_text()

func _on_character_item_change(item_name):
	print("Item changed")
	text = item_name
	update_text()

func update_text():
	text = "Current item: " + item_name + "\n HP: " + String(hp)
	
func on_size_changed():
	rect_position = get_tree().get_root().size - rect_size


