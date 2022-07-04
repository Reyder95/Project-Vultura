extends Node2D

onready var galaxy = get_node("Galaxy")
onready var game_camera = galaxy.get_node("Camera")

var game_camera_pos
var system

func _ready():
	galaxy.connect("system_entered", self, "_on_system_entered");
	
func _on_system_entered(star):
	game_camera_pos = game_camera.position		# Save galaxy camera position
	galaxy.visible = false		# Prevent galaxy from being on the screen and us being able to click it
	system = load("res://Scenes/Viewable Scenes/System.tscn").instance()
	system.get_node("Camera").set_zoom_max(Vector2(2.0, 2.0))
	add_child(system)
