extends StaticBody2D

var hits = 0
var box_scale = Vector2()

#func _ready():
#	$Box/AnimationPlayer.play("rotate")

func _on_Area2D_body_entered(body: Node) -> void:
		if "Laser" in body.name:
#			$Area2D/CollisionShape2D.scale.x = 10
#			$Area2D/CollisionShape2D.scale.y = 10
			$"/root/Global".kaboom()
#			$Kaboom.visible = true
#			$Kaboom.scale.x = 13
#			$Kaboom.scale.y = 13
#			$Kaboom.play("kaboom")
#			yield(get_tree().create_timer(0.6), "timeout")
#			queue_free()
			hits += 1
			scale.x -= 0.2
			scale.y -= 0.2
#			$Kaboom.visible = true
#			$Kaboom.speed_scale = 4
#			$Kaboom.play()
#			yield(get_tree().create_timer(0.3), "timeout")
#			$Kaboom.speed_scale = 1
#			$Kaboom.visible = false
			if hits > 2:
				$"/root/Global".kaboom("red")
				$Kaboom.visible = true
				$Kaboom.scale.x = 4
				$Kaboom.scale.y = 4
				$Kaboom.play("kaboom")
#				get_tree().get_root().get_node("World").camera_shake()
				$Timer.start()


func _on_Timer_timeout():
	queue_free()
