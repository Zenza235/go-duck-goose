class_name Player
extends KinematicBody2D

signal changed_bird(bird_name)

export var init_bird := NodePath()

onready var bird = get_node(init_bird)

var gravity

var move_spd
var air_spd
var jump_spd

var num_jumps
var curr_jumps

var velocity := Vector2.ZERO

func _ready():
	set_attr_to(bird)
	emit_signal("changed_bird", bird.name)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("switch"):
		if bird == $Duck:
			switch_to("Goose")
		elif bird == $Goose:
			switch_to("Duck")

func switch_to(target_bird_name: String) -> void:
	bird = get_node(target_bird_name)
	set_attr_to(bird)
	emit_signal("changed_bird", bird.name)

func set_attr_to(bird: Node) -> void:
	self.gravity = bird.GRAVITY
	self.move_spd = bird.MOVE_SPEED
	self.air_spd = bird.AIR_SPEED
	self.jump_spd = bird.JUMP_SPEED
	
	self.num_jumps = bird.NUM_JUMPS
	self.curr_jumps = self.num_jumps
	
