extends AnimatedSprite

onready var playerCoin := $"/root/PlayerCoin"


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		if (playerCoin.coins > getCoinCount()):
			frame = min(getCoinCount() + 1, 3)


func reset():
	frame = 0


func getCoinCount():
	return frame
