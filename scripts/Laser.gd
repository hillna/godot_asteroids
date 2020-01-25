extends RigidBody2D

export var speed = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(0.3), 'timeout')
	$AnimatedSprite.set_frame(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass