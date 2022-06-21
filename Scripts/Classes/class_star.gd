extends Node

class_name Star

var coordinates		# The coordinate location of the star on the galaxy map
var system_name		# The name of the system, also the star name
var star_type		# The type of the star as an enum
var scale			# Vector2 size multiplier of the star


func _init(x, y, name, type):
	coordinates = Vector2(x, y)
	system_name = name
	star_type = type
	
	if star_type == Functions.StarType.MAIN_SEQUENCE:
		scale = Vector2(1.0, 1.0)
	elif star_type == Functions.StarType.SUPER_GIANT:
		scale = Vector2(1.4, 1.4)
	elif star_type == Functions.StarType.RED_GIANT:
		scale = Vector2(1.2, 1.2)
	elif star_type == Functions.StarType.WHITE_DWARF:
		scale = Vector2(0.5, 0.5)
	elif star_type == Functions.StarType.BROWN_DWARF:
		scale = Vector2(0.8, 0.8)
	elif star_type == Functions.StarType.PULSAR:
		scale = Vector2(0.3, 0.3)
	elif star_type == Functions.StarType.BLACK_HOLE:
		scale = Vector2(1.0, 1.0)
	
