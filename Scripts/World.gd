extends Node2D

var turn_one = true

var shake_amount = 1

var row_instance

var blown_up = false

onready var dynamic_row = preload("res://Scenes/DynamicRow.tscn")

var visible_rows = []
var local_score = 0



func _ready() -> void:
	for n in 2:
		add_row()
		move_down()
	$"/root/Global".first_run = false
	local_score = $"/root/Global".player_score

	

func add_row():
	row_instance = dynamic_row.instance()
	add_child(row_instance)
	# add the newly created row to the all-rows array
	visible_rows.append(row_instance)
	print(visible_rows.size())

		
func move_down():
	# move everything down
	for n in visible_rows:
		for p in 10:
			yield(get_tree().create_timer(0.00005), "timeout")
			n.position.y += 6
	# add a new row
	add_row()
	if blown_up:
		blown_up = false
	$RowBoom.play()

func blow_them_up():
	var blown_up = visible_rows[0]
	blown_up.queue_free()
	blown_up = true
	visible_rows.remove(0)
				
func _unhandled_input(event):
	if Input.is_action_pressed("ui_cancel"):
		if !blown_up:
			blow_them_up()

func _physics_process(delta):
	if $"/root/Global".player_score != local_score:
		local_score = $"/root/Global".player_score
		$Score.update_score(local_score)
		if local_score > $"/root/Global".best_score:
			$"/root/Global".best_score = local_score
			$Score.update_best_score(local_score)
