extends CanvasLayer

signal start_game

func show_message(text: String) -> void:
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over(final_score: int) -> void:
	show_message("FLIGHT ENDED")
	await $MessageTimer.timeout
	$Menu/Title.text = "TRY ANOTHER\nFLIGHT"
	$Menu/Subtitle.text = "SURVIVED %02d SECONDS" % final_score
	$Menu/StartButton.text = "TRY AGAIN  >"
	$Menu.show()
	$Menu/StartButton.grab_focus()

func update_score(score: int) -> void:
	$ScoreLabel.text = "%02d" % score

func _on_start_button_pressed() -> void:
	$Menu.hide()
	start_game.emit()

func _on_message_timer_timeout() -> void:
	$Message.hide()
