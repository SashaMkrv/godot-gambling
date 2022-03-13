extends KinematicBody2D

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

var speed = 100  # speed in pixels/sec
var velocity = Vector2.ZERO

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
		$AnimationTree.set("parameters/Idle2/blend_position", velocity)
		$AnimationTree.set("parameters/Walk2/blend_position", velocity)
		animationState.travel("Walk2")
	else:
		animationState.travel("Idle2")
	
	velocity = velocity.normalized() * speed

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)
