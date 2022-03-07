extends Node

signal time_changed

var gameYear := 1
var gameMonth := 1
var gameDay := 1
var gameHour := 0
var gameMinute := 0


func getTimeString():
	return "%02d:%02d" % [gameHour, gameMinute]


func tick():
	gameMinute += 1
	rolloverTime()
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
