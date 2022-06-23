extends KinematicBody2D

var mov_spd = 300
var jmp_spd = 300
var gravity = 1000

var accel = 0.1
var friction = 0.1

var velocity = Vector2.ZERO

func get_input():
	var input_dir = 0
	if Input.is_action_pressed("move_left"):
		input_dir -= 1
	if Input.is_action_pressed("move_right"):
		input_dir += 1
	if input_dir != 0:
		velocity.x = lerp(velocity.x, input_dir * mov_spd, accel)
	else:
		velocity.x = lerp(velocity.x, 0, friction)

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = -jmp_spd
