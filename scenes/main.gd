extends Sprite2D

var gameStarted = false
var score := [3, 3]# 0:Player, 1: Player 2

@onready var endGameScreen = $endScreen
@onready var ui = $UI
@onready var chicken_1_green = $mainGameScreen/Coop1/Chicken1
@onready var chicken_2_green = $mainGameScreen/Coop1/Chicken2
@onready var chicken_3_green = $mainGameScreen/Coop1/Chicken3
@onready var chicken_1_blue = $mainGameScreen/Coop2/Chicken1
@onready var chicken_2_blue = $mainGameScreen/Coop2/Chicken2
@onready var chicken_3_blue = $mainGameScreen/Coop2/Chicken3

var chicken_up_texture = preload("res://assets/Chicken.png")
var poof_texture = preload("res://assets/Poof.png")

func _ready():
	$BackgroundMusic.play()
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
	$mainGameScreen/Hud/Player2Score.text = str(score[0])
	
	$mainGameScreen/Louie.position.x = 0
	$mainGameScreen/Louie.position.y = 0
	
	$mainGameScreen.visible = true
	$mainGameScreen/Hud.visible = true
	$mainGameScreen/Louie.gameStarted = true
	$mainGameScreen/HayBail1.gameStarted = true
	$mainGameScreen/HayBail2.gameStarted = true
	
	# reset chickens
	chicken_1_green.visible = true
	chicken_2_green.visible = true
	chicken_3_green.visible = true
	chicken_1_blue.visible = true
	chicken_2_blue.visible = true
	chicken_3_blue.visible = true
	chicken_1_green.texture = chicken_up_texture
	chicken_2_green.texture = chicken_up_texture
	chicken_3_green.texture = chicken_up_texture
	chicken_1_blue.texture = chicken_up_texture
	chicken_2_blue.texture = chicken_up_texture
	chicken_3_blue.texture = chicken_up_texture

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
		$mainGameScreen/Hud/PlayerScore.text = str(score[0])
		if(score[0] == 0):
			_end_game(1)
		$mainGameScreen/Louie.jump()
		
		# Make chickens poof
		if score[0] == 2:
			chicken_1_green.texture = poof_texture
			await get_tree().create_timer(0.75).timeout
			chicken_1_green.visible = false
			$SquawkSound.play()
		elif score[0] == 1:
			chicken_2_green.texture = poof_texture
			await get_tree().create_timer(0.75).timeout
			chicken_2_green.visible = false
			$SquawkSound.play()
		else:
			$SquawkSound.play()

func _on_coop_2_area_body_entered(body: Node2D) -> void:
	if body.name == "Louie":
		
		score[1] -= 1
		$mainGameScreen/Hud/Player2Score.text = str(score[1])
		if(score[1] == 0):
			_end_game(2)
		$mainGameScreen/Louie.jump()
		
		# Make chickens poof
		if score[1] == 2:
			chicken_1_blue.texture = poof_texture
			await get_tree().create_timer(0.75).timeout
			chicken_1_blue.visible = false
			$SquawkSound.play()
		elif score[1] == 1:
			chicken_2_blue.texture = poof_texture
			await get_tree().create_timer(0.75).timeout
			chicken_2_blue.visible = false
			$SquawkSound.play()
		else:
			$SquawkSound.play()
	
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
