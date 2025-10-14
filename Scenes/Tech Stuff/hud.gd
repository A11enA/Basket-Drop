extends Control

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_message(text):
	$messageText
	$messageText.text = text
	$messageText.show()
	$messageTimer.start()
	
func score_update(score):
	$scoreText.text = str(score)
	
	
func show_game_over():
	show_message("The Picnic is ruined :(")
	await $messageTimer.timeout
	show_message("Fruit Basket")
	await $messageTimer.timeout
	$Start.show()
	


func _on_start_pressed() -> void:
	$start.hide()
	start_game.emit()


func _on_message_timer_timeout() -> void:
	$messageText.hide()
