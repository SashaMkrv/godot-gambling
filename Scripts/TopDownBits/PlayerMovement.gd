extends KinematicBody2D

onready var animationTree = $AnimationTree
onready var area2D = $Area2D
onready var animationState = animationTree.get("parameters/playback")

var speed = 100  # speed in pixels/sec
var velocity = Vector2.ZERO

func _ready():
	setBlendPosition(Vector2.DOWN)


func _unhandled_input(event):
	pass #crap. how do I eat the events. how did this WORK with the universal event kill??


func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	# if this were 3.4, we'd be able to just use Input.get_vector
	
	if velocity != Vector2.ZERO:
		setBlendPosition(velocity)
		
		animationState.travel("Walk2")
	else:
		animationState.travel("Idle2")
	
	velocity = velocity.normalized() * speed


func setBlendPosition(velocity: Vector2):
	$AnimationTree.set("parameters/Idle2/blend_position", velocity)
	$AnimationTree.set("parameters/Walk2/blend_position", velocity)
	var angle = velocity.angle_to(Vector2.UP)
	area2D.rotation = -angle


func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)
