# idle state 
extends PlayerState

var may_jump = 0.5

func enter() -> void:
	p.move_dir = 0
	p.velocity = Vector2.ZERO

func update(delta: float) -> void:
	if Input.is_action_pressed("crouch"):
		p.anim_player.play("duck_crouch")		
	
	elif not p.is_on_floor():
		p.curr_jumps -= 1
		state_machine.transition_to("Fall")

	elif Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
	
	elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		state_machine.transition_to("Run")

	else:
		p.anim_player.play("duck_idle")
