extends Node2D

var turn_one = true


func _ready() -> void:
	pass
	
func move_down():
	$ObstacleWorld/ObstacleContainer/AnimationPlayer.play("move_down")
	if !turn_one:
		$ObstacleWorld.position.y += 20
	if turn_one:
		turn_one = false
	if $ObstacleWorld.position.y > 350:
		print("GAME OVER")


func _on_GameOverLine_body_entered(body):
	print(body.name)
	if body.name == "SpeedBooster":
		print("*******TRUE GAME OVER !!!") 
