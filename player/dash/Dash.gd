extends Node

const COOLDOWN_TIME = 0.5

onready var timer = $DashTimer
onready var ghost_timer = $GhostTimer
var ghost_scene = preload("res://player/dash/DashGhost.tscn")
var can_dash = true
var sprite
		
func start_dash(sprite, dash_dur):
	self.sprite = sprite
	
	timer.wait_time = dash_dur
	timer.start()
	
	ghost_timer.start()
	instance_ghost()


func instance_ghost():
	var ghost = ghost_scene.instance()
	get_parent().get_parent().add_child(ghost)
	
	ghost.global_position = sprite.global_position
	ghost.region_rect = sprite.region_rect
	ghost.region_enabled = sprite.region_enabled
	ghost.texture = sprite.texture
	ghost.vframes = sprite.vframes
	ghost.hframes = sprite.hframes
	ghost.frame = sprite.frame
	ghost.flip_h = sprite.flip_h
	

func is_dashing():
	return !timer.is_stopped()


func end_dash():
	ghost_timer.stop()
	
	can_dash = false
	yield(get_tree().create_timer(COOLDOWN_TIME), 'timeout')
	can_dash = true


func _on_DashTimer_timeout():
	end_dash()


func _on_GhostTimer_timeout():
	instance_ghost()
