extends Node2D

var num_of_people = 7
var people = ["Tony", "Dylan", "Chris", "Justin", "Raea", "Zach S", "Zach L"]

func _ready():
	$BagBoy.hide()
	yield(get_tree().create_timer(0.5), "timeout")
	$AnimationTree.play("walking_in")
	$BagBoy.show()

func start_credits():
	for i in range(num_of_people):
		print (people[i])
		yield(get_tree().create_timer(2), "timeout")

func _on_AnimationTree_animation_finished(anim_name):
	if anim_name == "walking_in":
		$AnimationTree.play("rotate_bag")
	if anim_name == "rotate_bag":
		start_credits()
