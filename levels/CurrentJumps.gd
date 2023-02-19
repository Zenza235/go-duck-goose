extends Label


func _on_Player_updated_jump(num_jump):
	var fmt_str = "Num Jumps: %s"
	self.text = fmt_str % num_jump
