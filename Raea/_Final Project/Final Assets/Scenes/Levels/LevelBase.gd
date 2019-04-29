extends Node2D

signal level_complete

func _ready():
	
	var map_size = $Background.get_used_rect()
	var cell_size = $Background.cell_size
#	$player/Camera2D.limit_left = (map_size.position.x) * cell_size.x
#	$player/Camera2D.limit_right = (map_size.end.x) * cell_size.x
#	$player/Camera2D.limit_top = (map_size.position.y) * cell_size.y
#	$player/Camera2D.limit_bottom = ((map_size.end.y) * cell_size.y)

func level_complete():
	emit_signal("level_complete")