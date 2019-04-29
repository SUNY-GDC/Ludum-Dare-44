extends Node2D

var num_of_people = 7
var people = ["Tony", "Raea", "ZacharyLawrence", "Chris", "Dylan", "ZachSamalot", "Paul"]
var current_person

func start():
	$CoinParticles.emitting = true
	$CoinParticles2.emitting = true
	$BagBoy.hide()
	yield(get_tree().create_timer(0.5), "timeout")
	$AnimationTree.play("walking_in")
	$BagBoy.show()

func start_credits():
	for person in people:
		current_person = person
		shoot_coin()
		yield(get_tree().create_timer(5), "timeout")
	get_parent().transition_scene("TitleScreen")
	yield(get_tree().create_timer(2.75),"timeout")
	self.hide()

func shoot_coin():
	$CoinSprite.position = Vector2(142, 246)
	$CoinShootingTween.interpolate_property($CoinSprite, "position", $CoinSprite.position, Vector2(400, -70), 1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$CoinShootingTween.start()

func show_person():
	$PersonTween.interpolate_property(get_node(current_person), "position", get_node(current_person).position, Vector2(420, 230), 1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$PersonTween.start()

func _on_AnimationTree_animation_finished(anim_name):
	if anim_name == "walking_in":
		$AnimationTree.play("rotate_bag")
	if anim_name == "rotate_bag":
		$CoinSprite.show()
		start_credits()

func _on_CoinShootingTween_tween_completed(object, key):
	show_person()

func _on_PersonTween_tween_completed(object, key):
	yield(get_tree().create_timer(2), "timeout")
	$PersonLeavingTween.interpolate_property(get_node(current_person), "position", get_node(current_person).position, Vector2(get_node(current_person).position.x, get_node(current_person).position.y + 700), 1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$PersonLeavingTween.start()