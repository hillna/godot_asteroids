extends RigidBody2D

export var speed = 500
var laser_hit = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if laser_hit != true:
		var velocity = Vector2(0,0)
		velocity.y -= 1
		velocity = velocity.rotated(rotation)
		velocity = velocity.normalized() * speed
	
		position += velocity * delta


func _on_StartAnimation_timeout():
	$AnimatedSprite.set_frame(1)


func _on_Laser_body_entered(body):
	if body.is_in_group("Meteors"):
		laser_hit = true
		$AnimatedSprite.set_frame(2)
		$AnimatedSprite.play()
		$LaserFade.start()


func _on_VisibilityEnabler2D_screen_exited():
	queue_free()


func _on_start_game():
	queue_free()


func _on_LaserFade_timeout():
	queue_free()