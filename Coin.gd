extends Area2D

onready var sprite : AnimatedSprite = $AnimatedSprite
const move_speed : float = 100.0
var collected : bool = false
var collection_time : float = 0.3

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.play()

func _on_Coin_body_entered(body):
	collected = true
	sprite.modulate.a = 0.5

func _process(delta):
	if collected:
		position.y -= move_speed * delta
		collection_time -= delta
		if collection_time <= 0.0:
			queue_free()
