extends Node2D

export (int) var speed = 500

func _ready():
	$CoinParticles.emitting = true
	print($CoinParticles.emitting)

func _process(delta):
	$Sprite.position.y += speed * delta