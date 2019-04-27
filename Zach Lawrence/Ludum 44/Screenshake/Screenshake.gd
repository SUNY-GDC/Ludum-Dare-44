extends Node

# This scene must be a child of the camera that is current
# In order to start the screenshake, you have to call the start function
# Recommended parameters are (0.2, 15, and 15) as those are set as base parameters anyways

const TRANS = Tween.TRANS_SINE # Easy tweening
const EASE = Tween.EASE_IN_OUT # Easy tweening

var amplitude = 0 # how far the screen will move, per shake
onready var camera = get_parent() # the camera node (this must be a child of the Camera2D

# This function will start the screenshake events
func start(duration = 0.2, frequency = 15, amplitude = 20):
	self.amplitude = amplitude # set the scripts amplitude to the sent amplitude
	$Duration.wait_time = duration # set the amount of time the shakes will last
	$Frequency.wait_time = 1 / float(frequency) # set the amount of shakes per second
	$Duration.start() # start the timer to end the shaking
	$Frequency.start() # start the timer to redo each individual shake
	new_shake() # call new_shake()

# This function, when called, will shift the screen over, once
func new_shake():
	var rand = Vector2() # reset the rand variable
	rand.x = rand_range(-amplitude, amplitude) # set the x to a random number from -amplitude to +amplitude
	rand.y = rand_range(-amplitude, amplitude) # set the y to a random number from -amplitude to +amplitude
	$ShakeTween.interpolate_property(camera, "offset", camera.offset, rand, $Frequency.wait_time, TRANS, EASE) # set the tween
	$ShakeTween.start() # start the tween

# This tween will reset the cameras position
func reset(): 
	$ShakeTween.interpolate_property(camera, "offset", camera.offset, Vector2(), $Frequency.wait_time, TRANS, EASE) # set the tween
	$ShakeTween.start() # start the tween

# Whenever the frequency timer stops
func _on_Frequency_timeout(): 
	new_shake() # call new shake

# Whenever the duration timer stops
func _on_Duration_timeout():
	reset() # reset the camera position
	$Frequency.stop() # stop the frequency timer
