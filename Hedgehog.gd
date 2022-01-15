extends KinematicBody2D

const gravity : int = 15
onready var sprite = $AnimatedSprite

var vel : Vector2 = Vector2.ZERO
const floor_snap_dist : float = 10.0 

func _physics_process(delta):
	vel.y += gravity
	var snap_vector = Vector2.DOWN * floor_snap_dist
	vel = move_and_slide_with_snap(vel, snap_vector, Vector2.UP, false)



func _on_ThreatDetector_body_entered(body):
	if body.is_in_group("player"):
		sprite.play("roll")


func _on_ThreatDetector_body_exited(body):
	if body.is_in_group("player"):
		sprite.play("unroll")
