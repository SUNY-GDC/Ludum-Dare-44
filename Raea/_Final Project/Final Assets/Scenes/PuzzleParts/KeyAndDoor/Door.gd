extends StaticBody2D

signal level_over

export (bool) var open = false

func unlock(): #This allows the door to be opened
	open = true

func _on_PlayerDetection_body_entered(body):
	#If the player hits the door and it's open
	if body.is_in_group("player") and open:
		print("Level done")
		emit_signal("level_over")
		queue_free() #Delete
