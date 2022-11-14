extends Node2D

#
#var value = "0"
#var global_best_score = 0

func _ready() -> void:
	if $"/root/Global".best_score > 0:
		update_best_score($"/root/Global".best_score)
		

func update_score(score):
	$PlayerScore.text = str(score)

func update_best_score(score):
	$BestScore/BestValue.text = str($"/root/Global".best_score)
