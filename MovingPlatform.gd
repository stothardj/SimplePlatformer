extends Node2D

export(float) var start_time = 0
export(String, "Horizontal", "Vertical") var direction = "Horizontal"

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = $AnimationPlayer
	if direction == "Horizontal":
		player.play("HoriztontalMove")
	else:
		player.play("VerticalMove")
	player.advance(start_time)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
