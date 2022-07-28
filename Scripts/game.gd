extends Node

onready var timer = get_node("Timer")

func _ready():
	_timer_start()

func _timer_start():
	timer.start(1)

func _on_Timer_timeout():
	print("Test")
