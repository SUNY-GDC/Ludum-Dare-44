extends KinematicBody2D

var velocity = Vector2(0,0)
export (int) var speed = 150


func _ready():
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	else:
		velocity.y += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	elif Input.is_action_pressed("ui_right"):
		velocity.x += 1
	else:
		velocity.x = 0

	velocity * speed

func _physics_process(delta):
	velocity = move_and_slide(velocity,Vector2(0,-1))

func _on_left_body_entered(body):
	pass # Replace with function body.


func pushing(body):
	if body.is_in_group("player"):
		velocity.x = body.velocity.x
