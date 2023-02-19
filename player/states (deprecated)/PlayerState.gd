class_name PlayerState
extends State

var p: Player

func _ready() -> void:
	yield(owner, "ready")
	
	p = owner as Player
	assert(p != null)
