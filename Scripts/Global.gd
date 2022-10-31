extends Node2D

onready var laser_fired = false

onready var obstacle_scene = preload("res://Scenes/ObstacleWorld.tscn")
var obstacles = null

onready var screensize = get_viewport().size

onready var laser_angle = 0

var all_balls_gone = false

var difficulty = 5

var new_shot = 0

func _ready() -> void:
	obstacles = obstacle_scene.instance()
	
func game_over():
	print("THIS IS IT, THE REAL GAME OVER")
	
func kaboom():
	$BoxKiller.play()
	
#func check_all_balls():
#	if !get_tree().root.get_child(0).has_node():
#		all_balls_gone = true
		
