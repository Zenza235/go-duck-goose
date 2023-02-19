# idle state 
extends PlayerState

func enter() -> void:
	p.velocity = Vector2.ZERO

func update(delta: float) -> void:
	#if Input.is_action_pressed("crouch"):
	#	p.anim_player.play("duck_crouch")
	
	if not p.is_on_floor():
		p.curr_jumps -= 1
		state_machine.transition_to("Fall")

	elif Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
	
	elif Input.get_action_strength("move_right") - Input.get_action_strength("move_left") != 0:
		state_machine.transition_to("Run")

	#else:
	#	p.anim_player.play("duck_idle")
