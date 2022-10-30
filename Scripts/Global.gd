extends Node2D

onready var laser_fired = false

onready var obstacle_scene = preload("res://Scenes/ObstacleWorld.tscn")
var obstacles = null

onready var screensize = get_viewport().size

onready var laser_angle = 0

func _ready() -> void:
	obstacles = obstacle_scene.instance()
	

