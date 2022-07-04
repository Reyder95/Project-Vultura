extends Node

class_name System

var star						# The star of the system (may make an array to support additional star systems)
var planets = Array()			# The planets that are within the system
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
	
	for planet in num_planets:
		Planet.new("Test Planet", "type", 30, 17)
	

