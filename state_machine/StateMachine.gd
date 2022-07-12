class_name StateMachine
extends Node

signal transitioned(state_name)

export var init_state := NodePath()

onready var state: State = get_node(init_state)

func _ready() -> void:
	yield(owner, "ready")
	for child in get_children():
		child.state_machine = self
	state.enter()

func _process(delta: float) -> void:
	state.update(delta)

func _physics_process(delta: float) -> void:
	state.physics_update(delta)

func transition_to(target_state_name: String) -> void:
	assert(has_node(target_state_name))

	state.exit()
	state = get_node(target_state_name)
	state.enter()
	emit_signal("transitioned", state.name)
