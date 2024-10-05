extends StaticBody2D

var win_height : int
var p_height : int

var velocity : Vector2 = Vector2.ZERO

var jump_height : float = 100
var jump_time_to_peak : float = 0.2
var jump_time_to_descent : float = 0.4

var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0


# Called when the node enters the scene tree for the first time.
func _ready():
	win_height = get_viewport_rect().size.y
	p_height = $ColorRect.get_size().y

func getGravity() -> float:
	if velocity.y < 0.0:
		return jump_gravity
	else:
		return fall_gravity

#func _physics_process(delta):
	#velocity.y += get_gravity() * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("jump")  and position.y == 324: #If it is at base position
		jump()
	
	
func jump():
	velocity.y = jump_velocity
