extends Control

signal start_game
var time = 0

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
	
	


func _on_start_pressed() -> void:
	$start.hide()
	$stopWatch.start()
	start_game.emit()


func _on_message_timer_timeout() -> void:
	$messageText.hide()


func _on_stop_watch_timeout() -> void:
	time += 1
	$stopWatchText.text = str(time)
