extends Node

class_name Star

var coordinates				# The coordinate location of the star on the galaxy map
var system_name				# The name of the system, also the star name
var star_type				# The type of the star as an enum
var scale					# Vector2 size multiplier of the star
var orbits = Array()			# The celestial bodies that orbit this star


func _init(x, y, name, type):
	coordinates = Vector2(x, y)
	system_name = name
	star_type = type
	scale = Vector2(Functions.star_objects[star_type].scale, Functions.star_objects[star_type].scale)
	
		
func initialize_orbits(orbits):
	self.orbits = orbits
	
