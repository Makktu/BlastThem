extends Node2D

var first_run = true

var shake_amount = 1

onready var laser_fired = false

#onready var obstacle_scene = preload("res://Scenes/ObstacleWorld.tscn")
var obstacles = null

onready var screensize = get_viewport().size

onready var laser_angle = 0

var all_balls_gone = false

var difficulty = 8

var new_shot = 0

#func _ready() -> void:
#	obstacles = obstacle_scene.instance()
	
	
func kaboom(type = ""):
	if type == "red":
		$GreenBoxKiller.play()
	else:
		$BoxKiller.play()

	
#func check_all_balls():
#	if !get_tree().root.get_child(0).has_node():
#		all_balls_gone = true
		
