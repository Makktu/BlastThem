extends Area2D

export var speed: float = 300


func _physics_process(delta: float) -> void:
	position.y -= speed * delta


func _on_VisibilityNotifier2D_screen_exited() -> void:
	print("GONE")
	$"/root/Global".laser_fired = false
	queue_free()
	
