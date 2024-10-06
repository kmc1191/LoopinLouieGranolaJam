extends CharacterBody2D

@onready var child_sprite = $LouieSprite
var win_size : Vector2
var direction : int = 1
var gameStarted = false

func _ready():
	win_size = get_viewport_rect().size
	child_sprite.flip_h = true

func _physics_process(delta: float) -> void:
	if(gameStarted):
		velocity.y += get_gravity().y*0.5 * delta
		velocity.x = 220 * direction

	move_and_slide()
	
func turn_around():
	if(direction==-1):
		child_sprite.flip_h = true
	else:
		child_sprite.flip_h = false
	direction *= -1
	
func jump():
	velocity.y = -400

func jump_off_wall():
	velocity.y = -250
