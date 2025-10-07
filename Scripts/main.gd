extends TextureRect

@export var time_low = 0.5
@export var time_high = 1.5

@export var fruits = [preload("res://Scenes/Fruit/apple.tscn"),preload("res://Scenes/Fruit/bananas.tscn"),preload("res://Scenes/Fruit/cherries.tscn")]
@export var junks = [preload("res://Scenes/Junks/candy.tscn"),preload("res://Scenes/Junks/chicken.tscn"),preload("res://Scenes/Junks/chips.tscn")]

var fruit = [get_tree().get_nodes_in_group("Fruits")]
var junk = [get_tree().get_nodes_in_group("Junk")]

var score: int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func new_game():
	$Player.start($Spawn.position)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var fruit_to_spawn = fruits[randi_range(0,2)].instantiate()
	fruit_to_spawn.position = Vector2(randf_range(100,1000),$Marker2D.position.y)
	fruit_to_spawn.rotation = randf_range(-3,3)
	add_child(fruit_to_spawn)
	$Timer.wait_time = randf_range(time_low,time_high)




func _on_area_2d_body_entered(body):
	
	body.queue_free()
	pass # Replace with function body.


func _on_junk_timer_timeout() -> void:
	var junk_to_spawn = junks[randi_range(0,2)].instantiate()
	junk_to_spawn.position = Vector2(randf_range(100,1000),$Marker2D.position.y + randf_range(-3,3))
	junk_to_spawn.rotation = randf_range(-3,3)
	add_child(junk_to_spawn)
	$Timer.wait_time = randf_range(time_low,time_high)


func _on_hud_start_game() -> void:
	$Player.show()
	new_game()


func _on_player_bad_hit() -> void:
	score -= 1
	$HUD.score_update()

func _on_player_body_entered(body: Node2D) -> void:
	if body == junk:
		$Sprites.animation = "spilled"
		print("bad")
	if body == fruit:
		$Sprites.animation = "full"
		print("good")
