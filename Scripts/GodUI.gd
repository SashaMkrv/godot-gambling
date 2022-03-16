extends Control

export (Resource) var gameState

onready var time := $"/root/Time"

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


func _on_Timer_timeout():
	time.tick()


func openSlots():
	get_tree().paused = false
	$HeresTheMap.visible = false


func openInventory():
	get_tree().paused = true
	$HeresTheMap.visible = false


func openMove():
	get_tree().paused = false
	$HeresTheMap.visible = true


func _unhandled_input(event):
	if event.is_action_pressed("ui_open_close_inventory"):
		gameState.toggleState("Inventory")
	if event.is_action_pressed("ui_cancel"):
		if gameState.currentState == "Game":
			gameState.tryMoveDownStateIfCurrentStateIs("Game")
	

func _on_InventoryOpenButton_pressed():
	gameState.changeStateToInventory()


func _on_InventoryCloseButton_pressed():
	gameState.tryMoveDownStateIfCurrentStateIs("Inventory")
