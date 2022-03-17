extends Control


export (Resource) var gameState
export (Resource) var playerCoin


var EAT_INPUT := false
var escapable := true


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel") and escapable:
		return
	if EAT_INPUT:
		get_tree().set_input_as_handled()
	# hahah this is... very bad and gettin quickly worse oh my god.
	# I'm going to need to just refactor a comically large number of things


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
	match(newState):
		"Game":
			EAT_INPUT = true
		_:
			EAT_INPUT = false



func onGameCanEscape():
	print("game is cool to die")
	escapable = true


func onGameDontEscape():
	print("we do not want to kill the game")
	escapable = false
