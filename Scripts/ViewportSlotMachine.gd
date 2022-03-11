extends Node2D


export (Resource) var player_coin


enum PAYOUT_CLASSES {big2, big3, medium2, medium3, little2, little3, none}
const classToCoin = {
	PAYOUT_CLASSES.big3: 100,
	PAYOUT_CLASSES.big2: 50,
	PAYOUT_CLASSES.medium3: 20,
	PAYOUT_CLASSES.medium2: 10,
	PAYOUT_CLASSES.little3: 5,
	PAYOUT_CLASSES.little2: 1,
	PAYOUT_CLASSES.none: 0
}


func interact():
	$ViewportSlotTest.interact($ControlWrapper/CoinAdding.getCoinCount())


func buttonPressed():
	interact()


func slots_started():
	spinStarted()


func slots_stopped(tiles, coinsUsed):
	# we want consecutive tiles of some class
	# and since we're just doing 3 wheel slots here,
	# we grab the payout size of whatever the matching tiles are
	# and multiply by the coins used.
	var payoutClass = getPayoutClass(tiles)
	
	var baseCoins = classToCoin[payoutClass]
	var coinsGot = baseCoins * coinsUsed
	
	player_coin.addCoins(coinsGot)


func getPayoutClass(tiles):
	var longestRun = 0
	var longestClass = -1
	var longestRunTile
	
	var currentClass = -1
	var runLength = 0
	
	for tile in tiles:
		var newClass = tile.getClass()
		
		if newClass == currentClass:
			runLength += 1
		else:
			runLength = 1
			currentClass = newClass
		
		if runLength >= longestRun:
			longestClass = newClass
			longestRun = runLength
			longestRunTile = tile
		
		currentClass = newClass
	
	return getPayoutForClassAndLength(longestRunTile, longestClass, longestRun)


func getPayoutForClassAndLength(tile, tileClass, runLength):
	match [tile.getPayoutSize(), runLength]:
		[tile.PAYOUT_SIZES.big, 2]:
			return PAYOUT_CLASSES.big2
		[tile.PAYOUT_SIZES.big, 3]:
			return PAYOUT_CLASSES.big3
		[tile.PAYOUT_SIZES.medium, 2]:
			return PAYOUT_CLASSES.medium2
		[tile.PAYOUT_SIZES.medium, 3]:
			return PAYOUT_CLASSES.medium3
		[tile.PAYOUT_SIZES.little, 2]:
			return PAYOUT_CLASSES.little2
		[tile.PAYOUT_SIZES.little, 3]:
			return PAYOUT_CLASSES.little3
	return PAYOUT_CLASSES.none

func spinStarted():
	player_coin.eatCoins($ControlWrapper/CoinAdding.getCoinCount())
	$ControlWrapper/CoinAdding.reset()
