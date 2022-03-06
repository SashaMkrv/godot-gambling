extends Node2D


signal ateCoins(coinCount)
signal madeCoin(coinCount)


func interact():
	$ViewportSlotTest.interact($ControlWrapper/CoinAdding.getCoinCount())


func buttonPressed():
	interact()


func slots_started():
	spinStarted()


func slots_stopped(tiles):
	emit_signal("madeCoin", 1)


func spinStarted():
	emit_signal("ateCoins", $ControlWrapper/CoinAdding.getCoinCount())
	$ControlWrapper/CoinAdding.reset()
