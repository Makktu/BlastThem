extends KinematicBody2D

const laser_beam = preload("res://Scenes/Laser.tscn")

func get_input():	
	if Input.is_action_pressed("ui_left"):
		if $Arrow.rotation_degrees > -160:
			$Arrow.rotation_degrees -= 1	
		
	if Input.is_action_pressed("ui_right"):
		if $Arrow.rotation_degrees < -15:
			$Arrow.rotation_degrees += 1
			
	if Input.is_action_pressed("ui_up"):
		shoot()


	
func _physics_process(delta: float) -> void:
	get_input()
	
func shoot():
#	print($Arrow.rotation_degrees)
	var laser_path = laser_beam.instance()	
#	laser_path.rotation = -$Arrow.rotation_degrees

	add_child(laser_path)
	
	laser_path.position = $Position2D.global_position


