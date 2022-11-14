extends KinematicBody2D

const pl_laser_beam = preload("res://Scenes/Laser.tscn")

onready var Swipe = $"../SwipeScreenButton"

var finger_moving = false
var shoot_delay = 0.3
var boosted_shoot_delay = 0.1

# initialise swipe control variables
#var swipe_up = false
#var swipe_down = false
var swipe_left = false
var swipe_right = false

#var swipe_down_released = false
#var swipe_up_released = false
var swipe_left_released = false
var swipe_right_released = false

func get_input():	
	if $"/root/Global".game_is_over:
		return
	if Input.is_action_pressed("ui_left") or swipe_left:
		if rotation_degrees > -80:
			rotation_degrees -= 1
		
	if Input.is_action_pressed("ui_right") or swipe_right:
		if rotation_degrees < 80:
			rotation_degrees += 1	
			
	if Input.is_action_pressed("ui_up") or swipe_left_released or swipe_right_released:
		print($"/root/Global".laser_fired)
		if !$"/root/Global".laser_fired:
			$"/root/Global".laser_fired = true
			$"/root/Global".moved_down = false
			swipe_left_released = false
			swipe_right_released = false
			swipe_right = false
			swipe_left = false
			shoot()
			

func _input(event):
#	if event is InputEventScreenTouch and event.is_pressed():
#		print("HOLD....")

		
	if event is InputEventScreenDrag:
#		if event.speed.x < 4:
#			return
#		if Swipe.get_swipe_direction(event.relative, 5) == Vector2.UP:
#			swipe_down = true
#		if Swipe.get_swipe_direction(event.relative, 5) == Vector2.DOWN:
#			swipe_up = true
		if Swipe.get_swipe_direction(event.relative, 5) == Vector2.LEFT:
			if swipe_left:
				swipe_left = false
			swipe_right = true

		if Swipe.get_swipe_direction(event.relative, 5) == Vector2.RIGHT:
			if swipe_right:
				swipe_right = false
			swipe_left = true


#	if Swipe.on_area == false && swipe_down == true:
#		swipe_down_released = true
#		swipe_down = false
#	if Swipe.on_area == false && swipe_up == true:
#		swipe_up_released = true
#		swipe_up = false
	if Swipe.on_area == false && swipe_left == true:
		swipe_left_released = true
		swipe_left = false
	if Swipe.on_area == false && swipe_right == true:
		swipe_right_released = true
		swipe_right = false	
		


	
func _physics_process(delta: float) -> void:
	get_input()
	
	
func shoot():
#	self.visible = false
	var local_balls = 5
	if $"/root/Global".balls_boosted:
		local_balls = 15
		$"/root/Global".balls_allowed = 15
		shoot_delay = 0.1
		
	for n in local_balls:

		# create local instance of the laser – **this is not on-screen yet**
		var laser_instance = pl_laser_beam.instance()
		
		# put the laser on the tip of the arrow
		laser_instance.global_position = $Arrow/Position2D.global_position
		
		# rotate the laser to match the arrow 
		laser_instance.global_rotation_degrees = rotation_degrees
		$"/root/Global".laser_angle = global_rotation_degrees
		
		# now the laser is added to the scene at the correct place and at the correct rotation angle
		get_parent().add_child(laser_instance)
		yield(get_tree().create_timer(shoot_delay), "timeout")
		
	
	
	if $"/root/Global".balls_boosted:
		$"/root/Global".balls_allowed = 5
		$"/root/Global".balls_boosted = false
		local_balls = 5
		shoot_delay = 0.3
