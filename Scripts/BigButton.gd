extends AnimatedSprite

signal buttonPressed


func _on_Area2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		frame = 1
		emit_signal("buttonPressed")
	else:
		frame = 0
