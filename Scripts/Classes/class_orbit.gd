extends Node

class_name Orbit

var planet_scene = preload("res://Scenes/Prefabs/Planet.tscn")

var celestial_body		# The celestial body that is orbiting another object
var angle				# The angle the celestial body is to be placed from the center point
var radius				# The distance away the celestial body is to be placed from the center point

func _init(celestial_body, angle, radius):
	self.celestial_body = celestial_body
	self.angle = angle
	self.radius = radius
	
func determine_orbits(origin):
	var orbit_positions = Array()
	var orbit_dict = {
		"position" : Vector2(origin.x + (radius * cos(deg2rad(angle))), origin.y + (radius * sin(deg2rad(angle)))),
		"celestial_body" : celestial_body,
		"orbit" : self,
		"center": origin
	}
	
	orbit_positions.append(orbit_dict);
	
	if (celestial_body.orbits.size() > 0):
		for orbit in celestial_body.orbits:
			var temp_orbit_positions = orbit.determine_orbits(orbit_dict.position)
			orbit_positions.append_array(temp_orbit_positions)
	
	return orbit_positions
	

