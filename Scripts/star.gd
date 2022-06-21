extends Node2D

var star_class

func initialize_star(star):
	star_class = star
	
	var sprite = get_node("Sprite")
	
	position = star.coordinates
	
	sprite.set_texture(load("res://Sprites and Images/Astral/Stars/" + Functions.startype_map_files[star.star_type] + ".png"))
	sprite.scale *= star.scale
