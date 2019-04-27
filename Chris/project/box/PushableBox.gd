extends KinematicBody2D

var GRAVITY  = 10

var velocity = Vector2(0,0) #used to calculate movment
var speed = 100#how fast

func _ready():
	pass 
	
func _physics_process(delta):
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity)



func _on_left_body_entered(body):
	if body.is_in_group("player"):
		velocity.x = speed


func _on_right_body_entered(body):
	if body.is_in_group("player"):
		velocity.x = -speed
