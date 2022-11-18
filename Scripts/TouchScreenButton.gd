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

	if swipe.y >= -swipe_margin and swipe.y <= swipe_margin and swipe.x >= swipe_margin:
		swipe_direction = Vector2.RIGHT
	if swipe.y >= -swipe_margin and swipe.y <= swipe_margin and swipe.x <= -swipe_margin:
		swipe_direction = Vector2.LEFT
		
	print(swipe_direction.x)
		
#	if on_area and swipe_direction.x == 0:
#		$"/root/Global".touch_counter += 0.05
#		if $"/root/Global".touch_counter > 0.2:
#			$"/root/Global".screen_is_touched = true
#			$"/root/Global".touch_counter = 0
#			return null
#
#	$"/root/Global".screen_is_touched = false
		
	if on_area:
		return swipe_direction
		
func _on_self_pressed():
	on_area = true
	
func _on_self_released():
	on_area = false
