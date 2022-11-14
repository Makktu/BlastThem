extends Node2D

onready var obstacle_box = preload("res://Scenes/SpeedBooster.tscn")
onready var alt_box = preload("res://Scenes/SpeedBooster-2.tscn")

var rng = RandomNumberGenerator.new()

func _ready():
	create_boxes()
	
	
func create_boxes():	
	var box_x = 0
	var box_y = 100

	for n in 10:
		rng.randomize()
		var new_box
		var which_box = rng.randf_range(1, 20)
		if which_box < $"/root/Global".bomb_likelihood:
			new_box = alt_box.instance()
		else:
			new_box = obstacle_box.instance()	
		new_box.position = Vector2(box_x, box_y)
		add_child(new_box)
		box_x += 64
		
#	$"/root/Global".turn += 1
#	if $"/root/Global".turn == 5:
#		$"/root/Global".difficulty += 1
#		$"/root/Global".turn = 1

