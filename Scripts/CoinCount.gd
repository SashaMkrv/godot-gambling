extends Label


onready var playerCoin = $"/root/PlayerCoin"
onready var sounder = $"/root/Sounder"


var previousCoinCount : int


func _ready():
	playerCoin.connect("updateCoinCount", self, "changeCoinCount")
	changeCoinCountTo(playerCoin.getCoins())
	previousCoinCount = playerCoin.getCoins()


func changeCoinCount(oldVal, newVal):
	var diff = abs(oldVal - newVal)
	var time = 0.1
	if diff > 500:
		time = 2
	elif diff > 50:
		time = 0.5
	elif diff > 5:
		time = 0.2
	$Tween.interpolate_method(self, "animateCoinCount", oldVal, newVal, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()


func animateCoinCount(coinCount):
	var roundedCoinCount = ceil(coinCount)
	if roundedCoinCount > previousCoinCount:
		sounder.coin()
	previousCoinCount =  roundedCoinCount
	changeCoinCountTo(ceil(coinCount))

func changeCoinCountTo(coinCount):
	text = String(coinCount)
