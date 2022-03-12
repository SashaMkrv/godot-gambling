extends Node2D

tool

signal wheels_stopped

export(int, 1, 100) var tilesize setget sizeUpdate
export(int, 1, 100) var tilenum setget tileNumUpdate
export(int, 1, 10) var wheelnum setget wheelNumUpdate
export(int, 1, 10) var tilepadding setget tilePaddingUpdate
export(int, 1, 10) var wheelpadding setget wheelPaddingUpdate
export(int, 1, 1000) var winline setget winlineUpdate

var wheels := []
var wheelScene := preload("res://Scenes/Wheel.tscn")

enum States {START, STOP, STILL, MOVING}
var state = States.STILL

var wheelWaitCount = 0

var ready

func sizeUpdate(newVal: int):
	tilesize = newVal
	redraw()


func tileNumUpdate(newVal: int):
	tilenum = newVal
	redraw()


func wheelNumUpdate(newVal: int):
	wheelnum = newVal
	redraw()


func tilePaddingUpdate(newVal: int):
	tilepadding = newVal
	redraw()


func wheelPaddingUpdate(newVal: int):
	wheelpadding = newVal
	redraw()


func winlineUpdate(newVal: int):
	winline = newVal
	update()


func redraw():
	if ready:
		killWheels()
		createWheels()


func _draw():
	if Engine.editor_hint:
		draw_line(Vector2(-20, winline), Vector2(100, winline), Color.crimson)

	

func killWheels():
	for wheel in getWheels():
		remove_child(wheel)
		wheel.killSelf()
	wheels.clear()


func getWheels():
	var wheels := []
	for node in get_children():
		if node.is_in_group("wheel"):
			wheels.append(node)
	return wheels


func createWheels():
	for i in wheelnum:
		createWheel()
	randomizeWheelSpeeds()


func createWheel():
	var wheel = instantiateAndMove()
	if not Engine.editor_hint:
		attachSignals(wheel)
	
	wheels.append(wheel)
	add_child(wheel)
	wheel.set_owner(get_tree().edited_scene_root)


func instantiateAndMove():
	var wheel = wheelScene.instance()
	
	wheel.tilesize = tilesize
	wheel.tilenum = tilenum
	wheel.tilepadding = tilepadding
	
	wheel.position.x = wheels.size() * (tilesize + wheelpadding)
	
	return wheel


func attachSignals(wheel: Node):
	wheel.connect("wheel_moving", self, "wheelCompletedStart")
	wheel.connect("wheel_stopped", self, "wheelCompletedStop")


func get_wheels():
	var wheels = []
	for child in get_children():
		if child.is_in_group("wheel"):
			wheels.append(child)
	return wheels


func toggleSpin(coinCount: int):
	match state:
		States.STILL:
			if (coinCount < 1):
				return false
			startSpin()
			return true
			# return whether we've started to move...
			# bad and cheap but I am sick of defining signalsssss
		States.MOVING:
			stopSpin()
		States.START:
			pass
		States.STOP:
			pass


func startSpin():
	for wheel in get_wheels():
		wheel.updateState(wheel.States.START)
		wheelWaitCount = wheelnum


func stopSpin():
	for wheel in get_wheels():
		wheel.updateState(wheel.States.SLOW)
		wheelWaitCount = wheelnum


func wheelCompletedStart():
	wheelWaitCount -= 1
	if wheelWaitCount <= 0:
		state = States.MOVING
	pass

func wheelCompletedStop():
	wheelWaitCount -= 1
	if wheelWaitCount <= 0:
		state = States.STILL
		randomizeWheelSpeeds()
		emit_signal("wheels_stopped")
	pass

func randomizeWheelSpeeds():
	for wheel in get_wheels():
		wheel.speed = 20 + (randi() % 10)

func getTiles():
	var tiles := []
	for wheel in getOrderedWheels():
		tiles.append(wheel.getTileIntersectingWith(winline))
	return tiles

func getOrderedWheels():
	# we're going to do whats called a pro gamer move
	# and just assume that the wheels returned will be in order.
	# wow.
	return get_wheels()

func _ready():
	ready = true
	redraw()
