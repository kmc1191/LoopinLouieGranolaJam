extends CanvasLayer

signal game_started
var playerWon = 0

@onready var endGameScreen = $endScreen

@onready var mainScreen = $Main

func _ready():
	pass

func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
	
func on_game_over(player_won : int):
	playerWon = player_won
	endGameScreen.visible = true
	$endScreen/EndGameScoreDisplay/PlayerWonDisplay.text = "Player %d won!\nCongratulations!" % playerWon
