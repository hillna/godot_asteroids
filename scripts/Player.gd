extends Area2D

signal hit

export (PackedScene) var Laser
export var speed = 400 # How fast the player will move (pixels/sec)
var screen_size # Size of the game window

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2() # Players movement vector.
	if Input.is_action_pressed("ui_up"):
		#velocity.
		pass
	if Input.is_action_pressed("ui_left"):
		pass
	if Input.is_action_pressed("ui_right"):
		pass
	if Input.is_action_just_pressed("ui_accept"):
		var laser = Laser.instance()
		add_child(laser)
		laser.linear_velocity = Vector2(0, -laser.speed)  
	
	if velocity.length() >0:
		velocity = velocity.normalized() * speed

	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func _on_Player_body_entered(body):
	#hide() # Player disappears after being hit.
	#emit_signal("hit")
	#$CollisionShape2D.set_deferred("disabled",true)
	pass


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false