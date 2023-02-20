class_name Player
extends KinematicBody2D

signal changed_bird(bird_name)
signal updated_jump(jumps)
signal updated_vel(x_vel, y_vel)

export var init_bird := NodePath()
onready var curr_bird = get_node(init_bird)
# temp assets until goose implementation is figured out
onready var sprite = $DuckSprite
onready var collision = $DuckCollision

const GRAVITY = 2000
const MAX_FALL_SPEED = 1000

onready var dash = $Dash
const DASH_SPEED = 1000
const DASH_TIME = .15 # seconds

# player movement
var velocity := Vector2.ZERO
var facing_right = true

# player attributes
var move_spd
var air_spd
var jump_spd
var total_jumps
var curr_jumps setget set_jumps 

func _ready():
	switch_to(init_bird)

func _physics_process(delta):
	# debug
	emit_signal("updated_vel", velocity.x, velocity.y)
	
	# dashing movement
	if dash.is_dashing(): 
		velocity.x = DASH_SPEED if facing_right else -DASH_SPEED
		velocity.y = 0
		move_and_slide(velocity, Vector2(0, -1))
		return
	
	var move_dir = 0
	move_dir = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if facing_right and move_dir < 0:
		flip()
	if !facing_right and move_dir > 0:
		flip()
	
	var grounded = is_on_floor()
	
	velocity.x = move_spd * move_dir
	velocity.y += GRAVITY * delta
	if Input.is_action_just_pressed("jump"):
		if grounded:
			set_jumps(curr_jumps - 1)
			velocity.y = -jump_spd
		if !grounded and curr_jumps > 0:
			set_jumps(curr_jumps - 1)
			velocity.y = -jump_spd
	if grounded and velocity.y >= 0:
		set_jumps(total_jumps)
		velocity.y = 0
	if velocity.y > MAX_FALL_SPEED:
		velocity.y = MAX_FALL_SPEED
	if is_on_ceiling():
		velocity.y = 0
		velocity.y += GRAVITY * delta
	
	if Input.is_action_just_pressed("switch"):
#		print("is dash on cooldown: %s" % dash.is_on_cooldown())
		if dash.can_dash:
			dash.start_dash(sprite, DASH_TIME)
			if curr_bird == $Duck:
				switch_to("Goose")
			elif curr_bird == $Goose:
				switch_to("Duck")
	
	move_and_slide(velocity, Vector2(0, -1))


# flipping sprite
func flip():
	facing_right = !facing_right
	sprite.flip_h = !sprite.flip_h


# stance change function
func switch_to(target_bird_name: String) -> void:
	curr_bird = get_node(target_bird_name)
	emit_signal("changed_bird", curr_bird.name)
	
	self.move_spd = curr_bird.MOVE_SPEED
	self.air_spd = curr_bird.AIR_SPEED
	self.jump_spd = curr_bird.JUMP_SPEED
	self.total_jumps = curr_bird.TOTAL_JUMPS
	set_jumps(total_jumps)


func set_jumps(num_jumps):
	curr_jumps = num_jumps
	emit_signal("updated_jump", curr_jumps)
