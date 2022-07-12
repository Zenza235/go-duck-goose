extends PlayerState

func enter() -> void:
	player.curr_jumps -= 1
	player.velocity.y = -player.jump_spd

func physics_update(delta: float) -> void:
	var move_dir: float = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	player.velocity.x = player.air_spd * move_dir
	player.velocity.y = player.GRAVITY * delta

	var snap_vec = Vector2.ZERO
	player.velocity = player.move_and_slide_with_snap(player.velocity.rotated(player.rotation), snap_vec, -player.transform.y, true)
	player.velocity = player.velocity.rotated(-player.rotation)

	if player.velocity.y == 0.0:
		state_machine.transition_to("Fall")
