extends Node2D

var title_direction = -20

func _ready() -> void:
#	$AudioStreamPlayer.play()
	_on_TitleTimer_timeout()
	pass


func _on_START_pressed() -> void:
	$"/root/Global".game_is_over = false
	get_tree().change_scene("res://Scenes/World.tscn")


func _on_TitleTimer_timeout() -> void:
	$BGContainer/Title.position.y += title_direction
	if $BGContainer/Title.position.y > 391 or $BGContainer/Title.position.y < 150:
		title_direction = -title_direction
	$TitleTimer.start()
	 
