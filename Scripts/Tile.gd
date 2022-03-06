#extends Node2D
#
#tool
#
#export(int, 5, 100) var tilesize = 10 setget updateTileSize
#export(Color) var tilecolor = Color.darkorange setget updateColor
#export(int, 1, 3000) var maxdistance = 100
#export(float, 0.1, 5) var speed = 2
## this maximum is fully arbitrary. Just wanted the minimum to not have negatives.
#
#var ready
#
#func updateColor(newVar: Color):
#	tilecolor = newVar
#	redraw()
#
#func updateTileSize(newVar: int):
#	tilesize = newVar
#	redraw()
#
#func redraw():
#	if ready:
#		updateTile()
#
#
#func updateTile():
#	$Square.color = tilecolor
#	$Square.polygon = createSquare()
#
#func createSquare():
#	return PoolVector2Array([
#		Vector2(0, tilesize),
#		Vector2(tilesize, tilesize),
#		Vector2(tilesize, 0),
#		Vector2(0, 0)
#	])
#
#
#func tweenAway():
#	createTween()
#	$Tween.start()
#
#
#func createTween():
#	$Tween.interpolate_property(self, "position",
#	Vector2(0, position.y),
#	Vector2(0, position.y + maxdistance * speed), # this is a very obstuse variable :/
#	3,
#	Tween.TRANS_LINEAR)
#
#	# this can only chug down, not slowly lose speed
#	# i've screwed myself
#	# maybe static bodies moving around the place makes more sense????
#
#
#func killSelf():
#	queue_free()
#
#func _ready():
#	ready = true
#	redraw()
#	tweenAway()
#
#func _physics_process(_delta):
#	if moveToStartIfOutOfBounds():
#		tweenAway()
#
#
#func moveToStartIfOutOfBounds():
#	if position.y > maxdistance:
#		var diff = maxdistance - position.y
#		position.y = diff
#		$Tween.stop_all()
#		return true
#	return false 
