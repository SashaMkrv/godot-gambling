extends Node


export (Resource) var hatFrame


func _on_Previous_pressed():
	moveBy(-1)


func _on_Next_pressed():
	moveBy(1)


func moveBy(num: int):
	hatFrame.change_hat(hatFrame.hat + num)
