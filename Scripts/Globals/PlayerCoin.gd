extends Node


signal updateCoinCount(oldCount, newCount)


var coins := 5


func getCoins():
	return coins


func addCoins(addCoins):
	var newCoins = coins + addCoins
	emit_signal("updateCoinCount", coins, newCoins)
	coins = newCoins


func eatCoins(removeCoins):
	var newCoins = coins - removeCoins
	emit_signal("updateCoinCount", coins, newCoins)
	coins = newCoins


func _ready():
	print("starting playercoins with %d coins" %[coins])
