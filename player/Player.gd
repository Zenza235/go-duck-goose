class_name Player
extends KinematicBody2D

signal changed_bird(bird_name)

export var init_bird := NodePath()

onready var bird = get_node(init_bird)
onready var anim_player = get_node("AnimationPlayer")

const GRAVITY = 2000

var move_spd
var air_spd
var jump_spd

var num_jumps
var curr_jumps

var move_dir = 0
var facing_right = true

var velocity := Vector2.ZERO

func _ready():
	
	
	set_attr_to(bird)
	curr_jumps = num_jumps
	emit_signal("changed_bird", bird.name)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("switch"):
		if bird == $Duck:
			switch_to("Goose")
		elif bird == $Goose:
			switch_to("Duck")
		
		if self.is_on_floor():
			curr_jumps = num_jumps

func switch_to(target_bird_name: String) -> void:
	bird = get_node(target_bird_name)
	set_attr_to(bird)
	emit_signal("changed_bird", bird.name)

func set_attr_to(b: Node) -> void:
	self.move_spd = b.MOVE_SPEED
	self.air_spd = b.AIR_SPEED
	self.jump_spd = b.JUMP_SPEED
	self.num_jumps = b.NUM_JUMPS
	
