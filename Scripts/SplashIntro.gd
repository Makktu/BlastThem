extends Node2D


func _ready():
	$ThereminTimer.start()
	$AnimationPlayer.play("fade_in")


func _on_Timer_timeout():
	$AnimationPlayer.play_backwards("fade_in")
	$Timer2.start()

func _on_Timer2_timeout():
	get_tree().change_scene("res://Scenes/StartScreen.tscn")
	$"/root/Global".playing_start_music = true


func _on_ThereminTimer_timeout() -> void:
	$ThereminIntro.play()
