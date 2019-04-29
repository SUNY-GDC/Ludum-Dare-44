extends Node

onready var coin_count = $player.coin_count
onready var max_coins = $player.max_coins

onready var trans_scene = $SceneTransition
onready var trans_start_pos = $SceneTransition.position

func transition_scene(next_scene):
	trans_scene.position = trans_start_pos
	var cam_zoom
	var cam_position
	trans_scene.show()
	trans_scene.get_node("AnimationPlayer").play("scene_transition")
	yield(get_tree().create_timer(3.25),"timeout")
	cam_zoom = get_node(next_scene + "/Camera2D").zoom
	cam_position = get_node(next_scene + "/Camera2D").position
	$Tween.interpolate_property($Camera2D, "zoom", $Camera2D.zoom, cam_zoom, 1.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()
	$Tween.interpolate_property($Camera2D, "position", $Camera2D.position, cam_position, 1.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()
	$Tween.interpolate_property(trans_scene, "position", trans_scene.position, Vector2(trans_scene.position.x, 1000), 1.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()
	
	get_node(next_scene).show()