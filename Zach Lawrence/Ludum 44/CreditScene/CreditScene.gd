extends Node2D

var people = ["Tony", "Raea", "ZacharyLawrence", "Chris", "Dylan", "ZachSamalot", "Paul"] # lsit of people in credits
var current_person # who we are currently showing

func _ready():
	$CoinParticles.emitting = true # start the particles
	$CoinParticles2.emitting = true
	$BagBoy.hide() # hide the bag boy
	yield(get_tree().create_timer(0.5), "timeout") # wait a sec
	$AnimationTree.play("walking_in") # start the walking animation
	$BagBoy.show() # show the bag boy

func start_credits(): # when the player is ready to shoot out coins
	for person in people: # looping through the strings of people
		current_person = person # assign who we are showcasing
		shoot_coin() # shoot a coin
		yield(get_tree().create_timer(5), "timeout") # then wait

func shoot_coin(): # purely visual
	$CoinSprite.position = Vector2(142, 246) # set the coins position
	$CoinShootingTween.interpolate_property($CoinSprite, "position", $CoinSprite.position, Vector2(400, -70), 1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$CoinShootingTween.start() # start the tween to shoot it in the air

func show_person(): # moving the portraits downward
	$PersonTween.interpolate_property(get_node(current_person), "position", get_node(current_person).position, Vector2(420, 230), 1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$PersonTween.start()

func _on_AnimationTree_animation_finished(anim_name): # animation control
	if anim_name == "walking_in": # if walking in is finished
		$AnimationTree.play("rotate_bag") # start rotating the bag
	if anim_name == "rotate_bag": # if rotating bag is finished
		$CoinSprite.show() # show the coin sprite
		start_credits() # get the show on the road

func _on_CoinShootingTween_tween_completed(object, key): # when the coin is finished getting shot
	show_person() # show the portrait

func _on_PersonTween_tween_completed(object, key): # to move the person out of the way
	yield(get_tree().create_timer(2), "timeout")
	$PersonLeavingTween.interpolate_property(get_node(current_person), "position", get_node(current_person).position, Vector2(get_node(current_person).position.x, get_node(current_person).position.y + 700), 1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$PersonLeavingTween.start()