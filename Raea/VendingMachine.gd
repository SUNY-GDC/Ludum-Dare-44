extends Area2D

export (PackedScene) var key
export (int, "Body", "Slot") var collision_type #This will tell the game what type of coin collision will spawn a key

func _ready():
	if collision_type == 0: #If it's a body hit that counts
		self.connect("body_entered", self, "vending_machine_hit") #Connect respective collider to the function
	if collision_type == 1: #If it's a coin slot hit that counts
		$CoinSlot.connect("body_entered", self, "vending_machine_hit")

#This function handles body collisions
func vending_machine_hit(body):
	if body.is_in_group("coins"): #If the body is a coin
		body.queue_free() #Destroy the coin
		spawn_key() #Spawn a key

#This function spawns in a key
func spawn_key():
	var k = key.instance()
	add_child(k)
	k.position = $KeySpawn.position


