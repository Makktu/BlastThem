extends KinematicBody2D

export var speed: float = 1000

var velocity = Vector2()

var rebounding = false

var local_angle


func _ready() -> void:
	rotation_degrees = $"/root/Global".laser_angle
	velocity = Vector2(speed, speed).rotated(rotation)


func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
	

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("ui_down"):
		$"/root/Global".laser_fired = false
		$"/root/Global".laser_angle = 0
		queue_free()


func _on_VisibilityNotifier2D_screen_exited() -> void:
	print("GONE")
	$"/root/Global".laser_fired = false
	rebounding = false
	queue_free()
