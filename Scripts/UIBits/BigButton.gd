extends AnimatedSprite

signal buttonPressed


onready var sounder:= $"/root/Sounder"


func _on_Area2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		frame = 1
		emit_signal("buttonPressed")
		sounder.press()
	else:
		frame = 0
