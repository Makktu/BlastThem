extends TouchScreenButton

class_name SwipeScreenButton

var on_area = false

var last_swipe_x = 0
var last_swipe_y = 0

func _ready():
# warning-ignore:return_value_discarded
	self.connect("pressed", self, "_on_self_pressed")
# warning-ignore:return_value_discarded
	self.connect("released", self, "_on_self_released")
	
func get_swipe_direction(swipe, swipe_margin):

	var swipe_direction = Vector2.ZERO
	
	print(swipe.x, swipe.y)
	
#	if swipe.x == last_swipe_x and swipe.y == last_swipe_y:
#		$"/root/Global".screen_is_touched = true
#		return
#
#	last_swipe_x = swipe.x
#	last_swipe_y = swipe.y	
#	$"/root/Global".screen_is_touched = false

	if swipe.y >= -swipe_margin and swipe.y <= swipe_margin and swipe.x >= swipe_margin:
		swipe_direction = Vector2.RIGHT
	if swipe.y >= -swipe_margin and swipe.y <= swipe_margin and swipe.x <= -swipe_margin:
		swipe_direction = Vector2.LEFT
		
	if on_area:
		return swipe_direction
		
func _on_self_pressed():
	on_area = true
	
func _on_self_released():
	on_area = false
