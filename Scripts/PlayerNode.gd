extends KinematicBody2D

const pl_laser_beam = preload("res://Scenes/Laser.tscn")


func get_input():	
	if Input.is_action_pressed("ui_left"):
		if $Arrow.rotation_degrees > -160:
			$Arrow.rotation_degrees -= 1	
		
	if Input.is_action_pressed("ui_right"):
		if $Arrow.rotation_degrees < -15:
			$Arrow.rotation_degrees += 1
			
	if Input.is_action_pressed("ui_up"):
		if !$"/root/Global".laser_fired:
			$"/root/Global".laser_fired = true
			shoot()

	
func _physics_process(delta: float) -> void:
	get_input()
	
func shoot():
	print("SHOT!")
	var laser_instance = pl_laser_beam.instance()
	get_tree().current_scene.add_child(laser_instance)
