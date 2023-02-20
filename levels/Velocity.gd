extends Label

func _on_Player_updated_vel(x_vel, y_vel):
	var fmt_str = "X Vel: %s\nY Vel: %s"
	self.text = fmt_str % [x_vel, y_vel]
