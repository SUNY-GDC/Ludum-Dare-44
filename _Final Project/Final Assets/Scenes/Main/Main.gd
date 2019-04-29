extends Node

onready var trans_scene = $SceneTransition
onready var trans_start_pos = $SceneTransition.position

onready var levels = ["Level1", "Level2", "Level3", "Level4", "Level5"]

func transition_scene(next_scene):
	trans_scene.position = trans_start_pos
	var cam
	var zoom
	var position
	trans_scene.show()
	trans_scene.get_node("AnimationPlayer").play("scene_transition")
	yield(get_tree().create_timer(3.25),"timeout")
	if get_node(next_scene + "/Camera2D") == null:
		if get_node(next_scene + "/player/Camera2D") != null:
			cam = get_node(next_scene + "/player/Camera2D")
		else:
			return
	else:
		cam = get_node(next_scene + "/Camera2D")
	zoom = cam.zoom
	position = cam.position
	$Tween.interpolate_property($Camera2D, "zoom", $Camera2D.zoom, zoom, 1.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()
	$Tween.interpolate_property($Camera2D, "position", $Camera2D.position, position, 1.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()
	$Camera2D.current = false
	cam.current = true
	
	$Tween.interpolate_property(trans_scene, "position", trans_scene.position, Vector2(trans_scene.position.x, 3000), 1.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()
	
	if next_scene == "CreditScene":
		next_scene.start()
	
	get_node(next_scene).show()