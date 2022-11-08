extends KinematicBody2D

const pl_laser_beam = preload("res://Scenes/Laser.tscn")


var shoot_delay = 0.3
var boosted_shoot_delay = 0.1

func get_input():	
	if Input.is_action_pressed("ui_left"):
		if rotation_degrees > -80:
			rotation_degrees -= 1
		
	if Input.is_action_pressed("ui_right"):
		if rotation_degrees < 80:
			rotation_degrees += 1	
			
	if Input.is_action_pressed("ui_up"):
		print($"/root/Global".laser_fired)
		if !$"/root/Global".laser_fired:
			$"/root/Global".laser_fired = true
			$"/root/Global".moved_down = false
			shoot()

	
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
