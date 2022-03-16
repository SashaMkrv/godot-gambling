extends AnimatedSprite

onready var sounder:= $"/root/Sounder"

export (Resource) var player_coin


func _unhandled_input(event):
	if event.is_action_pressed("ui_up"):
		click()


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		click()


func click():
	if (player_coin.coins > getCoinCount()):
			frame = min(getCoinCount() + 1, 3)
			sounder.coin()


func reset():
	frame = 0


func getCoinCount():
	return frame
