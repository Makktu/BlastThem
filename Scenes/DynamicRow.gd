extends Node2D

onready var obstacle_box = preload("res://Scenes/SpeedBooster.tscn")

var rng = RandomNumberGenerator.new()

func _ready():
	create_boxes()
	
func create_boxes():	
	var box_x = 0
	var box_y = 5

	for n in 11:
		rng.randomize()
		var this_random_number = rng.randf_range(1, 10)
		if this_random_number > $"/root/Global".difficulty + 2:
			var new_box = obstacle_box.instance()	
			new_box.position = Vector2(box_x, box_y)
			add_child(new_box)
#			print("Added 1 box at ", box_x, box_y)
		box_x += 62

