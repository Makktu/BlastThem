extends Node2D

onready var game_is_over = false
onready var laser_fired = false
onready var screensize = get_viewport().size
onready var laser_angle = 0

var screen_is_touched = false
var finger_moving = false
var touch_counter = 0

var first_run = true
var obstacles = null
var moved_down = false
#var all_balls_gone = true

var boosted_shots = 0

var player_score = 0
var best_score = 0
var best_score_beaten = false

var charge_has_played = false

var diamond_on_screen = false
var bomb_likelihood = 2
var balls_boosted = false
var balls_allowed = 5
var new_shot = 0
var shoot_delay = 0.3

var diamond_shot = false
var first_bomb = false

var user_OS = OS.get_name()


func _ready() -> void:
	print(user_OS)
	
func kaboom(type = ""):
	if type == "red":
		$GreenBoxKiller.play()
	else:
		$BoxKiller.play()
		
func game_over():
	# interrupt all actions
	
	get_tree().paused = true
	game_is_over = true
	
	if !best_score_beaten:
		$GameOverSound.play()
	
	if best_score_beaten:
		$CanvasLayer/GameOverFade/NewBestScore.visible = true
		$BestScoreTune.play()
	
	game_over_fade()
	
	$FadeTimer.start()

	
	
func game_over_fade():
	$CanvasLayer.visible = true
	$CanvasLayer/GameOverFade/AnimationPlayer.play("game_over")
	
func charging(diamond = ""):
	if diamond:
		$DiamondBooster.play()
	else:
		$BallsBoosted.play()
		
		
func _on_PlayAgain_pressed() -> void:
	get_tree().paused = false
	game_is_over = false
	$CanvasLayer.visible = false
	$CanvasLayer/GameOverFade/PlayAgain.visible = false
	if best_score_beaten:
		$CanvasLayer/GameOverFade/NewBestScore.visible = false
		best_score_beaten = false
	get_tree().change_scene("res://Scenes/World.tscn")


func _on_FadeTimer_timeout() -> void:
	$CanvasLayer/GameOverFade/PlayAgain.visible = true
