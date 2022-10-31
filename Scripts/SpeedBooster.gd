extends StaticBody2D

var hits = 0
var box_scale = Vector2()

func _on_Area2D_body_entered(body: Node) -> void:
#		if body.name == "PlayerNode":
#			$"/root/Global".game_over()
#		if body.name == "Laser":
#		if body.name != "Laser":
#			return
		hits += 1
		scale.x -= 0.2
		scale.y -= 0.2
		if hits > 3:
			$"/root/Global".kaboom()
			yield(get_tree().create_timer(0.2), "timeout")
			queue_free()
