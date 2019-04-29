extends Area2D

signal unlock_door #Sends signal to unlock linked door

export (NodePath) var door_link

func _ready():
	if door_link != null:
		self.connect("unlock_door", get_node(door_link), "unlock")

func _on_Key_body_entered(body):
	if body.is_in_group("player"): #If the player hits the key
		emit_signal("unlock_door") #Emit signal to unlock linked door
		queue_free() #delete