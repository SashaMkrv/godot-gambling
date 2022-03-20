extends Control

export (Resource) var gameState


func _ready():
#	gameState.connect("stateChanged", self, "gameStateChanged")
	pass


func _unhandled_input(event):
	# this either is the place to handle all ui
	# or it isn't the place do this at all
	if event.is_action_pressed("ui_open_close_inventory"):
		gameState.toggleState("Inventory")
	
	if event.is_action_pressed("ui_cancel"):
		if gameState.currentState == "Game":
			gameState.tryMoveDownStateIfCurrentStateIs("Game")
	
	if gameState.currentState != "Move":
		print("trying to kill off the player movement while in other states")
		# if we're in any mode other than the one where we should touch map things
		# do not let this input get out into the map
		get_tree().set_input_as_handled()
	

func _on_InventoryOpenButton_pressed():
	gameState.changeStateToInventory()


func _on_InventoryCloseButton_pressed():
	gameState.tryMoveDownStateIfCurrentStateIs("Inventory")
