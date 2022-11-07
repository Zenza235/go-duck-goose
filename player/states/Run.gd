# run state
extends PlayerState

func update(delta: float) -> void:
	if Input.is_action_pressed("crouch"):
		state_machine.transition_to("Idle")
		
	else:
		p.anim_player.play("duck_run")
	
	if Input.is_action_just_pressed("jump"):
		p.anim_player.play("duck_jumpsquat")
		state_machine.transition_to("Jump")

func physics_update(delta: float) -> void:
	if not p.is_on_floor():
		p.curr_jumps -= 1
		state_machine.transition_to("Fall")
	
	var move_dir = 0
	move_dir = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if move_dir == 0:
		state_machine.transition_to("Idle")

	p.velocity.x = p.move_spd * move_dir
	p.velocity.y = p.GRAVITY * delta

	var snap_vec = p.transform.y * 8
	p.velocity = p.move_and_slide_with_snap(p.velocity.rotated(p.rotation), snap_vec, -p.transform.y, true)
	p.velocity = p.velocity.rotated(-p.rotation)
	
	if is_equal_approx(move_dir, 0.0):
		state_machine.transition_to("Idle")
