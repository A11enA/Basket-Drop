extends Area2D

@export var speed = 600 # How fast the player will move (pixels/sec). 
var screen_size # Size of the game window.

func start(pos):
	position = pos
	show()
	$Sprites.animation = "empty"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	screen_size = get_viewport_rect().size
	$CollisionShape2D.set_deferred("disabled", false)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	else:
		$Sprites.stop()
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
