extends CharacterBody2D

@onready var child_sprite = $LouieSprite
var win_size : Vector2
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var direction : int = 1


func _ready():
	win_size = get_viewport_rect().size
	child_sprite.flip_h = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
	velocity += get_gravity()*0.05 * delta
	velocity.x = 220 * direction
	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	move_and_slide()
	
func turn_around():
	if(direction==-1):
		child_sprite.flip_h = true
	else:
		child_sprite.flip_h = false
	direction *= -1
	
func jump():
	velocity.y = -90
