extends Node2D

var turn_one = true

var shake_amount = 1

var row_instance

var blown_up = false

onready var dynamic_row = preload("res://Scenes/DynamicRow.tscn")

var visible_rows = []
var local_score = 0

var throb_animation_playing = false
var back_to_basic_color = false



func _ready() -> void:
	for n in 4:
		add_row()
		move_down()
	$"/root/Global".balls_boosted = false
	$"/root/Global".balls_allowed = 5
	$"/root/Global".first_run = false
	local_score = $"/root/Global".player_score

	

func add_row():
	row_instance = dynamic_row.instance()
	add_child(row_instance)
	# add the newly created row to the all-rows array
	visible_rows.append(row_instance)

		
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
#	print(visible_rows.size())
#	if visible_rows.size() > 10:
#		$BGHolder/AnimationPlayer.play("second")
#	elif visible_rows.size() <= 10:
#		$BGHolder/AnimationPlayer.play("first")

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
			$"/root/Global".best_score_beaten = true
			
func _process(delta):
	check_screen_throb()


func check_screen_throb():
	if $"/root/Global".flag_bomb and !throb_animation_playing:
		$BGHolder/AnimationPlayer.play("first")
		throb_animation_playing = true
		back_to_basic_color = false
		
	if $"/root/Global".flag_diamond and !throb_animation_playing:
		$BGHolder/AnimationPlayer.play("second")
		throb_animation_playing = true
		back_to_basic_color = false
		
	if !$"/root/Global".flag_bomb and !$"/root/Global".flag_diamond and !back_to_basic_color:
		$BGHolder/AnimationPlayer.play("zero")
		back_to_basic_color = true
		throb_animation_playing = false
