extends KinematicBody2D

export var speed: float = 1200

#
#var speed = Vector2(max(move_speed, direction_distance), 0)
#speed = speed.rotated(global_rotation)
#move_and_slide(speed)



var rebounding = false

var local_angle

var velocity = Vector2(0, speed)

var increased_speed = false


func _ready() -> void:
	velocity = velocity.rotated(deg2rad(global_rotation_degrees))
	local_angle = $"/root/Global".laser_angle
	print(">>>>>>>>>>>>> ", global_rotation_degrees, " / ", local_angle)


func _physics_process(delta: float) -> void:
#	velocity = velocity.rotated(global_rotation_degrees)
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
		print(collision_info.collider.name)
		if collision_info.collider.name == "SpeedBooster" and !increased_speed:
#			velocity += Vector2(0, speed + 1000)
			increased_speed = true
			print("HIT THE THING")
			

#	apply_impulse(Vector2(), Vector2(speed, speed).rotated(local_angle))		
	if Input.is_action_pressed("ui_accept"):
		print(global_rotation_degrees)
	

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
