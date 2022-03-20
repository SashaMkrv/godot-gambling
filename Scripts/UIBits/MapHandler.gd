extends Node

export (Resource) var gameState


func _ready():
	gameState.connect("stateChanged", self, "stateChanged")
	stateChanged(gameState.currentState)
	pass


func stateChanged(newState):
	match newState:
		"Move":
			print("player map move, how nice")
			set_process_input(true)
		_:
			print("trying to stop movement, please, sob")
			set_process_input(false)
