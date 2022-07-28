extends Node

var hovered_style = StyleBoxFlat.new()
var non_hovered_style = StyleBoxFlat.new()

var resource_class

signal row_pressed(resource)

func _ready():
	hovered_style.set_bg_color(Color8(70, 83, 94))
	non_hovered_style.set_bg_color(Color8(121, 144, 163))
	
	get_node(".").add_stylebox_override("panel", non_hovered_style)
	
func _set_resource_class(resource):
	resource_class = resource

func _on_TableRow_mouse_entered():
	get_node(".").add_stylebox_override("panel", hovered_style)


func _on_TableRow_mouse_exited():
	get_node(".").add_stylebox_override("panel", non_hovered_style)

func _on_TableRow_gui_input(event):
	if event is InputEventMouseButton and event.button_index == 1 and event.is_pressed():
		emit_signal("row_pressed", resource_class)
