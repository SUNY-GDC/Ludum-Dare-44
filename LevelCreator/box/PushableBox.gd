extends KinematicBody2D

#this code must be in player
#	for idx in range(get_slide_count()):
#		var col = get_slide_collision(idx)
#		if col.collider.has_method("push"):
#			if col.normal.y == 0:
#				col.collider.push(-col.normal.x * 75)
#


var playback = 0

#this is the gravity
var GRAVITY  = 10

var velocity = Vector2(0,0) #used to calculate movment
var speed = 100#how fast

func _ready():
	pass 
	
func _physics_process(delta):
	
	if !is_on_floor():
		velocity.y += GRAVITY
	else:
		velocity.y = 0
		
	velocity = move_and_slide(velocity, Vector2(0,-1))
	velocity.x = lerp(velocity.x, 0 , 0.4)
	
func _process(delta):
	if velocity.x <= 0.1 and velocity.x >= -0.1:
		$AudioStreamPlayer.volume_db -= .5
		if $AudioStreamPlayer.volume_db > -50:
			yield(get_tree().create_timer(0.05),"timeout")
		else:
			$AudioStreamPlayer.stop()
			
			
#pushes she box
#add the players push speed
func push(vecx):
	velocity.x = vecx
	print(vecx)
	if $AudioStreamPlayer.playing != true:
		
		$AudioStreamPlayer.play(playback)
	$AudioStreamPlayer.volume_db = lerp($AudioStreamPlayer.volume_db, -18 , 1)

	playback = $AudioStreamPlayer.get_playback_position()