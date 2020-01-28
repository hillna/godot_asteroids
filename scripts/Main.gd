extends Node2D

export (PackedScene) var Meteor
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


func game_over():
	$MeteorTimer.stop()
	$HUD.show_game_over()


func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready!")


func _on_StartTimer_timeout():
	$MeteorTimer.start()


func _on_MeteorTimer_timeout():
	# Choose a random location on Path2d (MeteorPath)
	$MeteorPath/MeteorSpawnLocation.set_offset(randi())
	# Create a Meteor instance and add it to the scene
	var meteor = Meteor.instance()
	add_child(meteor)
	# Set the meteor's direction perpendicular to the path direction.
	var direction = $MeteorPath/MeteorSpawnLocation.rotation + PI / 2
	# Set the meteor's position to a random location.
	meteor.position = $MeteorPath/MeteorSpawnLocation.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	meteor.rotation = direction
	# Set the velocity (speed & direction)
	meteor.linear_velocity = Vector2(rand_range(meteor.min_speed, meteor.max_speed), 0)
	meteor.linear_velocity = meteor.linear_velocity.rotated(direction)
	# Meteor signals
	$HUD.connect("start_game", meteor, "_on_start_game")
	meteor.connect("meteor_destroyed", self, "_on_meteor_destroyed")


func _on_meteor_destroyed():
	score = score + 1
	$HUD.update_score(score)