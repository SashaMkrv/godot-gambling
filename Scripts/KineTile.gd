extends KinematicBody2D

tool

export(int, 5, 100) var tilesize = 10 setget updateTileSize
export(Color) var tilecolor = Color.darkorange setget updateColor
export(int, 1, 3000) var maxdistance = 100
# this maximum is fully arbitrary. Just wanted the minimum to not have negatives.
export(int, 5, 1000) var speed = 40 setget updateSpeed

var velocity := Vector2(0, speed)
var up := Vector2(0, -1)

var ready := false

var polygon_size := 10

enum TILE_TYPES {seven, banana, watermelon, cherry, spades, diamonds, clubs, hearts, rabbit, bar, dollarsign, horseshoe, tree, diamond}
export(TILE_TYPES) var tiletype = TILE_TYPES.rabbit setget updateType
var tileindex := 0 setget updateType

var allTypes := [
	TILE_TYPES.seven,
	TILE_TYPES.bar,
	TILE_TYPES.rabbit,
	TILE_TYPES.cherry,
	TILE_TYPES.banana,
	TILE_TYPES.watermelon,
	TILE_TYPES.diamonds,
	TILE_TYPES.spades,
	TILE_TYPES.hearts,
	TILE_TYPES.clubs,
	TILE_TYPES.dollarsign,
	TILE_TYPES.horseshoe,
	TILE_TYPES.tree,
	TILE_TYPES.diamond,
]

func updateType(newVar):
	tileindex = newVar
	tiletype = tileindex % allTypes.size() # this is all terrible and irresponsible
	redraw()

var tileToFrame = {
	TILE_TYPES.cherry: 0,
	TILE_TYPES.seven: 1,
	TILE_TYPES.bar: 2,
	TILE_TYPES.rabbit: 3,
	TILE_TYPES.banana: 4,
	TILE_TYPES.watermelon: 5,
	TILE_TYPES.diamonds: 6,
	TILE_TYPES.spades: 7,
	TILE_TYPES.hearts: 8,
	TILE_TYPES.clubs: 9,
	TILE_TYPES.dollarsign: 10,
	TILE_TYPES.horseshoe: 11,
	TILE_TYPES.tree: 12,
	TILE_TYPES.diamond: 13
}

enum TILE_CLASSES {fruit, bar, rabbit, suit, seven, gem, goldthing, greenthing, nothing}

var tileToClass = {
	TILE_TYPES.cherry: TILE_CLASSES.fruit,
	TILE_TYPES.seven: TILE_CLASSES.seven,
	TILE_TYPES.bar: TILE_CLASSES.bar,
	TILE_TYPES.rabbit: TILE_CLASSES.rabbit,
	TILE_TYPES.banana: TILE_CLASSES.fruit,
	TILE_TYPES.watermelon: TILE_CLASSES.fruit,
	TILE_TYPES.diamonds: TILE_CLASSES.suit,
	TILE_TYPES.spades: TILE_CLASSES.suit,
	TILE_TYPES.hearts: TILE_CLASSES.suit,
	TILE_TYPES.clubs: TILE_CLASSES.suit,
	TILE_TYPES.dollarsign: TILE_CLASSES.goldthing,
	TILE_TYPES.horseshoe: TILE_CLASSES.goldthing,
	TILE_TYPES.tree: TILE_CLASSES.greenthing,
	TILE_TYPES.diamond: TILE_CLASSES.gem,
}

func updateColor(newVar: Color):
	tilecolor = newVar
	redraw()


func updateTileSize(newVar: int):
	tilesize = newVar
	redraw()


func updateSpeed(newVar: int):
	speed = newVar
	velocity.y = speed


func redraw():
	if ready:
		updateTile()


func updateTile():
	$Square.color = tilecolor
	$Square.polygon = createSquare()
	var newScale = (1.0 * tilesize)/polygon_size # I would very much like to have pythons double divide for floats
	$Square.scale.x = newScale
	$Square.scale.y = newScale
	$Square/AnimatedSprite.frame = tileToFrame[tiletype]

# I would prefer to not use this actually
# so I guess I won't call it unless I need to replace the square???
func createSquare():
	return PoolVector2Array([
		Vector2(0, polygon_size),
		Vector2(polygon_size, polygon_size),
		Vector2(polygon_size, 0),
		Vector2(0, 0)
	])


func killSelf():
	queue_free()

func _ready():
	ready = true
	redraw()

func moveToStartIfOutOfBounds():
	if position.y > maxdistance:
		var diff = maxdistance - position.y
		position.y = diff
		return true
	return false 


func blink():
	$AnimationPlayer.play("Blink")


func unblink():
	$AnimationPlayer.stop(true)
	$AnimationPlayer.play("Unblink")
