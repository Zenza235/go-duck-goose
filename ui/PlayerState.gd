extends Label

func _on_state_transitioned(state_name):
	var fmt_str = "Player State: %s"
	self.text = fmt_str % state_name
