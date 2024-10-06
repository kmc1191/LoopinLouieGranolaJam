extends Sprite2D

var score := [3, 3]# 0:Player, 1: Player 2
const PADDLE_SPEED : int = 500

@onready var endGameScreen = $endScreen

#func _on_ball_timer_timeout():
	#$Ball.new_ball()

func _on_wall_left_hit(body):
	#score[1] += 1
	#$Hud/CPUScore.text = str(score[1])
	#$BallTimer.start()
	$mainGameScreen/Louie.turn_around()
	$mainGameScreen/Louie.jump()

func _on_hay_bail_collider_body_entered(body: Node2D) -> void:
	if body.name == "Louie":
		$mainGameScreen/Louie.jump()

func _on_wall_right_hit(body: Node2D) -> void:
	$mainGameScreen/Louie.turn_around()
	$mainGameScreen/Louie.jump()	

func _on_coop_1_area_body_entered(body: Node2D) -> void:
	score[1] += 1
	$mainGameScreen/Louie.jump()

func _on_coop_2_area_body_entered(body: Node2D) -> void:
	score[0] += 1
	$mainGameScreen/Louie.jump()
	
func _end_game():
	var playerWon = 0
	if(score[0] == 0):
		playerWon = 2
	else:
		playerWon = 1
	$UI.on_game_over(playerWon)
	
	
