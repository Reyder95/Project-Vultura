extends Node2D

onready var camera = get_node("Camera");

var galaxy_radius = 1000
var max_stars = 1000
var galaxy_center_spacing = 400
var galaxy_center = Vector2(0, 0)
var rng

var star_scene = preload("res://Scenes/Prefabs/Star.tscn")

signal system_entered(star)

func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	generate_starmap()
	
	camera.set_camera_bounds(-10000, 10000, -10000, 10000)		# Set the camera bounds for this scene

func generate_starmap():
	var counter = galaxy_center_spacing + 1
	var star_counter = 0
	var rand_angle = 0
	var previous_angles = Array()
	var reloop = true
	
	while counter < galaxy_center_spacing + galaxy_radius || star_counter < max_stars:
		
		if previous_angles.size() == 0:
			reloop = false
		else:
			reloop = true
		
		rand_angle = rng.randi_range(0, 361)
		
		var we_in = true
		
		while true:
			for angle in previous_angles:
				if rand_angle <= angle + 10 and rand_angle >= angle - 10:
					rand_angle = rng.randi_range(0, 361)
					we_in = false
					
			if we_in:
				break
				
			we_in = true
			
		if previous_angles.size() >= 15:
			previous_angles.pop_back()
			
		previous_angles.push_front(rand_angle)
		
		print(previous_angles)
		
		# The Vector2 coordinates for this star's position on the galaxy map
		var star_pos = Vector2(galaxy_center.x + (0 * cos(deg2rad(rand_angle)) + (counter * 2 - 150) * sin(deg2rad(rand_angle))), galaxy_center.y + (-1 * ((0 * sin(deg2rad(rand_angle))) + (counter * 2 - 150) * cos(deg2rad(rand_angle)))))
		
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
			
		var random_name = Functions.system_names[rng.randi_range(0, Functions.system_names.size() - 1)]
		#var random_name = "Radius: " + str(counter) + " Angle: " + str(rand_angle)
		
		var star_class_instance = Star.new(star_pos.x, star_pos.y, random_name, star_type)		# Instance the star class
		
		var system_class_instance = System.new()
		system_class_instance.generate_system(star_class_instance, false)
		
		var star_scene_instance = star_scene.instance()		# Instance the star scene
		star_scene_instance.connect("star_clicked", self, "_on_star_clicked")
		star_scene_instance.initialize_star(star_class_instance, system_class_instance)
		
		var star_child = add_child(star_scene_instance)
		
		counter += float(5000) / float(2000)
		star_counter += 1
		
func _on_star_clicked(star, system):
	emit_signal("system_entered", star, system)
