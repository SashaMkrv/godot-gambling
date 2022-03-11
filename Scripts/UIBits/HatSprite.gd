extends AnimatedSprite
export (Resource) var hatFrame


func _ready():
	hatFrame.connect("hat_changed", self, "hat_changed")
	hat_changed(hatFrame.hat)


func hat_changed(newHatFrame):
	frame = newHatFrame
