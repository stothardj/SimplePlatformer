extends KinematicBody2D

var falling : bool = false
var gravity : int = 3
var vel : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("active_on_touch")


func touched():
	falling = true

func _physics_process(delta):
	if falling:
		vel.y += gravity * delta
		
	position.y += vel.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
