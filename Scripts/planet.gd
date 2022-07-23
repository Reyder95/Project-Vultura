extends Node

var planet_class

func initialize_planet(planet_class):
	self.planet_class = planet_class

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == 1 and event.is_pressed():
		for resource in planet_class.resources:
			print(Functions.resource_objects[int(resource.type)].name + " - " + str(resource.quantity))

func _on_Area2D_mouse_entered():
	get_node("Title").visible = true
	
func _on_Area2D_mouse_exited():
	get_node("Title").visible = false
