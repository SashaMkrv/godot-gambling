extends AnimatedSprite

signal buttonPressed


onready var sounder:= $"/root/Sounder"


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		click()
	if event.is_action_released("ui_accept"):
		unclick()


func _on_Area2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		click()
	else:
		unclick()


func click():
	frame = 1
	emit_signal("buttonPressed")
	sounder.press()


func unclick():
	frame = 0
