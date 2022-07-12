extends PlayerState

func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Fall")
	
	var move_dir: float = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	player.velocity.x = player.move_spd * move_dir
	player.velocity.y = player.GRAVITY * delta

	var snap_vec = player.transform.y * 8
	player.velocity = player.move_and_slide_with_snap(player.velocity.rotated(player.rotation), snap_vec, -player.transform.y, true)
	player.velocity = player.velocity.rotated(-player.rotation)

	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
	
	elif is_equal_approx(move_dir, 0.0):
		state_machine.transition_to("Idle")
