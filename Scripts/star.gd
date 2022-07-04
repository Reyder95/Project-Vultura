extends Node2D

var star_class

signal star_clicked(star)

func initialize_star(star):
	star_class = star
	
	var sprite = get_node("Sprite")
	var title = get_node("Title")
	
	position = star.coordinates
	title.text = star.system_name
	
	sprite.set_texture(load("res://Sprites and Images/Astral/Stars/" + Functions.startype_map_files[star.star_type] + ".png"))
	sprite.scale *= star.scale


func _on_Area2D_mouse_entered():
	var title = get_node("Title")
	
	title.visible = true


func _on_Area2D_mouse_exited():
	var title = get_node("Title")
	
	title.visible = false


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == 1 and event.is_pressed():
		print("TEST!")
		emit_signal("star_clicked", star_class)
