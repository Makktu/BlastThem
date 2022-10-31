extends Node2D

var turn_one = true

var row_instance

var blown_up = false

onready var dynamic_row = preload("res://Scenes/DynamicRow.tscn")

var visible_rows = []

func _ready() -> void:
	add_row()
	

func add_row():
	row_instance = dynamic_row.instance()
	add_child(row_instance)
	# add the newly created row to the all-rows array
	visible_rows.append(row_instance)

		
func move_down():
	# move everything down
	for n in visible_rows:
		n.position.y += 62
	add_row()
	if blown_up:
		blown_up = false
#	$RowBoom.play()

func blow_shit_up():
	var blown_up = visible_rows[0]
	blown_up.queue_free()
	blown_up = true
	visible_rows.remove(0)
				
func _unhandled_input(event):
	if Input.is_action_pressed("ui_cancel"):
		if !blown_up:
			blow_shit_up()

