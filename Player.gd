extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var sprite : AnimatedSprite = $AnimatedSprite
const speed : int = 25
const friction : float = 0.85
const gravity : int = 15
const jump : int = 180
const floor_delay : float = 0.2
const jump_cooldown_delay : float = 0.1
const floor_snap_dist : float = 10.0 
const max_jump_duration : float = 0.2

var vel : Vector2 = Vector2.ZERO
var coyote_time : float = 0
var jump_duration : float = 0
var jump_cooldown : float = 0
var animation = "stand"
var holding_jump = false

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("player")
	sprite.play(animation)

func _physics_process(delta):
	var move_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if is_on_floor():
		if move_input == 0:
			animation = "stand"
		else:
			animation = "walk"
	vel.x = vel.x * friction + move_input * speed
	
	if is_on_floor():
		vel.y = 0
		coyote_time = floor_delay
		jump_cooldown = max(jump_cooldown - delta, 0)
	else:
		vel.y += gravity
		coyote_time = max(coyote_time - delta, 0)

	var jumped = false
	var jump_pressed = Input.is_action_pressed("jump")
	if not jump_pressed or jump_duration >= max_jump_duration:
		holding_jump = false
		jump_duration = 0
	elif holding_jump and jump_pressed:
		vel.y = -jump
		jump_duration = jump_duration + delta
	elif coyote_time > 0 and jump_cooldown == 0 and jump_pressed:
		vel.y = -jump
		coyote_time = 0
		holding_jump = true
		jumped = true
		jump_cooldown = jump_cooldown_delay
		animation = "jump"

	sprite.play(animation)
		
	if move_input > 0:
		sprite.flip_h = false
	elif move_input < 0:
		sprite.flip_h = true
		
	var snap_vector = Vector2.ZERO
	if not jumped:
		snap_vector = Vector2.DOWN * floor_snap_dist
	
	vel = move_and_slide_with_snap(vel, snap_vector, Vector2.UP, false)
	
	var slide_count = get_slide_count()
	for i in range(0, slide_count):
		var coll = get_slide_collision(i)
		var collider = coll.collider
		if collider.is_in_group("active_on_touch"):
			collider.touched()


