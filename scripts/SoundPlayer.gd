class_name SoundPlayer extends AudioStreamPlayer

func destroy():
	queue_free()

func _ready():
	connect("finished",self,"destroy")
	play()
