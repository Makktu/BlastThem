extends Node2D


func _ready() -> void:
	pass


func _on_START_pressed() -> void:
	get_tree().change_scene("res://Scenes/World.tscn")
