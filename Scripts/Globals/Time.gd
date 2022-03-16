extends Node

signal time_changed
signal isEvening
signal isNight
signal isMorning
signal isAfternoon

var gameYear := 1
var gameMonth := 0
var gameDay := 1
var gameHour := 11
var gameMinute := 50

enum TIME_SLOT {morning, afternoon, evening, night}
var timeTransition = {
	TIME_SLOT.evening: 19,
	TIME_SLOT.afternoon: 12,
	TIME_SLOT.morning: 6,
	TIME_SLOT.night: 0
}
var timeSlots := [TIME_SLOT.evening, TIME_SLOT.afternoon, TIME_SLOT.morning, TIME_SLOT.night]

var currentTimeSlot

func _ready():
	currentTimeSlot = calcTimeSlot()


func calcTimeSlot():
	for slot in timeSlots:
		if gameHour >= timeTransition[slot]:
			return slot
	return TIME_SLOT.night


func getTimeString():
	return "%02d:%02d" % [gameHour, gameMinute]
func getSeasonString():
	match gameMonth:
		0:
			return "Sp"
		1:
			return "Su"
		2:
			return "Fa"
		3:
			return "Wn"
func getDayString():
	return "%02d" % [gameDay]


func tick():
	gameMinute += 1
	timeUpdated()


func timeUpdated():
	rolloverTime()
	checkForTimeSlot()
	emit_signal("time_changed")


func rolloverTime():
	if gameMinute < 60:
		return
	gameMinute = 0
	gameHour += 1
	if gameHour < 24:
		return
	gameHour = 0
	gameDay += 1
	if gameDay < 30:
		return
	gameDay = 0
	gameMonth += 1
	if gameMonth < 4:
		return
	gameMonth = 0
	gameYear += 1


func checkForTimeSlot():
	var newTimeSlot = calcTimeSlot()
	if currentTimeSlot != newTimeSlot:
		match newTimeSlot:
			TIME_SLOT.night:
				emit_signal("isNight")
			TIME_SLOT.evening:
				emit_signal("isEvening")
			TIME_SLOT.afternoon:
				emit_signal("isAfternoon")
			TIME_SLOT.morning:
				emit_signal("isMorning")
	currentTimeSlot = newTimeSlot


func setToTimeSlot(timeSlot: String):
	var newTime = timeTransition[timeSlot]
	if newTime == null:
		print("bad time slot name")
		return
	gameHour = newTime
	gameMinute = 0
	timeUpdated()
