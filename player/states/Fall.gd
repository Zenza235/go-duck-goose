extends PlayerState

func physics_update(delta: float) -> void:
    if player.is_on_floor():
        player.curr_jumps = player.num_jumps
        state_machine.transition_to("Idle")

    if Input.is_action_just_pressed("jump") and player.curr_jumps != 0:
        state_machine.transition_to("Jump")

    var move_dir: float = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
    player.velocity.x = player.air_spd * air_dir
    player.velocity.y = player.GRAVITY * delta

    snap_vec = player.transform.y * 8
    player.velocity = move_and_slide_with_snap(player.velocity.rotated(player.rotation), snap_vec, -player.transform.y, true)
    player.velocity = player.velocity.rotated(-player.rotation)