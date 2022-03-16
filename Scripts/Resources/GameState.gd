extends Resource
class_name GameState


signal stateChanged(state)
signal gameClosed()
signal gameOpened(resource)
# So, this basically sets the Base App. You set current state to this, and the state stack gets nerfed
# if you purge with a new state later, then that new thing becomes the new Base App
export (String) var startingMode := "Move"
var currentState : String setget tryChangeStateTo
var currentStateStack := []


func _init():
	print("initing game state with mode: ", startingMode)
	tryChangeStateTo(startingMode)


func toggleState(state):
	print("toggling to state: ", state)
	if currentState == state:
		print("current state is toggled state, trying to exit")
		tryMoveDownState()
	else:
		print("current state is not toggled state, trying to add")
		tryChangeStateTo(state)


func tryChangeStateTo(newVal):
	print("trying to change state to: ", newVal)
	currentStateChanged(newVal)


func tryMoveDownState():
	if currentStateStack.size() <= 1:
		print("tried moving down a state stack with less than two items")
	else:
		tryChangeStateTo(currentStateStack[currentStateStack.size() - 2])


func tryMoveDownStateIfCurrentStateIs(tryState):
	if currentState == tryState:
		print("trying to move down from state ", tryState)
		tryMoveDownState()
	else:
		print(tryState, " was not in stack, not moving down")


func purgeStackWith(newState):
	if currentStateStack.has("Game"):
		emit_signal("gameClosed")
	currentStateStack = []
	tryChangeStateTo(newState)


func currentStateChanged(newVal: String):
	if currentState != newVal:
		var gameIncluded = currentStateStack.has("Game")
		if newVal in currentStateStack:
			print("scraping game state stack until we get to ", newVal)
			var index = currentStateStack.find_last(newVal)
			currentStateStack.resize(index + 1)
		else:
			print("adding to state stack: ", newVal)
			currentStateStack.append(newVal)
			
		currentState = newVal
		emit_signal("stateChanged", currentState)
		print("state stack is now ", PoolStringArray(currentStateStack).join(", "))
		if gameIncluded and not currentStateStack.has("Game"):
			emit_signal("gameClosed")
	else:
		print("state was already ", newVal)


func changeStateTo(state: String):
	print("Maybe do not use this method. please. thank you. will try to change state to ", state, " anyways.")
	tryChangeStateTo(state)


func changeStateToGameWithGame(gameScene: Resource):
	changeStateToGame()
	if currentState == "Game":
		emit_signal("gameOpened", gameScene)


func changeStateToGame():
	tryChangeStateTo("Game")


func changeStateToMove():
	tryChangeStateTo("Move")


func changeStateToInventory():
	tryChangeStateTo("Inventory")


func changeStateToShop():
	tryChangeStateTo("Shop")
