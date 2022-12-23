extends Node2D

var title_direction = -20

func _ready() -> void:
#	$AudioStreamPlayer.play()
	_on_TitleTimer_timeout()
	$BGContainer/BestScore/BestScore.text = str($"/root/Global".best_score)



func _on_START_pressed() -> void:
	$"/root/Global".game_is_over = false
	$"/root/Global".stop_start_music = true
	$KaboomTimer.start()



func _on_TitleTimer_timeout() -> void:
	$BGContainer/Title.position.y += title_direction
	if $BGContainer/Title.position.y > 391 or $BGContainer/Title.position.y < 150:
		title_direction = -title_direction
	$TitleTimer.start()


func _on_About_pressed():
	get_tree().change_scene("res://Scenes/About.tscn")


func _on_KaboomTimer_timeout() -> void:
	get_tree().change_scene("res://Scenes/World.tscn")
