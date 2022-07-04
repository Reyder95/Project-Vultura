extends Node2D

var star_scene = preload("res://Scenes/Prefabs/Star.tscn")
var planet_scene = preload("res://Scenes/Prefabs/Planet.tscn")

var system
var star
var celestial_bodies

func _ready():
	get_node("Camera").set_camera_bounds(-2500, 2500, -2500, 2500)
	
func initialize_system(system_class):
	system = system_class
	star = system.star
	
	for orbit in star.orbits:
		print("Planet Node: ", orbit.celestial_body)
		print("Angle: ", orbit.angle)
		print("Radius: ", orbit.radius)
	
	place_star()
	place_planets()
	
func place_star():
	var star_scene_instance = star_scene.instance()
	
	star_scene_instance.manual_initialize(star, system, 0, 0)
	
	add_child(star_scene_instance)

func place_planets():
	var orbit_positions = Array()
	for orbit in star.orbits:
		orbit_positions.append_array(orbit.determine_orbits(Vector2(0, 0)))
		
	celestial_bodies = orbit_positions
		
	for orbit in orbit_positions:
		var planet_scene_instance = planet_scene.instance()
		planet_scene_instance.position = orbit.position
		add_child(planet_scene_instance)
		print("Positions: (" + str(orbit.position.x) + "," + str(orbit.position.y) + ")")
		print("Celestial Body: ", orbit.celestial_body)
		
func _draw():
	var angle_from = 0
	var angle_to = 360
	var color = Color(255, 255, 255)
	
	for body in celestial_bodies:
		draw_circle_arc(Vector2(0, 0), body.orbit.radius, angle_from, angle_to, color, 128)
	
func draw_circle_arc(center, radius, angle_from, angle_to, color, points):
	var nb_points = points
	var points_arc = PoolVector2Array()
	
	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
		
	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color)
		
