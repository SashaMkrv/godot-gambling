extends Control


export (Resource) var gameState
export (Resource) var playerCoin


var escapable := true


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		if escapable:
			return
		else:
			# TODO: do this somewhere else. like anywhere things should actually get blocked.
			get_tree().set_input_as_handled()
		


func _ready():
	gameState.connect("stateChanged", self, "stateChanged")
	gameState.connect("gameClosed", self, "gameClosed")
	gameState.connect("gameOpened", self, "gameOpened")
	print("connecting stuff, killing the example game scene")
	stateChanged(gameState.currentState)
	gameClosed()


func gameOpened(resource: PackedScene):
	print("opening a new game")
	var game = resource.instance()
	add_child(game)
	game.player_coin = playerCoin
	game.connect("dontEscape", self, "onGameDontEscape")
	game.connect("canEscape", self, "onGameCanEscape")


func gameClosed():
	print("killing the closed game")
	var children = get_children()
	for child in children:
		child.queue_free()


func stateChanged(newState):
	pass



func onGameCanEscape():
	print("game is cool to die")
	escapable = true


func onGameDontEscape():
	print("we do not want to kill the game")
	escapable = false
