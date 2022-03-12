extends Node2D

tool

signal wheel_stopped
signal wheel_moving

var ready := false

export(int, 1, 100) var tilesize := 16 setget tileSizeUpdate
export(int, 3, 100) var tilenum := 12 setget tileNumUpdate
export(int, 0, 100) var tilepadding := 2 setget tilePaddingUpdate
export(int, 5, 1000) var speed = 5 setget speedUpdate

enum States {MOVING, STILL, START, SLOW}
var state = States.STILL setget updateState
var currentspeed: int = 0

var bottom: int = (tilesize + tilepadding) * tilenum

var randomColors = [
	Color.gold,
	Color.darkseagreen,
	Color.sandybrown,
	Color.yellowgreen,
	Color.aqua,
	Color.plum,
	Color.orange,
	Color.orchid
]

var tileScene = preload("res://Scenes/Tile.tscn")
var tiles: Array = []

var tileindexes := []

func get_tiles():
	var nodes = get_children()
	var tiles = []
	for node in nodes:
		if node.is_in_group("tile"):
			tiles.append(node)
	return tiles


func tileSizeUpdate(newTileSize: int):
	tilesize = newTileSize
	redraw()
	recalculateBottom()


func tileNumUpdate(newTileNum: int):
	tilenum = newTileNum
	redraw()
	recalculateBottom()


func tilePaddingUpdate(newTilePadding: int):
	tilepadding = newTilePadding
	redraw()
	recalculateBottom()


func speedUpdate(newVar: float):
	speed = newVar
	if Engine.editor_hint:
		return
	updateTileSpeeds()


func updateTileSpeeds():
	for tile in get_tiles():
		tile.speed = speed


func recalculateBottom():
	bottom = (tilepadding + tilesize) * tilenum


func redraw():
	if ready:
		killTiles()
		createTiles()
		

func createTiles():
	tileindexes.clear()
	for i in tilenum:
		tileindexes.append(i)
	tileindexes.shuffle()
	for i in tilenum:
		createNewTile()


func createNewTile():
	var tile = createAndMoveTile()

	add_child(tile) # Parent could be any node in the scene
	tile.set_owner(get_tree().edited_scene_root)


func createAndMoveTile():
	var tile = tileScene.instance()
	
	var tileindex = tileindexes.pop_front()
	
	tile.tileindex = tileindex
	
	tile.tilecolor = randomColors[randi() % randomColors.size()]
	tile.tilesize = tilesize
	tile.maxdistance = bottom
	tile.speed = speed
	
	if tiles.size() > 0:
		tile.position.y = tiles.size() * (tilepadding + tilesize) 
	
	tiles.append(tile)
	
	return tile


func killTiles():
	for tile in get_tiles():
		remove_child(tile)
		tile.queue_free()
	tiles.clear()
	tileindexes.clear()


func _ready():
	ready = true
	redraw()


func _physics_process(_delta):
	if Engine.editor_hint:
		return
	moveTiles()


func autoupdateState(_object, _key):
	match state:
		States.MOVING:
			return
		States.STILL:
			return
		States.SLOW:
			if currentspeed == 0:
				updateState(States.STILL)
		States.START:
			# so like. don't use this anywhere but the one tween you have inside the wheel...
			if currentspeed >= 5:
				updateState(States.MOVING)


func moveTiles():
	if get_tree().paused:
		return
	if state == States.STILL:
		return
	
	var tiles = get_tiles()
	if tiles.empty():
		return
	
	var previousTile = tiles.front()
	
	for i in tiles.size():
		var tile = tiles[-i -1]
#		tile.position.y += currentspeed * 0.03
		tile.position.y += currentspeed * 0.1
#		print("move by " + String(currentspeed))
		if tile.position.y > bottom:
			tile.position.y = previousTile.position.y - tilesize - tilepadding
		previousTile = tile


func updateState(newState):
	if newState == state:
		return
	
	match state:
		States.STILL:
			if newState == States.MOVING or newState == States.START:
				state = States.START
				speedUp()
		States.MOVING:
			if newState == States.STILL or newState == States.SLOW:
				state = States.SLOW
				slowDown()
		# I think I mgiht actually be able to handle going from slow to start and vice versa too
		# as long as that happens in this function
		# but, let's not do that for now. Simple. Think simple.
		States.SLOW:
			if newState == States.STILL:
				state = States.STILL
				emit_signal("wheel_stopped")
				currentspeed = 0
		States.START:
			if newState == States.MOVING:
				state = States.MOVING
				emit_signal("wheel_moving")
	# TODO: use transitions maybe, but, it's cool for now


func speedUp():
	$Tween.interpolate_property(self, "currentspeed", currentspeed, speed, 2.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()


func slowDown():
	$Tween.interpolate_property(self, "currentspeed", currentspeed, 0, 2.0, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()


func getTileIntersectingWith(y: int):
	var tiles = get_tiles()
	var closestTile = tiles.front()
	var top = 0
	var bottom = 0
	for tile in tiles:
		top = tile.position.y - floor(tilepadding/2.0)
		bottom = top + tilesize + floor(tilepadding/2.0) + ceil(tilepadding/2.0)
		if (top <= y && bottom >= y):
			closestTile = tile
	return closestTile


func killSelf():
	queue_free()
