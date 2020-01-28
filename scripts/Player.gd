extends Area2D

signal hit

export (PackedScene) var Laser
export var speed = 200 # How fast the player will move (pixels/sec)
export var rotation_speed = 5 # How fast the player will rotate
var laser_cooldown = false
var screen_size # Size of the game window


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2(0,0) # Players movement vector.
	if Input.is_action_pressed("ui_up"):
		$Thrust.show()
		velocity.y -= 1
	else:
		$Thrust.hide()

	if Input.is_action_pressed("ui_left"):
		rotate(-rotation_speed * delta)
	if Input.is_action_pressed("ui_right"):
		rotate(rotation_speed * delta)

	if Input.is_action_just_pressed("ui_accept"):
		if laser_cooldown == false:
			var laser = Laser.instance()
			get_parent().add_child(laser)
			laser.position = position
			laser.rotation = rotation
			laser_cooldown = true
			$LaserCooldown.start()

	if velocity.length() >0:
		velocity = velocity.rotated(rotation)
		velocity = velocity.normalized() * speed
		

	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func _on_LaserCooldown_timeout():
	laser_cooldown = false


func _on_Player_body_entered(body):
	if body.is_in_group("Meteors"):
		hide() # Player disappears after being hit.
		emit_signal("hit")
		$CollisionShape2D.set_deferred("disabled",true)


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false