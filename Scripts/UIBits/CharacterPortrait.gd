extends AnimatedSprite


onready var time := $"/root/Time"


func _ready():
	time.connect("isEvening", self, "isEvening")
	time.connect("isNight", self, "isNight")
	time.connect("isMorning", self, "isMorning")
	time.connect("isAfternoon", self, "isAfternoon")
	var timeSlot = time.currentTimeSlot
	match timeSlot:
		time.TIME_SLOT.night:
			frame = 2
		time.TIME_SLOT.evening:
			frame = 1
		_:
			frame = 0


func isEvening():
	$AnimationPlayer.play("BlinkToEvening")


func isNight():
	$AnimationPlayer.play("BlinkToNight")


func isMorning():
	$AnimationPlayer.play("Blink")


func isAfternoon():
	$AnimationPlayer.play("Blink")
