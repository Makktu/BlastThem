extends KinematicBody2D

const pl_laser_beam = preload("res://Scenes/Laser.tscn")


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
	print("SHOT!")
	# create local instance of the laser – **this is not on-screen yet**
	var laser_instance = pl_laser_beam.instance()
	
	# put the laser on the tip of the arrow
	laser_instance.global_position = $Arrow/Position2D.global_position
	
	# rotate the laser to match the arrow (adjusted for the -90 degrees I created it at during setup, that I'm too lazy to rectify – this is all placeholder art anyway for the prototype that this is)
	laser_instance.rotation = rotation_degrees
	$"/root/Global".laser_angle = rotation_degrees
	
	# now the laser is added to the scene at the correct place and at the correct rotation angle
	get_tree().current_scene.add_child(laser_instance)
