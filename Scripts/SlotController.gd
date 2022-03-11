extends Node2D

signal slots_stopped(tiles)
signal slots_started()

tool

var winningTiles := []
var spinCoinCount := 0

export (int) var wheelNum := 3 setget updateWheelNum
export (int) var tileNum := 10 setget updateTileNum


func _ready():
	pass


func updateWheelNum(newVal):
	wheelNum = newVal
	$SlotSpinner.wheelnum = wheelNum


func updateTileNum(newVal):
	tileNum = newVal
	$SlotSpinner.tilenum = tileNum


func interact(coinCount: int):
	var started = $SlotSpinner.toggleSpin(coinCount)
	if not winningTiles.empty():
		for winner in winningTiles:
			winner.unblink()
	winningTiles.clear()
	if started:
		spinCoinCount = coinCount
		emit_signal("slots_started")

func wheelsAllStopped():
	print("All stopped.")
	if $SlotSpinner.has_method("getTiles"):
		winningTiles = $SlotSpinner.getTiles()
		emit_signal("slots_stopped", winningTiles, spinCoinCount)
		spinCoinCount = 0
		for tile in winningTiles:
			print(tile.tileindex)
		for winner in winningTiles:
			winner.blink()


func _on_Clicker_area_entered(area):
	if area.is_in_group("click"):
		$"/root/Sounder".click()
