extends Node2D


var value = "0"
var global_best_score = 0

func _ready():
	pass
	
	
	
	
func update_score(score):
	$PlayerScore.text = str(score)

func update_best_score(score):
	$BestScore/BestValue.text = str(score)
