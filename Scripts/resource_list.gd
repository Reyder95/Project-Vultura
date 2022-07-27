extends Node

func _ready():
	get_node(".").add_item("test")
	get_node(".").add_item("1000")


func _on_ResourceList_item_selected(index):
	if index % 2 == 0:
		get_node(".").select(index + 1)
	else:
		get_node(".").select(index - 1)
