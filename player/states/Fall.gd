extends PlayerState

func physics_update(delta: float) -> void:
	if Input.is_action_just_pressed("jump") and player.curr_jumps != 0:
		state_machine.transition_to("Jump")

	var move_dir = 0
	if Input.is_action_pressed("move_left"):
		move_dir = -1
	elif Input.is_action_pressed("move_right"):
		move_dir = 1
	else:
		move_dir = 0
	
	player.velocity.x = player.air_spd * move_dir
	player.velocity.y += player.gravity * delta

	var snap_vec = player.transform.y * 8
	player.velocity = player.move_and_slide_with_snap(player.velocity.rotated(player.rotation), snap_vec, -player.transform.y, true)
	player.velocity = player.velocity.rotated(-player.rotation)
	
	if player.is_on_floor():
		player.curr_jumps = player.num_jumps
		if move_dir == 0:
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
