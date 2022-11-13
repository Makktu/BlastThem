extends Node2D

onready var game_is_over = false
onready var laser_fired = false
onready var screensize = get_viewport().size
onready var laser_angle = 0

var first_run = true
var obstacles = null
var moved_down = false
var all_balls_gone = false
var player_score = 0
var best_score = 0
var bomb_likelihood = 2
var balls_boosted = false
var balls_allowed = 5
var new_shot = 0

	
func kaboom(type = ""):
	if type == "red":
		$GreenBoxKiller.play()
	else:
		$BoxKiller.play()
		
func game_over():
	
	# interrupt all actions
	game_is_over = true
	
	# check if best score is new
	# acknowledge if so
	# and update all variables
	# here
	
	# fade the screen
	# and show the play again button
	game_over_fade()
	$GameOverFade.visible = true
	$GameOverFade/PlayAgain.visible = true
	
	
func game_over_fade():
	# this is not working
	for n in 125:
		$GameOverFade.self_modulate.a = n
		yield(get_tree().create_timer(0.5), "timeout")	
		
		
func _on_PlayAgain_pressed() -> void:
	game_is_over = false
	$GameOverFade.visible = false
	$GameOverFade/PlayAgain.visible = false
	get_tree().change_scene("res://Scenes/World.tscn")
