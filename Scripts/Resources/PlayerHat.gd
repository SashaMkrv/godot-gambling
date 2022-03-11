extends Resource
class_name PlayerHat

var hat := 0

var playerHasHats := [0, 1, 2, 3]

signal hat_changed(hat)

func change_hat(newHat: int):
	if playerHasHats.has(newHat):
		hat = newHat
		emit_signal("hat_changed", newHat)
		return
	print("tried to change into hat player does not own: " + String(newHat))
