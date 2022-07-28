extends Node

var hovered_style = StyleBoxFlat.new()
var non_hovered_style = StyleBoxFlat.new()

func _ready():
	hovered_style.set_bg_color(Color8(70, 83, 94))
	non_hovered_style.set_bg_color(Color8(121, 144, 163))
	
	get_node(".").add_stylebox_override("panel", non_hovered_style)

func _on_TableRow_mouse_entered():
	get_node(".").add_stylebox_override("panel", hovered_style)


func _on_TableRow_mouse_exited():
	get_node(".").add_stylebox_override("panel", non_hovered_style)
