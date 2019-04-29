extends RigidBody2D

var collectable = false
var distance

func _ready():
	pass # Replace with function body.

func _process(delta):
	#keeps the coin from rotating
	rotation_degrees = 0
	#gets all collisions
	for object in get_colliding_bodies():
		#prints all colliders
		##print(object.name)
		
		#checks if collider is in the player group AND if the coin can be collected
		if object.is_in_group("player") && collectable == true:
			#adds to the player's coin count, scales the player, and deletes the coin
			if object.coin_count < object.max_coins:
				object.coin_count += 1
				object.scale_tween()
				queue_free()

#projectile functionality
func setup(mpos,pos, rot = 0):
	#sets the position and the trajectory angle
	position = pos
	rotation = rot + 90
	#gets the distance between the starting position and the mouse position
	distance = mpos.distance_to(pos)
	#sets the linear velocity based on the distance, and rotates it
	linear_velocity = Vector2(-distance * 1.4,-distance * 1.4).rotated(rotation) 

func _on_collision_timer_timeout():
	#makes the coin collectable
	collectable = true
	remove_collision_exception_with(get_parent().get_node("player"))


func _on_despawn_timer_timeout():
	$Tween.interpolate_property($Sprite, "modulate:a", 1, 0.1, 2,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()


func _on_Tween_tween_completed(object, key):
	queue_free()
