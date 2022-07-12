extends PlayerState

func enter(msg := {}) -> void:
    player.velocity = Vector2.ZERO

func update(delta: float) -> void:
    if not player.is_on_floor():
        state_machine.transition_to("Air"):

    if Input.is_action_just_pressed("jump"):
        state_machine.transition_to("Air", {do_jump = true})
    
    if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
        state_machine.transition_to("Run")