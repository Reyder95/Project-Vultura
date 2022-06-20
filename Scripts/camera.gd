extends Camera2D

var camera_drag = false;			# Boolean for if we want to drag the camera
var cursor_position					# Vector2 coordinate of the current mouse position
var zoom_max = Vector2(4.0, 4.0)	# Vector2 coordinate of maximum zoom distance away from the game

# Boundaries for the camera to not pass
var left
var right
var top
var bottom

onready var zoom_to = zoom		# The Vector2 coordinate value to zoom to. This value is what it will lerp to when using the scroll wheel

# Handle camera movement operations each frame.
func _process(delta):
	
	# Set the bounds that the camera cannot go passed based on zoom
	left = limit_left + (offset.x * zoom.x) + (get_viewport().size.x * zoom.x / 2)
	right = limit_right + (offset.x * zoom.x) - (get_viewport().size.x * zoom.x / 2)
	top = limit_top + (offset.y * zoom.y) + (get_viewport().size.y * zoom.y / 2)
	bottom = limit_bottom + (offset.y * zoom.y) - (get_viewport().size.y * zoom.y / 2) 
	
	# If we are dragging the camera, set the new position based on the current mouse cursor position
	if camera_drag:
		if (position != get_viewport().get_mouse_position()):
			var newXPosition = position.x + (cursor_position.x - get_viewport().get_mouse_position().x) * zoom.x
			var newYPosition = position.y + (cursor_position.y - get_viewport().get_mouse_position().y) * zoom.y 
			position.x = clamp(newXPosition, left, right)
			position.y = clamp(newYPosition, top, bottom)
			
			cursor_position = get_viewport().get_mouse_position()
			
	zoom = lerp(zoom, zoom_to, 0.1)		# Slowly zoom the camera towards the current "zoom_to" target
	
# Sets a Vector2 coordinate value for the maximum zoom.
func set_zoom_max(zoom):
	zoom_max = zoom

# Set the camera limits on each different side. These are the limits that the camera cannot go beyond.
func set_camera_bounds(m_top, m_bottom, m_left, m_right):
	set_limit(MARGIN_TOP, m_top)
	set_limit(MARGIN_BOTTOM, m_bottom)
	set_limit(MARGIN_LEFT, m_left)
	set_limit(MARGIN_RIGHT, m_right)

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
