extends Node2D

onready var timer = $DashTimer
onready var cooldown = $CooldownTimer

func start_dash(dash_dur, cooldown_dur):
	timer.wait_time = dash_dur
	timer.start()
	
	cooldown.wait_time = cooldown_dur
	cooldown.start()

func is_on_cooldown():
	return !cooldown.is_stopped()

func is_dashing():
	return !timer.is_stopped()
