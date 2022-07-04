extends Node

class_name Planet

var planet_name						# Name of planet
var resources = Array()				# Array of all the resources on the planet
var planet_type						# The type of planet as an enum
var orbits = Array()					# The celestial body or bodies that are orbiting this planet
var position

func _init(planet_name, planet_type, angle, radius):
	self.planet_name = planet_name
	
	generate_resources()
	
	self.planet_type = planet_type
	#self.angle = angle
	#self.radius = radius
	
func generate_resources():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
