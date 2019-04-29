extends Node2D

func _physics_process(delta):
	print($ScaleTipper.rotation)

#How it works:
#When more weight is placed on a side the beam will tilt to that side. Basic physics.
#To adjust the tilt max of the scale simply adjust the length of ScaleTipper and the height of TiltMiddle