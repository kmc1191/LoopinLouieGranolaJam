extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0

@onready var haybail_sprite = $Sprite2D
@onready var spring_sprite = $"../Spring2"

var idle_texture = preload("res://assets/HaybaleStationary.png")
var up_texture = preload("res://assets/HaybaleUp.png")
var down_texture = preload("res://assets/HaybaleDown.png")
var spring_down = preload("res://assets/BlueSpringDown.png")
var spring_up = preload("res://assets/BlueSpringExtended.png")

var gameStarted = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_key_pressed(KEY_ENTER) and is_on_floor() and gameStarted:
		velocity.y = JUMP_VELOCITY
	
	# Change animations
	if velocity.y < 0:
		haybail_sprite.texture = up_texture
		spring_sprite.texture = spring_up
	elif velocity.y > 0:
		haybail_sprite.texture = down_texture
		spring_sprite.texture = spring_down
	else:
		if is_on_floor():
			haybail_sprite.texture = idle_texture
			spring_sprite.texture = spring_down

	move_and_slide()
