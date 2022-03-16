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
	$Timer.paused = false



func openInventory():
	get_tree().paused = true
	$HeresTheMap.visible = false
	$Timer.paused = true


func openMove():
	get_tree().paused = false
	$HeresTheMap.visible = true
	$Timer.paused = false


func _on_InventoryOpenButton_pressed():
	gameState.changeStateToInventory()


func _on_InventoryCloseButton_pressed():
	gameState.tryMoveDownStateIfCurrentStateIs("Inventory")
