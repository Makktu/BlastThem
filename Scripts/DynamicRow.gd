extends Node2D

onready var obstacle_box = preload("res://Scenes/SpeedBooster.tscn")
onready var alt_box = preload("res://Scenes/SpeedBooster-2.tscn")
onready var redbrick = preload("res://Scenes/redbrick.tscn")
onready var diamond = preload("res://Scenes/diamond.tscn")

var rng = RandomNumberGenerator.new()

func _ready():
	create_boxes()
	
	
func create_boxes():	
	var box_x = 0
	var box_y = 100
	var full_row = false
	
	rng.randomize()
	var full_row_or_not = rng.randf_range(1, 10)
	if full_row_or_not > 7:
		full_row = true	

	for n in 10:
		rng.randomize()
		var new_box
		var which_box = rng.randf_range(1, 20)
		var box_filled = false
		if which_box > 18:
			new_box = diamond.instance()
			box_filled = true
		elif which_box > 16 or full_row:
			new_box = redbrick.instance()
			box_filled = true
		elif which_box < $"/root/Global".bomb_likelihood and !box_filled:
			new_box = alt_box.instance()
			box_filled = true
		else:
			if !box_filled:
				new_box = obstacle_box.instance()	
		new_box.position = Vector2(box_x, box_y)
		add_child(new_box)
		box_x += 64
		box_filled = false
		
#	$"/root/Global".turn += 1
#	if $"/root/Global".turn == 5:
#		$"/root/Global".difficulty += 1
#		$"/root/Global".turn = 1

