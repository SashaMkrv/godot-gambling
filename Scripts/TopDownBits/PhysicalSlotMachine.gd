extends Node2D


export (Resource) var gameState
export (Resource) var gameScene


var playerInVicinity := false


func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("ui_accept") and playerInVicinity:
		gameState.changeStateToGameWithGame(gameScene) # ok this is going to be weird with adding blackjack. this game state system is already borked for any interaction!!! incredible. I am sad all around.



func _on_Area2D_area_entered(area: Area2D):
	print("body entering slot area ", PoolStringArray(area.get_groups()).join(", "))
	if area.is_in_group("player"):
		modulate = Color.violet
		playerInVicinity = true


func _on_Area2D_area_exited(area: Area2D):
	if area.is_in_group("player"):
		modulate = Color.white
		playerInVicinity = false
