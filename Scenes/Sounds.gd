extends Node


onready var sounder = $"/root/Sounder"


func _ready():
	sounder.connect("clicker", self, "playClick")
	sounder.connect("coin", self, "playCoin")
	sounder.connect("press", self, "playInteract")


func playClick():
	$ClickPlayer.play()


func playCoin():
	$CoinPlayer.play()


func playInteract():
	$PressPlayer.play()
