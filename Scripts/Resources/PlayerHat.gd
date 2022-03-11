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


func add_hat(newHat: int):
	if playerHasHats.has(newHat):
		return
	if newHat < 0:
		print("tried to add negahat: " + String(newHat))
	playerHasHats.append(newHat)


# should add a method for getting the next and previous hats in the players inventory
# and this can be done with shops too.
# just need to make a unique resource, export the hat list for those,
# and then attach it to the buttons and hat image for a store's ui
# cool.
# only, this can't be a player hat class then
# just... a hat stock class
# hat holder
# the hat keeper
# to go with hat consumers
