extends CanvasLayer
signal start_game

func update_score(score):
	$Score.text = str(score)

func _process(delta):
	pass

func _ready():
	$RestartButton.hide()

func show_game_over():
	show_message("GAME OVER")
	$RestartButton.show()

func show_start():
	show_message("if you can")
	$MessageTimer.start()
	yield($MessageTimer, "timeout")
	$GameMessage.hide()

func show_teleport():
	show_message("TELEPORT...")
	$MessageTimer.start()
	yield($MessageTimer, "timeout")
	$GameMessage.hide()

func show_message(msg):
	$GameMessage.text = msg
	$GameMessage.show()

func _on_StartButton_pressed():
	$StartButton.hide()
	$GameMessage.hide()
	emit_signal("start_game")


func _on_RestartButton_pressed():
	$GameMessage.hide()
	$RestartButton.hide()
	get_tree().change_scene("res://scenes/Game.tscn")
