extends Control

export (Resource) var gameState

func _ready():
	gameState.connect("stateChanged", self, "gameStateChanged")


func gameStateChanged(newState):
	match newState:
		"Game":
			openSlots()
		"Move":
			openMove()
		"Inventory":
			openInventory()
		_:
			pass


func openSlots():
	get_tree().paused = false


func openInventory():
	get_tree().paused = true


func openMove():
	get_tree().paused = false
