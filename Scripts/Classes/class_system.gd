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
	
	# Building rng planet map
	var rng_planets = Dictionary()
	
	var previous_max_percent = 0
	
	# TODO -- Move to on-game-load, such as Functions file.
	for planet_chance in Functions.planet_chance.keys():
		var current_max_percent = previous_max_percent + Functions.planet_chance[planet_chance]
		var planet_rng_object = {
			"minimum": previous_max_percent,
			"maximum": current_max_percent
		}
		
		rng_planets[planet_chance] = planet_rng_object
		previous_max_percent = current_max_percent
	
	var current_rng = 0
	
	for i in num_planets:
		
		var temp_type
		var rng_type = rng.randf_range(0, 1)
		
		for rng_planet in rng_planets.keys():
			if rng_type >= rng_planets[rng_planet].minimum && rng_type <= rng_planets[rng_planet].maximum:
				temp_type = rng_planet
				break
				
		
		var temp_planet = Planet.new(star.system_name + " " + str(i), temp_type, 30, 17)
		var temp_angle = rng.randi_range(0, 360);
		var temp_radius = rng.randi_range(50, 500);
		orbits.push_back(Orbit.new(temp_planet, temp_angle, temp_radius))
		
	return orbits


