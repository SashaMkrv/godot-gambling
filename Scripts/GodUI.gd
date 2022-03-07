extends Control

onready var playerCoin := $"/root/PlayerCoin"
onready var time := $"/root/Time"


func _on_MoneyToucher_ateCoins(coinCount):
	playerCoin.eatCoins(coinCount)


func _on_MoneyToucher_madeCoin(coinCount):
	playerCoin.addCoins(coinCount)


func _on_Timer_timeout():
	time.tick()
