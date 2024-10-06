extends Sprite2D

var gameStarted = false
var score := [1, 1]# 0:Player, 1: Player 2

@onready var endGameScreen = $endScreen
@onready var ui = $UI

func _ready():
	ui.game_started.connect(game_started)
	ui.game_restarted.connect(game_restarted)
	
func game_started():
	gameStarted = true
	$mainGameScreen.visible = true
	$mainGameScreen/Hud.visible = true
	$mainGameScreen/Louie.gameStarted = true
	$mainGameScreen/HayBail1.gameStarted = true
	$mainGameScreen/HayBail2.gameStarted = true

	
func game_restarted():
	score = [3, 3]
	$mainGameScreen/Hud/PlayerScore.text = str(score[0])
	$mainGameScreen/Hud/CPUScore.text = str(score[0])
	
	$mainGameScreen/Louie.position.x = 0
	$mainGameScreen/Louie.position.y = 0
	
	$mainGameScreen.visible = true
	$mainGameScreen/Hud.visible = true
	$mainGameScreen/Louie.gameStarted = true
	$mainGameScreen/HayBail1.gameStarted = true
	$mainGameScreen/HayBail2.gameStarted = true

func _on_wall_left_hit(body):
	$mainGameScreen/Louie.turn_around()
	$mainGameScreen/Louie.jump()

func _on_hay_bail_collider_body_entered(body: Node2D) -> void:
	if body.name == "Louie":
		$mainGameScreen/Louie.jump()

func _on_wall_right_hit(body: Node2D) -> void:
	$mainGameScreen/Louie.turn_around()
	$mainGameScreen/Louie.jump()	

func _on_coop_1_area_body_entered(body: Node2D) -> void:
	if body.name == "Louie":
		score[0] -= 1
		print("hit coop 1")
		$mainGameScreen/Hud/PlayerScore.text = str(score[0])
		if(score[0] == 0):
			_end_game(2)
		$mainGameScreen/Louie.jump()

func _on_coop_2_area_body_entered(body: Node2D) -> void:
	if body.name == "Louie":
		print("hit coop 2")
		score[1] -= 1
		$mainGameScreen/Hud/CPUScore.text = str(score[1])
		if(score[1] == 0):
			_end_game(1)
		$mainGameScreen/Louie.jump()
	
func _end_game(player_won : int):
	$mainGameScreen.visible = false
	$mainGameScreen/Hud.visible = false
	
	$mainGameScreen/Louie.gameStarted = false
	$mainGameScreen/HayBail1.gameStarted = false
	$mainGameScreen/HayBail2.gameStarted = false
	
	$UI.on_game_over(player_won)
	

func _on_Louie_hit_bottom(body: Node2D) -> void:
	if(body.name == "Louie"):
		$mainGameScreen/Louie.position.y-=100
