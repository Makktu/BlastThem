extends KinematicBody2D

export(int) var SPEED: int = 100

var laser_is_fired = false

func _ready() -> void:
	pass
	screensize = get_viewport_rect().size
	
func _physics_process(delta: float) -> void:
	if laser_is_fired:
		move_laser(delta)
	
	
	if Input.is_action_pressed("ui_left"):
		print(player_arrowtip.position)
		if $Arrow.rotation_degrees > -160:
			$Arrow.rotation_degrees -= 1
	
		
	if Input.is_action_pressed("ui_right"):
		if $Arrow.rotation_degrees < -15:
			$Arrow.rotation_degrees += 1
			
	if Input.is_action_pressed("ui_up"):
		laser_is_fired = true

		
func move_laser(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += SPEED * direction * delta
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	print("OVER")
