extends Sprite

export(int) var SPEED: int = 100

var laser_is_fired = false

var screensize

func _ready() -> void:
	screensize = get_viewport_rect().size
	print(screensize)
	
func _physics_process(delta: float) -> void:
	print($GodotSprite.position)
	if laser_is_fired:
		move_laser(delta)
		if position.x < screensize.x - screensize.x or position.x > screensize.x:
			print("CHANGE_DIR")
	
	
	if Input.is_action_pressed("ui_left"):
#		print(player_arrowtip.position)
		if rotation_degrees > -160:
			rotation_degrees -= 1
	
		
	if Input.is_action_pressed("ui_right"):
		if rotation_degrees < -15:
			rotation_degrees += 1
			
	if Input.is_action_pressed("ui_up"):
		laser_is_fired = true

		
func move_laser(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += SPEED * direction * delta
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	print("OVER")
