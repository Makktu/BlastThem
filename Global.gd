extends Node2D

onready var laser_fired = false

onready var screensize = get_viewport().size

onready var laser_angle = 0

func _ready() -> void:
	print(screensize)
