extends Node

onready var table_row = preload("res://Scenes/Prefabs/TableRow.tscn")


func add_resource(resource):
	var table_row_instance = table_row.instance()
	table_row_instance._set_resource_class(resource)
	table_row_instance.get_node("HBoxContainer/Resource").text = Functions.resource_objects[int(resource.type)].name
	table_row_instance.get_node("HBoxContainer/ResourceQty").text = str(resource.quantity)
	table_row_instance.get_node("HBoxContainer/ResourceIcon").set_texture(load("res://Sprites and Images/Resources/" + Functions.resource_objects[int(resource.type)].filename))
	
	table_row_instance.connect("row_pressed", self, "_on_row_pressed")
	
	get_node("VBoxContainer").add_child(table_row_instance)
	
func clear_resources():
	for row in get_node("VBoxContainer").get_children():
		get_node("VBoxContainer").remove_child(row)
		row.queue_free()
		
func _on_row_pressed(resource):
	var resource_info = get_parent().get_node("ResourceInfo")
	
	if resource_info.get_node("Title").text == Functions.resource_objects[int(resource.type)].name:
		resource_info.visible = !resource_info.visible
	else:
		resource_info.visible = true
	
	resource_info.get_node("Title").text = Functions.resource_objects[int(resource.type)].name
	resource_info.get_node("Description").text = Functions.resource_objects[int(resource.type)].description
	resource_info.get_node("Icon").set_texture(load("res://Sprites and Images/Resources/" + Functions.resource_objects[int(resource.type)].filename))
