extends Node2D

onready var galaxy = get_node("Galaxy")
onready var game_camera = galaxy.get_node("Camera")

var game_camera_pos
var system_scene

func _ready():
	galaxy.connect("system_entered", self, "_on_system_entered");
	
func _on_system_entered(star, system):
	game_camera_pos = game_camera.position		# Save galaxy camera position
	galaxy.visible = false		# Prevent galaxy from being on the screen and us being able to click it
	system_scene = load("res://Scenes/Viewable Scenes/System.tscn").instance()
	game_camera.camera_drag = false
	system_scene.initialize_system(system)
	system_scene.get_node("Camera").set_zoom_max(Vector2(2.0, 2.0))
	system_scene.connect("system_exited", self, "_on_system_exited");
	add_child(system_scene)
	
func _on_system_exited():
	game_camera.position = game_camera_pos
	galaxy.visible = true
	system_scene.queue_free()
	game_camera.current = true
	
