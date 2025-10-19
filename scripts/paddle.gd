extends CharacterBody2D

@export var speed: float = 600.0
@export var left_player: bool = false

var up_action
var down_action

func _ready() -> void:
	add_to_group("paddles") # used to check collisions for the ball
	up_action = "p1_up" if left_player else "p2_up"
	down_action = "p1_down" if left_player else "p2_down"

	
func _physics_process(delta: float) -> void:
	var direction = 0
	if Input.is_action_pressed(up_action):
		direction = -1
	elif Input.is_action_pressed(down_action):
		direction = 1

	velocity.y = direction * speed
	
	move_and_slide()
	
	# stop the paddle from going offscreen
	var viewport_size = get_viewport_rect().size
	var paddle_height = $CollisionShape2D.shape.size.y
	position.y = clamp(position.y, paddle_height/2, viewport_size.y - (paddle_height/2))
	
