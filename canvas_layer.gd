extends CanvasLayer

signal game_started
signal game_restarted
var playerWon = 0

@onready var endGameScreen = $endScreen

@onready var mainScreen = $Main
@onready var playButton = $beforeScreen/playButton/Sprite2D
@onready var exitButton = $beforeScreen/quitGameButton/Sprite2D
@onready var homeButton = $endScreen/Sprite2D
@onready var replayButton = $endScreen/RestartButton/Sprite2D

var playSprite = preload("res://assets/PlayButton.png")
var playHoverSprite = preload("res://assets/PlayButtonHover.png")
var homeButtonSprite = preload("res://assets/HomeButton.png")
var homeButtonHoverSprite = preload("res://assets/HomeButtonHover.png")
var exitSprite = preload("res://assets/Exit.png")
var exitHoverSprite = preload("res://assets/ExitHover.png")
var replayButtonSprite = preload("res://assets/Replay.png")
var replayButtonHoverSprite = preload("res://assets/ReplayHover.png")

func _ready():
	pass
	
func on_game_over(player_won : int):
	playerWon = player_won
	endGameScreen.visible = true
	$LoopingLoseSound.play()
	$endScreen/EndGameScoreDisplay/PlayerWonDisplay.text = "PLAYER %d LOST!\nLOOP AGAIN LATER!" % playerWon


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


func _on_play_button_mouse_entered() -> void:
	playButton.texture = playHoverSprite


func _on_play_button_mouse_exited() -> void:
	playButton.texture = playSprite


func _on_quit_game_button_mouse_entered() -> void:
	exitButton.texture = exitHoverSprite


func _on_quit_game_button_mouse_exited() -> void:
	exitButton.texture = exitSprite


func _on_home_screen_button_mouse_entered() -> void:
	homeButton.texture = homeButtonHoverSprite


func _on_home_screen_button_mouse_exited() -> void:
	homeButton.texture = homeButtonSprite


func _on_restart_button_mouse_entered() -> void:
	replayButton.texture = replayButtonHoverSprite


func _on_restart_button_mouse_exited() -> void:
	replayButton.texture = replayButtonSprite
