extends Node2D


func _ready() -> void:
	pass
	
func move_down():
	$ObstacleWorld/ObstacleContainer/AnimationPlayer.play("move_down")
