extends Node2D

signal slots_stopped(tiles)
signal slots_started()

var winningTiles := []

func _ready():
	pass


func interact(coinCount: int):
	var started = $SlotSpinner.toggleSpin(coinCount)
	if not winningTiles.empty():
		for winner in winningTiles:
			winner.unblink()
	winningTiles.clear()
	if started:
		emit_signal("slots_started")

func wheelsAllStopped():
	print("All stopped.")
	if $SlotSpinner.has_method("getTiles"):
		winningTiles = $SlotSpinner.getTiles()
		emit_signal("slots_stopped", winningTiles)
		for tile in winningTiles:
			print(tile.tileindex)
		for winner in winningTiles:
			winner.blink()


func _on_Clicker_area_entered(area):
	if area.is_in_group("click"):
		$"/root/Sounder".click()
