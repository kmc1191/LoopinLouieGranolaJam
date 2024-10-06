extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0

@onready var haybail_sprite = $Sprite2D
@onready var spring_sprite = $"../Spring"

var spring_global_position = Vector2()

var idle_texture = preload("res://assets/HaybaleStationary.png")
var up_texture = preload("res://assets/HaybaleUp.png")
var down_texture = preload("res://assets/HaybaleDown.png")
var spring_down_texture = preload("res://assets/SpringDown.png")
var spring_up_texture = preload("res://assets/SpringExtended.png")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_key_pressed(KEY_SPACE) and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Change animations
	if velocity.y < 0:
		haybail_sprite.texture = up_texture
		spring_sprite.texture = spring_up_texture
	elif velocity.y > 0:
		haybail_sprite.texture = down_texture
		spring_sprite.texture = spring_down_texture
	else:
		if is_on_floor():
			haybail_sprite.texture = idle_texture
			spring_sprite.texture = spring_down_texture

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
