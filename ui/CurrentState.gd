extends Label

func _on_StateMachine_transitioned(state_name):
	var fmt_str = "Current State: %s"
	self.text = fmt_str % state_name
