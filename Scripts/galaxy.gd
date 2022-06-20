extends Node2D

onready var camera = get_node("Camera");

func _ready():
	camera.set_camera_bounds(-5000, 5000, -5000, 5000)
