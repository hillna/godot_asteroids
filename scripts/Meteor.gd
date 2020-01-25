extends RigidBody2D

signal meteor_destroyed

export var min_speed = 150 # Minimum speed
export var max_speed = 250 # Max speed
var meteor_types = ["Meteor1", "Meteor2", "Meteor3", "Meteor4"]

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.animation = meteor_types[randi() % meteor_types.size()]


func _on_VisibilityEnabler2D_screen_exited():
	queue_free()
	emit_signal("meteor_destroyed")


func _on_start_game():
	queue_free()