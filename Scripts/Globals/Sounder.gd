extends Node


signal clicker
signal coin
signal press


func click():
	emit_signal("clicker")


func coin():
	emit_signal("coin")


func press():
	emit_signal("press")
