extends Area2D

# In order to make this platform work, you need to connect the switches respective activate/deactivate
# signals to the hide platform/ show platform functions

func hide_platform():
	hide()

func show_platform():
	show()