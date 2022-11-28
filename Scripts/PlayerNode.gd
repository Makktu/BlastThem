extends KinematicBody2D

const pl_laser_beam = preload("res://Scenes/Laser.tscn")

onready var Swipe = $"../SwipeScreenButton"

var boosted_shoot_delay = 0.1

# initialise swipe control variables
var swipe_left = false
var swipe_right = false
var swipe_left_released = false
var swipe_right_released = false

var touch_timer = 0
var tap_shoot = false
var last_position

var swipe_speed



func _ready() -> void:
	$"/root/Global".first_bomb = false
	$"/root/Global".laser_fired = false
	$"/root/Global".balls_boosted = false
	$"/root/Global".balls_allowed = 5
	$"/root/Global".shoot_delay = 0.3
	$"/root/Global".diamond_on_screen = false
	$"/root/Global".player_score = 0
	last_position = 0
	swipe_speed = 0
	

func get_input():
	print(rotation_degrees)	
	if $"/root/Global".game_is_over:
		return
		
	if Input.is_action_pressed("ui_left") or swipe_left:
		if $"/root/Global".finger_moving or $"/root/Global".control_scheme == 0:
			if rotation_degrees > 100:
				rotation_degrees -= 3
			# 	revisit all this when game design done
#			if swipe_speed > 200:
#				rotation_degrees -= 2
#			if swipe_speed > 300:
#				rotation_degrees -= 3
		
	if Input.is_action_pressed("ui_right") or swipe_right:
		if $"/root/Global".finger_moving or $"/root/Global".control_scheme == 0:
			if rotation_degrees < 260:
				rotation_degrees += 3
#			if swipe_speed > 200:
#				rotation_degrees += 2
#			if swipe_speed > 300:
#				rotation_degrees += 3	
			
	if Input.is_action_pressed("ui_up") or tap_shoot:
		if !$"/root/Global".laser_fired:
			$"/root/Global".laser_fired = true
			$"/root/Global".moved_down = false
			swipe_left_released = false
			swipe_right_released = false
			swipe_right = false
			swipe_left = false
			shoot()
			

func _input(event):
	if event is InputEventScreenTouch:
		$"/root/Global".screen_is_touched = !$"/root/Global".screen_is_touched
		print("TOUCH", $"/root/Global".screen_is_touched)
		# use this to resolve the big problem
		if $"/root/Global".screen_is_touched:
			# start the timer
			touch_timer = 0.75
		else:
			if touch_timer > 0:
				tap_shoot = true
				touch_timer = 0
	
#	if last_position == event.position.x:
#		finger_timer = 0
#	else:
#		last_position = event.position.x
#		$"/root/Global".finger_moving = true
	
	
	if event is InputEventScreenDrag:
		
		$"/root/Global".finger_moving = true
		
		if Swipe.get_swipe_direction(event.relative, 5) == Vector2.LEFT:
			swipe_speed = event.speed.x
			print(swipe_speed)
			if swipe_left:
				swipe_left = false
			swipe_right = true

		if Swipe.get_swipe_direction(event.relative, 5) == Vector2.RIGHT:
			swipe_speed = event.speed.x
			print(swipe_speed)
			if swipe_right:
				swipe_right = false
			swipe_left = true
			
		if !Swipe.get_swipe_direction(event.relative, 5):
			$"/root/Global".finger_moving = false
			
			

	if Swipe.on_area == false && swipe_left == true:
		swipe_left_released = true
		swipe_left = false

	if Swipe.on_area == false && swipe_right == true:
		swipe_right_released = true
		swipe_right = false	
		
	
func _physics_process(delta: float) -> void:
	if $"/root/Global".balls_boosted:		
		$AnimationPlayer.play("balls_boosted")
	if !$"/root/Global".balls_boosted:
		$AnimationPlayer.stop()
	get_input()
	
	
func _process(delta: float) -> void:
	if touch_timer > 0:
		touch_timer -= 0.05
			
	
func shoot():
	if $"/root/Global".balls_boosted:
		$"/root/Global".balls_allowed = 15
		$"/root/Global".shoot_delay = 0.1
		$"/root/Global".balls_boosted = false
	
	if $"/root/Global".diamond_shot:
		$"/root/Global".balls_allowed = 40
		$"/root/Global".shoot_delay = 0.05
		$"/root/Global".diamond_shot = false
		
	if tap_shoot:
		tap_shoot = false
		
	for n in $"/root/Global".balls_allowed:

		# create local instance of the laser – **this is not on-screen yet**
		var laser_instance = pl_laser_beam.instance()
		
		# put the laser on the tip of the arrow
		laser_instance.global_position = $Arrow/Position2D.global_position
		
		# rotate the laser to match the arrow 
		laser_instance.global_rotation_degrees = rotation_degrees
		$"/root/Global".laser_angle = global_rotation_degrees
		
		# now the laser is added to the scene at the correct place and at the correct rotation angle
		get_parent().add_child(laser_instance)
		yield(get_tree().create_timer($"/root/Global".shoot_delay), "timeout")
