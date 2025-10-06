extends Area2D

@export var speed = 400 # How fast the player will move (pixels/sec). 
var screen_size # Size of the game window.

@export var fruits = [preload("res://Scenes/apple.tscn"),preload("res://Scenes/bananas.tscn"),preload("res://Scenes/cherries.tscn")]
@export var junk = [preload("res://Scenes/candy.tscn"),preload("res://Scenes/chicken.tscn"),preload("res://Scenes/chips.tscn")]

signal goodHit
signal badHit

func start(pos):
	position = pos
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1


func _on_body_shape_entered(body: Node2D) -> void:
	if junk:
		badHit.emit()
		print("bad")
	if fruits:
		goodHit.emit()
		print("good")
		
	print("hit!")
