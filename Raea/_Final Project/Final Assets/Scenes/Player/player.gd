extends KinematicBody2D

export (int) var run_speed = 350
export (int) var jump_speed = -305
export (int) var gravity = 750
export (PackedScene) var coin
export (int) var max_coins = 10

enum {IDLE, WALK, JUMP, DEAD, LEFT, RIGHT}
var state
var facing
var mousepos
var velocity = Vector2()

var coin_count

func _ready():
	state = IDLE
	facing = RIGHT
	coin_count = float(max_coins)
	scale.y = (coin_count/max_coins) * 2
	

func _physics_process(delta):
	#box colision
	for idx in range(get_slide_count()):
		var col = get_slide_collision(idx)
		if col.collider.has_method("push"):
			if col.normal.y == 0:
				col.collider.push(-col.normal.x * 75)
		#print(col.collider)
	get_input()
	if !is_on_floor():
		velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2(0, -1))

func _process(delta):
	mousepos = get_global_mouse_position()
	get_input()
	_state_change(state, facing)
	
	#rotate the player to face the mouse
	$body.look_at(mousepos)
	$RayCast2D.look_at(mousepos)
	

func get_input():
# Gets player input for movement
	
	# Remove player horizontal velocity
	if state != JUMP:
		velocity.x = 0
	
	# Store inputs into variables for ease of access
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var jump = Input.is_action_just_pressed("jump")
	var click = Input.is_action_just_pressed("mouse_click")
	
	# Detect directional input, change velocity and sprite direction to match
	if right:
		velocity.x = run_speed
		facing = RIGHT
		
	if left:
		velocity.x = -run_speed
		facing = LEFT
	
	# Detect jumping, only jump if player is touching the floor
	if jump and is_on_floor():
		state = JUMP
		velocity.y = jump_speed
	else:
		state = IDLE
	
	
	if state == IDLE and velocity.x != 0:
		state = WALK
		
	if state == WALK and velocity.x == 0:
		state = IDLE
	
	if state in [IDLE, WALK] and !is_on_floor():
		state = JUMP
		
	#On player click, shoots a coin in the direction of the mouse, and changes the player size according to their coin amount
	if click:
		if coin_count > 0:
			var c = coin.instance()
			c.setup(mousepos, position, $RayCast2D.rotation)
			velocity -= c.linear_velocity / 3
			c.add_collision_exception_with(self)
			get_parent().add_child(c)
			scale_tween()
			coin_count -= 1
			
			
func scale_tween():
	#hanges the player size according to their coin amount
	$Tween.interpolate_property(self, "scale:y", scale.y, (coin_count/max_coins)* 2,0.5,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

# Gets player animations based on state
func _state_change(_state, _facing):
	var dir
	match _facing:
		LEFT:
			dir = "left"
		RIGHT:
			dir = "right"
			
	match _state:
		
		IDLE:
			$AnimationPlayer.play("idle_" + str(dir))
		
		WALK:
			$AnimationPlayer.play("walk_" + str(dir))
		
		JUMP:
			$AnimationPlayer.play("walk_" + str(dir))
	
	