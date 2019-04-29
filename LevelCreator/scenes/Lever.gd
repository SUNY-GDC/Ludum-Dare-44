extends Area2D

# This is the script for the lever puzzle piece
# It is setup for multiple levers in one lever

signal lever_activated # the signal that is emitted when lever is triggered
signal lever_deactivated # the signal that is emitted when something triggering the lever leaves

# The route to the lever images, textures[0] should be lever pushed down
#                                textures[1] should be lever not pushed down
var textures = [load("res://scenes/lever_active.png"), load("res://scenes/lever_unactive.png")]

export (int) var lever_id = 0 # the id of the lever so you can have multiple levers in a level

# When a body enters the lever
func _on_Lever_body_entered(body):
	if body.is_in_group("coins"): # if its a coin
		emit_signal("lever_activated", lever_id) # signal out the lever id
		$Sprite.texture = textures[0]
#		$AudioStreamPlayer2D.playing = true     ### Uncomment when we import a activation sound

# When a body leaves the lever
func _on_Lever_body_exited(body):
	if body.is_in_group("coins"): # if its a coin
		emit_signal("lever_deactivated", lever_id) # signal out the lever id
		$Sprite.texture = textures[1]
