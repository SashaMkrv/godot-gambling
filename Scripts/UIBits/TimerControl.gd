extends Node

onready var time := $"/root/Time"


func _on_Timer_timeout():
	time.tick()
