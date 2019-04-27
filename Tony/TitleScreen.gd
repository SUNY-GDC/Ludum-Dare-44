extends Node

var credits_pos = Vector2()
var quit_pos = Vector2()

func _ready():
	credits_pos = $CreditsButton/Label.rect_position
	quit_pos = $QuitButton/Label.rect_position

func _on_CreditsButton_pressed():
	pass

func _on_CreditsButton_mouse_entered():
	$CreditsButton/Label.rect_position = Vector2(185, 75)

func _on_CreditsButton_mouse_exited():
	$CreditsButton/Label.rect_position = credits_pos

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_QuitButton_mouse_entered():
	$QuitButton/Label.rect_position = Vector2(325, 100)


func _on_QuitButton_mouse_exited():
	$QuitButton/Label.rect_position = quit_pos
