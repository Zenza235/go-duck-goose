extends Label

func _on_Player_updated_jump(jumps):
	var fmt_str = "Jumps: %s"
	self.text = fmt_str % jumps
