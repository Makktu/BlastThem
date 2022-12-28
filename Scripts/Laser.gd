extends KinematicBody2D

export var speed: float = 1200
var x_count = 0
var y_count = 0
var rebounding = false
var local_angle
var velocity = Vector2(0, speed)
var increased_speed = false

func _ready() -> void:
	velocity = velocity.rotated(deg2rad(global_rotation_degrees))
	local_angle = $"/root/Global".laser_angle
	$BlipNoise.play()
	$"/root/Global".laser_fired = true
	$LifetimeTimer.start()


func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
	

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_pressed("ui_down"):
		$"/root/Global".laser_fired = false
		$"/root/Global".laser_angle = 0
		queue_free()


func _on_VisibilityNotifier2D_screen_exited() -> void:
	$"/root/Global".new_shot += 1	
	if $"/root/Global".new_shot >= $"/root/Global".balls_allowed:
		$"/root/Global".laser_fired = false
		$"/root/Global".balls_allowed = 5
		if !$"/root/Global".moved_down:
			get_parent().move_down()
			if $"/root/Global".player_score > 600:
				get_parent().move_down()
			if $"/root/Global".player_score > 1100 and !$"/root/Global".balls_boosted:
				get_parent().move_down()
			$"/root/Global".moved_down = true
			$"/root/Global".balls_allowed = 5
			$"/root/Global".shoot_delay = 0.3

		rebounding = false
		$"/root/Global".new_shot = 0
	queue_free()


func _on_LifetimeTimer_timeout():
	queue_free()
