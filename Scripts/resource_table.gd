extends Node

onready var table_row = preload("res://Scenes/Prefabs/TableRow.tscn")


func add_resource(resource):
	var table_row_instance = table_row.instance()
	table_row_instance.get_node("HBoxContainer/Resource").text = Functions.resource_objects[int(resource.type)].name
	table_row_instance.get_node("HBoxContainer/ResourceQty").text = str(resource.quantity)
	table_row_instance.get_node("HBoxContainer/ResourceIcon").set_texture(load("res://Sprites and Images/Resources/" + Functions.resource_objects[int(resource.type)].filename))
	
	get_node("VBoxContainer").add_child(table_row_instance)
	
func clear_resources():
	for row in get_node("VBoxContainer").get_children():
		get_node("VBoxContainer").remove_child(row)
		row.queue_free()
