extends Area2D

@export var speed = 400 # How fast the player will move (pixels/sec). 
var screen_size # Size of the game window.

@export var fruits = [preload("res://Scenes/apple.tscn"),preload("res://Scenes/bananas.tscn"),preload("res://Scenes/cherries.tscn")]
@export var junks = [preload("res://Scenes/candy.tscn"),preload("res://Scenes/chicken.tscn"),preload("res://Scenes/chips.tscn")]


signal goodHit
signal badHit

func start(pos):
	position = pos
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show()
	screen_size = get_viewport_rect().size


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
	



func _on_body_shape_entered(body: Node2D) -> void:
	pass # Replace with function body.
