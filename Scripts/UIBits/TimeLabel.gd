extends Label


onready var time := $"/root/Time"


func _ready():
	time.connect("time_changed", self, "updateText")
	updateText()


func updateText():
	text = "%s %s %s" % [time.getTimeString(), time.getDayString(), time.getSeasonString()]
