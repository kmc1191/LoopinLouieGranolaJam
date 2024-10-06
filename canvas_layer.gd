extends CanvasLayer

signal game_started
signal game_restarted
var playerWon = 0

@onready var endGameScreen = $endScreen

@onready var mainScreen = $Main

func _ready():
	pass
	
func on_game_over(player_won : int):
	playerWon = player_won
	endGameScreen.visible = true
	$LoopingLoseSound.play()
	$endScreen/EndGameScoreDisplay/PlayerWonDisplay.text = "Player %d lost!\nLoop again later!" % playerWon


func _on_home_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_quit_game_button_pressed() -> void:
	get_tree().quit()

func _on_play_button_pressed() -> void:
	game_started.emit()
	$beforeScreen.visible = false


func _on_restart_button_pressed() -> void:
	game_restarted.emit()
	$endScreen.visible = false
