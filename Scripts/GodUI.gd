extends Control

onready var playerCoin := $"/root/PlayerCoin"
onready var sounder := $"/root/Sounder"


func _ready():
	changeCoinCountTo(playerCoin.getCoins())
	playerCoin.connect("updateCoinCount", self, "changeCoinCount")


func _on_MoneyToucher_ateCoins(coinCount):
	playerCoin.eatCoins(coinCount)


func _on_MoneyToucher_madeCoin(coinCount):
	playerCoin.addCoins(coinCount)


func changeCoinCount(oldVal, newVal):
	var diff = abs(oldVal - newVal)
	var time = 0.1
	if diff > 500:
		1.5
	elif diff > 50:
		0.5
	elif diff > 5:
		0.2
	$CoinCountTween.interpolate_method(self, "changeCoinCountTo", oldVal, newVal, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$CoinCountTween.start()


func changeCoinCountTo(coinCount):
	coinCount = ceil(coinCount)
	$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/MarginContainer/HSplitContainer/CoinCount.text = String(coinCount)
