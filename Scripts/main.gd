extends TextureRect

@export var time_low = 0.5
@export var time_high = 1.5

@export var fruits = [preload("res://Scenes/Fruit/apple.tscn"),preload("res://Scenes/Fruit/bananas.tscn"),preload("res://Scenes/Fruit/cherries.tscn")]
@export var junks = [preload("res://Scenes/Junks/candy.tscn"),preload("res://Scenes/Junks/chicken.tscn"),preload("res://Scenes/Junks/chips.tscn")]

var score: int

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player/CollisionShape2D.set_deferred("disabled", true)
	$Timer.stop()
	$junkTimer.stop()

func new_game():
	$Player.start($Spawn.position)
	$Timer.start()
	$junkTimer.start()
	$Player/CollisionShape2D.set_deferred("disabled", false)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if score < 0:
		game_over()


func game_over():
	$Player/CollisionShape2D.set_deferred("disabled", true)
	$Player.visible = false
	$HUD/stopWatch.stop()
	score = 00
	$HUD.score_update(score)
	$Timer.stop()
	$junkTimer.stop()
	$HUD.show_message("The Picnic is ruined :(")
	await $HUD/messageTimer.timeout
	$HUD/messageText.text = "Fruit Basket"
	$HUD/messageText.show()
	$HUD/stopWatchText.text = "0"
	$HUD/start.show()
	

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

func _on_player_body_entered(body: Node2D) -> void:
	if body.is_in_group("Junk"):
		$Player/Sprites.play("spilled")
		score -= 1
	if body.is_in_group("Fruits"):
		$Player/Sprites.play("full")
		score += 1
	$HUD.score_update(score)
	$Player/spriteTimer.start()
