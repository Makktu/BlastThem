extends KinematicBody2D

const pl_laser_beam = preload("res://Scenes/Laser.tscn")

onready var Swipe = $"../SwipeScreenButton"

var finger_on = false
var boosted_shoot_delay = 0.1

var is_drag = false
var is_touch = false

# initialise swipe control variables
#var swipe_up = false
#var swipe_down = false
var swipe_left = false
var swipe_right = false

#var swipe_down_released = false
#var swipe_up_released = false
var swipe_left_released = false
var swipe_right_released = false

func _ready() -> void:
	$"/root/Global".laser_fired = false
	$"/root/Global".balls_boosted = false
	$"/root/Global".balls_allowed = 5
	$"/root/Global".shoot_delay = 0.3
	$"/root/Global".diamond_on_screen = false

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
		is_drag = true
		if Swipe.get_swipe_direction(event.relative, 5) == Vector2.LEFT and is_drag:
			if swipe_left:
				swipe_left = false
			swipe_right = true

		if Swipe.get_swipe_direction(event.relative, 5) == Vector2.RIGHT and is_drag:
			if swipe_right:
				swipe_right = false
			swipe_left = true

	if Swipe.on_area == false && swipe_left == true:
		is_drag = false
		swipe_left_released = true
		finger_on = false
		swipe_left = false
	if Swipe.on_area == false && swipe_right == true:
		is_drag = false
		swipe_right_released = true
		finger_on = false
		swipe_right = false	
		
	if event is InputEventScreenTouch:
		if event.pressed:
			is_touch = true
			shoot()
			print("TAP")
		
#	if event is InputEventScreenTouch and event != InputEventScreenDrag and event.is_pressed():
#		shoot()
#		print("Hello")

		


	
func _physics_process(delta: float) -> void:
	if $"/root/Global".balls_boosted:		
		$AnimationPlayer.play("balls_boosted")
	if !$"/root/Global".balls_boosted:
		$AnimationPlayer.stop()
	get_input()
	
	
func shoot():
#	self.visible = false
	if $"/root/Global".balls_boosted:
		$"/root/Global".balls_allowed = 15
		$"/root/Global".shoot_delay = 0.1
		$"/root/Global".balls_boosted = false
	
	if $"/root/Global".diamond_shot:
		$"/root/Global".balls_allowed = 40
		$"/root/Global".shoot_delay = 0.05
		$"/root/Global".diamond_shot = false
		
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
