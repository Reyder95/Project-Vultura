extends Node2D

onready var camera = get_node("Camera");

var galaxy_radius = 5000
var max_stars = 2000
var galaxy_center_spacing = 400
var galaxy_center = Vector2(0, 0)
var rng

var star_scene = preload("res://Scenes/Prefabs/Star.tscn")

func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	generate_starmap()
	
	camera.set_camera_bounds(-7500, 7500, -7500, 7500)		# Set the camera bounds for this scene

func generate_starmap():
	var counter = galaxy_center_spacing + 1
	var star_counter = 0;
	var increase_angle = 0;
	
	while counter < galaxy_center_spacing + galaxy_radius || star_counter < max_stars:
		
		# The Vector2 coordinates for this star's position on the galaxy map
		var star_pos = Vector2(galaxy_center.x + (0 * cos(deg2rad(increase_angle)) + counter * sin(deg2rad(increase_angle))), galaxy_center.y + (-1 * ((0 * sin(deg2rad(increase_angle))) + counter * cos(deg2rad(increase_angle)))))
		
		var randomize_value = rng.randi_range(0, 99)
		var star_type
		
		if randomize_value >= 0 and randomize_value < 25:
			star_type = Functions.StarType.MAIN_SEQUENCE
		elif randomize_value >= 25 and randomize_value < 50:
			star_type = Functions.StarType.SUPER_GIANT
		elif randomize_value >= 50 and randomize_value < 75:
			star_type = Functions.StarType.RED_GIANT
		elif randomize_value >= 75 and randomize_value < 85:
			star_type = Functions.StarType.WHITE_DWARF
		elif randomize_value >= 85 and randomize_value < 95:
			star_type = Functions.StarType.BROWN_DWARF
		elif randomize_value >= 95 and randomize_value < 98:
			star_type = Functions.StarType.PULSAR
		else:
			star_type = Functions.StarType.BLACK_HOLE
		
		var star_class_instance = Star.new(star_pos.x, star_pos.y, "Random Name", star_type)		# Instance the star class
		
		var star_scene_instance = star_scene.instance()		# Instance the star scene
		star_scene_instance.initialize_star(star_class_instance)
		
		var star_child = add_child(star_scene_instance)
		
		counter += float(5000) / float(2000)
		star_counter += 1
		increase_angle += 33
