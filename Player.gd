extends CharacterBody2D

@export var health : int = 100

const MAX_SPEED : float = 500
var ACCELERATION : float = 2000
var motion : Vector2 = Vector2.ZERO # Equaliant to Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame
func _physics_process(delta):
	var axis = get_input_axis()
	# If the player is not providing input
	if axis == Vector2.ZERO:
		apply_friction(ACCELERATION * delta)
	else: # Otherwise move
		apply_movement(axis * ACCELERATION * delta)
	# Apply the motion
	velocity = motion
	# Move to the position unless it hits a collision then it will stop at the collision point
	move_and_slide()

func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return axis.normalized()

func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO
	
func apply_movement(acceleration):
	motion += acceleration
	if motion.length() > MAX_SPEED:
		motion = motion.normalized() * MAX_SPEED
