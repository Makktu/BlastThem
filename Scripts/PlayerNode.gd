extends KinematicBody2D

const pl_laser_beam = preload("res://Scenes/Laser.tscn")

var ball_increaser = 1

func get_input():	
	if Input.is_action_pressed("ui_left"):
		if rotation_degrees > -80:
			rotation_degrees -= 1
		
	if Input.is_action_pressed("ui_right"):
		if rotation_degrees < 80:
			rotation_degrees += 1	
			
	if Input.is_action_pressed("ui_up"):
		if !$"/root/Global".laser_fired:
			$"/root/Global".laser_fired = true
			shoot()

	
func _physics_process(delta: float) -> void:
	get_input()
	
	
func shoot():
#	self.visible = false

	for n in $"/root/Global".difficulty * ball_increaser:

		# create local instance of the laser – **this is not on-screen yet**
		var laser_instance = pl_laser_beam.instance()
		
		# put the laser on the tip of the arrow
		laser_instance.global_position = $Arrow/Position2D.global_position
		
		# rotate the laser to match the arrow 
		laser_instance.global_rotation_degrees = rotation_degrees
		$"/root/Global".laser_angle = global_rotation_degrees
		
		# now the laser is added to the scene at the correct place and at the correct rotation angle
	#	get_tree().root.get_child(0).add_child(laser_instance)
		get_parent().add_child(laser_instance)
		yield(get_tree().create_timer(0.075), "timeout")

	ball_increaser += 1
