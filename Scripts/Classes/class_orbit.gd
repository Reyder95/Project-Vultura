extends Node

class_name Orbit

var celestial_body		# The celestial body that is orbiting another object
var angle				# The angle the celestial body is to be placed from the center point
var radius				# The distance away the celestial body is to be placed from the center point

func _init(celestial_body, angle, radius):
	self.celestial_body = celestial_body
	self.angle = angle
	self.radius = radius
	
func coordinate_helper(object_pos):
	
