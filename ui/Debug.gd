extends CanvasLayer

onready var bird_state_label = $BirdState
onready var num_jumps_label = $NumJumps
onready var velocity_label = $Velocity
onready var dash_bar = $DashCooldown 

func _on_Player_changed_bird(bird_name):
	var base = "Bird State: %s"
	bird_state_label.text = base % bird_name


func _on_Player_updated_jump(jumps):
	var base = "Jumps: %s"
	num_jumps_label.text = base % jumps


func _on_Player_updated_vel(x_vel, y_vel):
	var base = "Vel: (%s, %s)"
	velocity_label.text = base % [x_vel, y_vel]


func _on_CooldownTimer_timeout():
	dash_bar.value = dash_bar.max_value


func _on_Dash_push_cooldown_time(time):
	dash_bar.value = time
