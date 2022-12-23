extends Button


func _ready() -> void:
	$AnimationPlayer.play("buttonflash")



func _on_START_pressed() -> void:
	$Kaboom.visible = true
	$Kaboom.play("kaboom")
	$"/root/Global".kaboom("red")
