extends Node

class_name System

var star						# The star of the system (may make an array to support additional star systems)
#var planets = Array()			# The planets that are within the system
var asteroid_belts = Array()	# The asteroid belts in the system. Usually will be 1, rarely will be 2 or more
var starbase					# If the system has a starbase, this will be filled.
var is_surveyed					# If the system is surveyed, this will be true. Surveyed systems are visible fully from the galaxy view.
var background					# The background of the system. Randomly generated, every system has a unique background view.

# Generates the system. Home indicates whether it's the home star. The home star is the player's start, so it needs some additional generation
func generate_system(class_star, home):
	star = class_star
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	var num_planets = rng.randi_range(0, 5)
	
	var orbits = generate_planets(num_planets, rng)
	
	star.initialize_orbits(orbits)
	
func generate_planets(num_planets, rng):
	var orbits = Array()
	
	for i in num_planets:
		
		var temp_type
		var rng_type = rng.randf_range(0, 100)
		
		for planet in Functions.planet_rng_table.keys():
			if rng_type >= Functions.planet_rng_table[planet].minimum && rng_type <= Functions.planet_rng_table[planet].maximum:
				temp_type = planet
				break
				
		
		var temp_planet = Planet.new(star.system_name + " " + str(i), temp_type, 30, 17)
		var temp_angle = rng.randi_range(0, 360);
		var temp_radius = rng.randi_range(50, 500);
		orbits.push_back(Orbit.new(temp_planet, temp_angle, temp_radius))
		
	return orbits


