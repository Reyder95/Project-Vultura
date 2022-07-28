extends Node2D

onready var galaxy = get_node("Galaxy")
onready var game_camera = galaxy.get_node("Camera")
onready var inspector = get_node("CanvasLayer/Inspector")

var game_camera_pos
var system_scene

func _ready():
	galaxy.connect("system_entered", self, "_on_system_entered");
	galaxy.connect("star_hovered", self, "_on_star_hovered");
	galaxy.connect("star_exited", self, "_on_star_exited");
	
func _on_system_entered(star, system):
	game_camera_pos = game_camera.position		# Save galaxy camera position
	galaxy.visible = false		# Prevent galaxy from being on the screen and us being able to click it
	system_scene = load("res://Scenes/Viewable Scenes/System.tscn").instance()
	game_camera.camera_drag = false
	system_scene.initialize_system(system)
	system_scene.get_node("Camera").set_zoom_max(Vector2(2.0, 2.0))
	system_scene.connect("system_exited", self, "_on_system_exited");
	system_scene.connect("planet_hovered", self, "_on_planet_hovered");
	add_child(system_scene)
	
func _on_system_exited():
	game_camera.position = game_camera_pos
	galaxy.visible = true
	system_scene.queue_free()
	game_camera.current = true
	
func _on_star_hovered(star):
	
	inspector.get_node("Panel/Planet").visible = false
	
	inspector.get_node("Panel/Star").visible = true
	inspector.get_node("Panel/Star/System Value").text = star.system_name
	inspector.get_node("Panel/Star/Star Type Value").text = Functions.star_objects[star.star_type].name
	inspector.get_node("Panel/Star/Sprite").set_texture(load("res://Sprites and Images/Astral/Stars/" + Functions.star_objects[star.star_type].filename))
	
func _on_star_exited():
	inspector.get_node("Panel/Star").visible = false
	
func _on_planet_hovered(planet):
	
	inspector.get_node("Panel/Planet").visible = true
	inspector.get_node("Panel/Planet/Planet Value").text = planet.planet_name
	inspector.get_node("Panel/Planet/Planet Type Value").text = Functions.planet_objects[planet.planet_type].name
	inspector.get_node("Panel/Planet/Sprite").set_texture(load("res://Sprites and Images/Astral/Planets/" + Functions.planet_objects[planet.planet_type].filename))
	inspector.get_node("Panel/Planet/ResourceInfo").visible = false
	
	var resource_table = inspector.get_node("Panel/Planet/Table")
	
	resource_table.clear_resources()
	
	for resource in planet.resources:
		resource_table.add_resource(resource)
