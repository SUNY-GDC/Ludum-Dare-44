extends Node

#onready var coin_count = $player.coin_count
#onready var max_coins = $player.max_coins

onready var trans_scene = $SceneTransition
onready var trans_start_pos = $SceneTransition.position

#Array of levels in order
var levels = [load("res://Final Assets/Scenes/Levels/Level1.tscn"), 
              load("res://Final Assets/Scenes/Levels/Level2.tscn"),
              load("res://Final Assets/Scenes/Levels/Level3.tscn"),
              load("res://Final Assets/Scenes/Levels/Level4.tscn"),
             ]
var current_level = 0 #The level the player is currently in

#This runs only when the game is first started
func start_game():
	transition_scene(levels[current_level]) #Start level transition

#Transition to the next level
func transition_scene(next_scene):
	var level = next_scene.instance() #The next level to be instanced
	
	if $Levels.get_child_count() > 0: #If there's a level in in the Levels node
		$Levels.get_child(0).queue_free() #Delete the level
	
	trans_scene.position = trans_start_pos 
#	var cam_zoom
#	var cam_position

	trans_scene.show() #Show transition
	trans_scene.get_node("AnimationPlayer").play("scene_transition") #Play transition
	yield($SceneTransition/AnimationPlayer, "animation_finished") #Wait until the animation is finished
	$Camera2D.current = false #If the camera is current then turn it off 

	#cam_zoom = get_node(next_scene + "/Camera2D").zoom
	#cam_position = get_node(next_scene + "/Camera2D").position
#	$Tween.interpolate_property($Camera2D, "zoom", $Camera2D.zoom, cam_zoom, 1.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
#	$Tween.start()
#	yield($Tween, "tween_completed")
#	$Tween.interpolate_property($Camera2D, "position", $Camera2D.position, cam_position, 1.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
#	$Tween.start()
#	yield($Tween, "tween_completed")
#	$Tween.interpolate_property(trans_scene, "position", trans_scene.position, Vector2(trans_scene.position.x, 1000), 1.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
#	$Tween.start()
#	yield($Tween, "tween_completed")
	
	$Levels.add_child(level) #Add the level to the main scene
	level.connect("level_complete", self, "next_level") #Connect the level complete signal to the next level function

#This moves the game to the next level
func next_level():
	current_level += 1 #Add level up by 1
	
	transition_scene(levels[current_level]) #Transition to next level

func game_reboot():
	get_tree().reload_current_scene()


