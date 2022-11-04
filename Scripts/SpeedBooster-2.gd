extends StaticBody2D

var hits = 0
var box_scale = Vector2()

#func _ready():
#	$Box/AnimationPlayer.play("rotate")

func _on_Area2D_body_entered(body: Node) -> void:
		if "Laser" in body.name or "Booster-2" in body.name:
			print(body.name)
			$"/root/Global".kaboom()
			hits += 1
			scale.x -= 0.1
			scale.y -= 0.1
			if hits > 2:
				$"/root/Global".kaboom("red")
				$Kaboom.visible = true
				$Kaboom.scale.x = 4
				$Kaboom.scale.y = 4
				$Kaboom.play("kaboom")
				$Timer.start()


func _on_Timer_timeout():
	queue_free()
