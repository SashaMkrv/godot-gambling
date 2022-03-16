extends Container


export (Resource) var gameState
export (bool) var showDuringMove := true
export (bool) var showDuringGame := true
export (bool) var showDuringInventory := true
export (bool) var showDuringShop := true
export (bool) var defaultShow := false


func _ready():
	stateChangedListener(gameState.currentState)
	gameState.connect("stateChanged", self, "stateChangedListener")


func stateChangedListener(state: String):
	match(state):
		"Move":
			visible = showDuringMove
		"Game":
			visible = showDuringGame
		"Inventory":
			visible = showDuringInventory
		"Shop":
			visible = showDuringShop
		_:
			visible = defaultShow
	print("state changed to ", state, " for item ", name, ". it is now visible: ", visible)
