extends Area2D

export (PackedScene) var scene
export (int, "Body", "Slot") var collision_type #This will tell the game what type of coin collision will spawn a key
export (NodePath) var connected_to #This is used ONLY if this spawns a key that needs to be connected to a door
export (int) var coins_needed

func _ready():
	if collision_type == 0: #If it's a body hit that counts
		self.connect("body_entered", self, "vending_machine_hit") #Connect respective collider to the function
	if collision_type == 1: #If it's a coin slot hit that counts
		$CoinSlot.connect("body_entered", self, "vending_machine_hit")
	
	$RequiredCoinLabel.text = str(coins_needed)

#This function handles body collisions
func vending_machine_hit(body):
	if body.is_in_group("coins"): #If the body is a coin
		body.queue_free() #Destroy the coin
		coins_needed -= 1
		$RequiredCoinLabel.text = str(coins_needed)
		
		if coins_needed == 0:
			spawn_scene() #Spawn a key

#This function spawns in a key
func spawn_scene():
	var k = scene.instance()
	if connected_to != null:
		k.connect("unlock_door", get_node(connected_to), "unlock")
	add_child(k)
	k.position = $KeySpawn.position
	print("SPAWN")


