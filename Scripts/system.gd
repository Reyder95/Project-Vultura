extends Node

func _ready():
	get_node("Camera").set_camera_bounds(-2500, 2500, -2500, 2500)
