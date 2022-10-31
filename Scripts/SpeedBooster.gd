extends StaticBody2D


func _on_Area2D_body_entered(body: Node) -> void:
#		if body.name == "PlayerNode":
#			$"/root/Global".game_over()
		if body.name == "Laser":
			queue_free()
