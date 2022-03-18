extends StaticBody2D


onready var sprite := $AnimatedSprite
var playerInZone := false
export (PackedScene) var coolNewSceneToGoTo


func _on_Area2D_area_entered(area: Area2D):
	if area.is_in_group("player"):
		print("player hanging out with a door")
		$AnimatedSprite.frame = 1
		playerInZone = true


func _on_Area2D_area_exited(area: Area2D):
	if area.is_in_group("player"):
		print("player has abandonded the door")
		$AnimatedSprite.frame = 0
		playerInZone = false


func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("ui_accept") && playerInZone:
		print("player tried to escape")
		if coolNewSceneToGoTo != null:
			get_tree().change_scene_to(coolNewSceneToGoTo)
		else:
			print("but player the door leads nowhere. very cool.")
