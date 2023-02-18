extends Label

func _on_Player_changed_bird(bird_name):
	var fmt_str = "Current Bird: %s"
	self.text = fmt_str % bird_name
