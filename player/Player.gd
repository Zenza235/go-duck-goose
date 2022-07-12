class_name Player
extends KinematicBody2D

const GRAVITY = 1000

var move_spd = 300
var air_spd = 200
var jump_spd = 300

var num_jumps = 2
var curr_jumps = num_jumps

var snap_vec

var velocity := Vector2.ZERO