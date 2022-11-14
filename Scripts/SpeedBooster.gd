extends KinematicBody2D

var hits = 0
var box_scale = Vector2()

#func _ready():
#	$Box/AnimationPlayer.play("rotate")

func _on_Area2D_body_entered(body: Node) -> void:
		if "Laser" in body.name:
			$"/root/Global".kaboom()
			hits += 1
			scale.x -= 0.2
			scale.y -= 0.2
			if hits > 2:
				$CollisionShape2D.set_deferred("disabled", true)
				$Area2D/CollisionShape2D.set_deferred("disabled", true)
				$"/root/Global".kaboom("red")
				$Kaboom.visible = true
				$Kaboom.scale.x = 4
				$Kaboom.scale.y = 4
				$Kaboom.play("kaboom")
				$Timer.start()


func _on_Timer_timeout():
	$"/root/Global".player_score += 1
	queue_free()


func _on_Area2D_area_entered(area: Area2D) -> void:
		if "GameOverLine" in area.name:
			$"/root/Global".game_over()
