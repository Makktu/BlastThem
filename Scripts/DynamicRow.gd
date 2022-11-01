extends Node2D

onready var obstacle_box = preload("res://Scenes/SpeedBooster.tscn")
onready var alt_box = preload("res://Scenes/AnotherBox.tscn")
#onready var alt_box = preload("res://Scenes/AltBox.tscn")

var choices = [obstacle_box, alt_box]

var rng = RandomNumberGenerator.new()

func _ready():
	create_boxes()
	
func create_boxes():	
	var box_x = 0
	var box_y = 5

	for n in 10:
		rng.randomize()
		var this_random_number = rng.randf_range(1, 10)
		var new_box
		if this_random_number < $"/root/Global".difficulty:
			var which_box = rng.randf_range(1, 4)
			if which_box < 2:
				new_box = alt_box.instance()
			else:
				new_box = obstacle_box.instance()	
			new_box.position = Vector2(box_x, box_y)
			add_child(new_box)
#			print("Added 1 box at ", box_x, box_y)
		box_x += 64

