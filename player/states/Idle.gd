extends PlayerState

func enter() -> void:
    player.velocity = Vector2.ZERO

func update(delta: float) -> void:
    if not player.is_on_floor():
        state_machine.transition_to("Fall"):

    if Input.is_action_just_pressed("jump"):
        state_machine.transition_to("Jump")
    
    if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
        state_machine.transition_to("Run")