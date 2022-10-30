extends KinematicBody2D

export var speed: float = 1200

var current_pos_x
var current_pos_y
var x_count = 0
var y_count = 0

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
	if current_pos_x == position.x:
		x_count += 1
	if current_pos_y == position.y:
		y_count += 1
		
	if x_count > 3:
		position.x += 10
		x_count = 0
	if y_count > 3:
		position.y -= 10
		y_count = 0
	
	current_pos_x = position.x
	current_pos_y = position.y
#	velocity = velocity.rotated(global_rotation_degrees)
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
		print(collision_info.collider.name)
		if collision_info.collider.name.left(12) == "SpeedBooster" and !increased_speed:
			velocity = Vector2(0, speed + 1000)
			increased_speed = true
			$BlipNoise.play()
	

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("ui_down"):
		$"/root/Global".laser_fired = false
		$"/root/Global".laser_angle = 0
		queue_free()


func _on_VisibilityNotifier2D_screen_exited() -> void:
	print("GONE")
	$"/root/Global".laser_fired = false
#	$"/root/Global".move_obstacles("down")
	get_parent().move_down()
	rebounding = false
	queue_free()
