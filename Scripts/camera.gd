extends Camera2D

var camera_drag = false;	# Boolean for if we want to drag the camera
var cursor_position			# Vector2 coordinate of the current mouse position
var zoom_max = Vector2(4.0, 4.0)	# Vector2 coordinate of maximum zoom distance away from the game

# Boundaries for the camera to not pass
var left
var right
var top
var bottom

onready var zoom_to = zoom	# The Vector2 coordinate value to zoom to. This value is what it will lerp to when using the scroll wheel

# Handle camera movement operations each frame.
func _process(delta):
	if camera_drag:
		if (position != get_viewport().get_mouse_position()):
			var newXPosition = position.x + (cursor_position.x - get_viewport().get_mouse_position().x) * zoom.x
			var newYPosition = position.y + (cursor_position.y - get_viewport().get_mouse_position().y) * zoom.y 
			position.x = newXPosition
			position.y = newYPosition
			
			cursor_position = get_viewport().get_mouse_position()
			
	zoom = lerp(zoom, zoom_to, 0.1)

# When we click on the screen, we'd like to be able to drag the camera around
func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			camera_drag = true
			cursor_position = get_viewport().get_mouse_position()
		else:
			camera_drag = false
			
		if event.button_index == 4 and zoom_to > Vector2(0.2, 0.2):
			zoom_to -= Vector2(0.1, 0.1)
		elif event.button_index == 5 and zoom_to < zoom_max:
			zoom_to += Vector2(0.1, 0.1)
