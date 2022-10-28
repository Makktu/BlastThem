extends KinematicBody2D

export var speed: float = 600

var local_angle

var velocity = Vector2()

#export (int) var dir


var rebounding = false

func _ready() -> void:
	local_angle = $"/root/Global".laser_angle
	local_angle += PI	
	velocity = Vector2(local_angle * speed, 200)
	print(local_angle)
#	$LaserEffect.play()

func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(velocity * delta)
	
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
#		velocity.x *= 0.9
#		velocity.y *= 0.9
	

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
	
