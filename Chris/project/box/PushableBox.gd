extends KinematicBody2D

#this code must be in player
#	for idx in range(get_slide_count()):
#		var col = get_slide_collision(idx)
#		print(col.collider)
#		if col.collider.has_method("push"):
#			if col.normal.y == 0:
#				col.collider.push(sign(velocity.x) * 20)


#this is the gravity
var GRAVITY  = 10

var velocity = Vector2(0,0) #used to calculate movment
var speed = 100#how fast

func _ready():
	pass 
	
func _physics_process(delta):
	if !is_on_floor():
		velocity.y += GRAVITY
	velocity = move_and_slide(velocity, Vector2(0,-1))

#pushes she box
func push(vecx):
	velocity.x = vecx