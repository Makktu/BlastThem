extends KinematicBody2D

export var speed: float = 1200

var current_pos_x
var current_pos_y
var x_count = 0
var y_count = 0

var rebounding = false

var local_angle

var velocity = Vector2(0, speed)

var increased_speed = false

var stuck_counter = 0


func _ready() -> void:
	velocity = velocity.rotated(deg2rad(global_rotation_degrees))
	local_angle = $"/root/Global".laser_angle
	$BlipNoise.play()
	$"/root/Global".laser_fired = true


func _physics_process(delta: float) -> void:
	if $Timer.is_stopped():
		$Timer.start()
	if current_pos_x == position.x and current_pos_y == position.y:
		stuck_counter += 1
		if stuck_counter >= 100:
			queue_free()
			stuck_counter = 0
	stuck_counter = 0
	current_pos_x = position.x
	current_pos_y = position.y
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
		if collision_info.collider.name.left(12) == "SpeedBooster":
			$Timer.stop()
	

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("ui_down"):
		$"/root/Global".laser_fired = false
		$"/root/Global".laser_angle = 0
		queue_free()


func _on_VisibilityNotifier2D_screen_exited() -> void:
	$"/root/Global".new_shot += 1	
	if $"/root/Global".new_shot >= $"/root/Global".balls_allowed:
#		if $"/root/Global".flag_one:
#			$"/root/Global".flag_one = false
		$"/root/Global".laser_fired = false
		$"/root/Global".balls_allowed = 5
#		$"/root/Global".all_balls_gone = true
		if !$"/root/Global".moved_down:
			get_parent().move_down()
			if $"/root/Global".player_score > 800:
				get_parent().move_down()
#			if $"/root/Global".balls_boosted:
#				get_parent().move_down()
			if $"/root/Global".player_score > 1200 and !$"/root/Global".balls_boosted:
				get_parent().move_down()
			$"/root/Global".moved_down = true
			$"/root/Global".balls_allowed = 5
			$"/root/Global".shoot_delay = 0.3
#			$"/root/Global".laser_fired = false
		rebounding = false
		$"/root/Global".new_shot = 0
	queue_free()


func _on_Timer_timeout():
	queue_free()
