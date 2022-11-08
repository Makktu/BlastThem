extends Node2D

signal score_changed

var first_run = true

var shake_amount = 1

onready var laser_fired = false

var obstacles = null

var moved_down = false

onready var screensize = get_viewport().size

onready var laser_angle = 0

var all_balls_gone = false

var player_score = 0
var best_score = 0

var bomb_likelihood = 2
#var difficulty = 7
var balls_boosted = false
var balls_allowed = 5
var new_shot = 0
#var turn = 1

#func _ready() -> void:
#	obstacles = obstacle_scene.instance()
	
	
func kaboom(type = ""):
	if type == "red":
		$GreenBoxKiller.play()
	else:
		$BoxKiller.play()
		
func game_over():
	print("*************************************")

	
#func check_all_balls():
#	if !get_tree().root.get_child(0).has_node():
#		all_balls_gone = true
		
