extends Node

var star_scene = preload("res://Scenes/Prefabs/Star.tscn")

var system

func _ready():
	get_node("Camera").set_camera_bounds(-2500, 2500, -2500, 2500)
	
func initialize_system(system_class):
	system = system_class
	
func place_star(star_class):
	var star_scene_instance = star_scene.instance()
	
	star_scene.initialize_star(system.star)
