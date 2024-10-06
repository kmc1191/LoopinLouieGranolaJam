extends Sprite2D

var score := [3, 3]# 0:Player, 1: Player 2
const PADDLE_SPEED : int = 500

#func _on_ball_timer_timeout():
	#$Ball.new_ball()

func _on_wall_left_hit(body):
	#score[1] += 1
	#$Hud/CPUScore.text = str(score[1])
	#$BallTimer.start()
	$Louie.turn_around()
	$Louie.jump()

func _on_hay_bail_collider_body_entered(body: Node2D) -> void:
	if body.name == "Louie":
		$Louie.jump()



func _on_wall_right_hit(body: Node2D) -> void:
	$Louie.turn_around()
	$Louie.jump()	


func _on_coop_1_area_body_entered(body: Node2D) -> void:
	score[1] += 1
	$Louie.jump()


func _on_coop_2_area_body_entered(body: Node2D) -> void:
	score[0] += 1
	$Louie.jump()
