extends Label


onready var sounder = $"/root/Sounder"


export (Resource) var player_coin


var previousCoinCount : int


func _ready():
	player_coin.connect("updateCoinCount", self, "changeCoinCount")
	changeCoinCountTo(player_coin.getCoins())
	previousCoinCount = player_coin.getCoins()


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
