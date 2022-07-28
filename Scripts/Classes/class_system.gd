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
		
		var temp_planet = Planet.new(star.system_name + " " + str(i + 1), temp_type, 30, 17, false)
		var temp_angle = rng.randi_range(0, 360);
		var temp_radius = rng.randi_range(85, 500);
		var new_orbit = Orbit.new(temp_planet, temp_angle, temp_radius)
		generate_planet_moons(rng, new_orbit)
		orbits.push_back(new_orbit)
		
	return orbits
	
func generate_planet_moons(rng, orbit):
	
	var letter_dict = {
		"0": "A",
		"1": "B",
		"2": "C"
	}
	
	var rand_num = rng.randi_range(0, 100)
	
	if rand_num < 50:
		var num_moons = rng.randi_range(1, 3)
		
		for moons in num_moons:
			var new_moon = Planet.new(orbit.celestial_body.planet_name + letter_dict[str(moons)], 1, rng.randi_range(0, 360), rng.randi_range(20, 50), true)
			var new_orbit = Orbit.new(new_moon, rng.randi_range(0, 360), rng.randi_range(20, 50))
			orbit.celestial_body.orbits.push_back(new_orbit)


