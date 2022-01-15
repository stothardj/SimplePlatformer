extends KinematicBody2D


const speed : int = 35
const floor_snap_dist : float = 0.1 
const gravity : int = 15

var vel : Vector2 = Vector2.ZERO
var direction : int = 1

func _ready():
	$AnimatedSprite.play("walk")

func _physics_process(delta):
	vel.x = speed * direction
	vel.y += gravity
	vel = move_and_slide_with_snap(vel, Vector2.DOWN * floor_snap_dist, Vector2.UP, false)
	
	var slide_count = get_slide_count()
	var turn_around = false
	for i in range(0, slide_count):
		var coll = get_slide_collision(i)
		if coll.normal == Vector2.LEFT or coll.normal == Vector2.RIGHT:
			turn_around = true
	if turn_around:
		$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
		direction *= -1

