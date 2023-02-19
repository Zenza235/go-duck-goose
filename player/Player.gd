class_name Player
extends KinematicBody2D

signal changed_bird(bird_name)
signal updated_jump(num_jump)

export var init_bird := NodePath()
onready var curr_bird = get_node(init_bird)

const GRAVITY = 2000

# player movement
var velocity := Vector2.ZERO
var facing_right = true

# player attributes
var move_spd
var air_spd
var jump_spd
var num_jumps
var curr_jumps

func _ready():
	switch_to(init_bird)

func _input(event: InputEvent) -> void:
	# running
	var move_dir = 0
	move_dir = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if move_dir > 0:
		
	
	if event.is_action_pressed("switch"):
		if curr_bird == $Duck:
			switch_to("Goose")
		elif curr_bird == $Goose:
			switch_to("Duck")
		
		if self.is_on_floor():
			curr_jumps = num_jumps

# stance change functions
func switch_to(target_bird_name: String) -> void:
	curr_bird = get_node(target_bird_name)
	
	self.move_spd = curr_bird.MOVE_SPEED
	self.air_spd = curr_bird.AIR_SPEED
	self.jump_spd = curr_bird.JUMP_SPEED
	self.num_jumps = curr_bird.NUM_JUMPS
	
	emit_signal("changed_bird", curr_bird.name)
	emit_signal("updated_jump", num_jumps)
