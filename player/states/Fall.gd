# fall state
extends PlayerState

func update(delta: float) -> void:
	p.anim_player.play("duck_jump")
	if Input.is_action_just_pressed("jump") and p.curr_jumps != 0:
		state_machine.transition_to("Jump")

func physics_update(delta: float) -> void:
	var move_dir = 0
	move_dir = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	p.velocity.x = p.air_spd * move_dir
	p.velocity.y += p.GRAVITY * delta

	var snap_vec = p.transform.y * 8
	p.velocity = p.move_and_slide_with_snap(p.velocity.rotated(p.rotation), snap_vec, -p.transform.y, true)
	p.velocity = p.velocity.rotated(-p.rotation)
	
	if p.is_on_floor():
		p.curr_jumps = p.num_jumps
		p.anim_player.play("duck_land")
		if move_dir == 0:
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
