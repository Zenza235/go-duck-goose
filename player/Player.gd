extends KinematicBody2D

# code is currently temp; just to test movement
# possible issue w/ speed being inconsistent on slopes

var mov_spd = 300
var jmp_spd = 300
var gravity = 1000

var accel = 0.1
var friction = 0.05

var velocity = Vector2.ZERO
var is_jumping = false

var snap

func get_input():
	var input_dir = 0
	if Input.is_action_pressed("move_left"):
		input_dir -= 1
	if Input.is_action_pressed("move_right"):
		input_dir += 1
	if input_dir != 0:
		velocity.x = lerp(velocity.x, input_dir * mov_spd, accel)
	else:
		if is_on_floor():
			velocity.x = 0
		else:
			velocity.x = lerp(velocity.x, 0, friction)

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	if is_on_floor():
		is_jumping = false
		if Input.is_action_just_pressed("jump"):
			is_jumping = true
			velocity.y = -jmp_spd
	snap = transform.y * 8 if !is_jumping else Vector2.ZERO
	velocity = move_and_slide_with_snap(velocity.rotated(rotation), snap, -transform.y, true)
	velocity = velocity.rotated(-rotation)
