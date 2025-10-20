extends CharacterBody2D

@export var speed: float = 300.0

signal out_of_bounds

func start() -> void:
	position = get_viewport_rect().size / 2 # middle of screen
	
	var direction_x: float = 1.0 if randf() < 0.5 else -1.0 # left or right
	var direction_y: float = randf_range(-0.5, 0.5) # slightly up or down, otherwise it goes of screen
	
	velocity = Vector2(direction_x, direction_y).normalized() * speed

func _ready() -> void:
	start()
	
func _physics_process(delta: float) -> void:
	if position.x < 0 or position.x > get_viewport_rect().size.x: # check if it went of the sides
		out_of_bounds.emit()
		start()
	
	if position.y < 0 and velocity.y < 0:
		velocity = velocity.bounce(Vector2(0,1)) 
	elif position.y > get_viewport_rect().size.y and velocity.y > 0:
		velocity = velocity.bounce(Vector2(0,-1))
		
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		
		var collision_object: CollisionObject2D = collision.get_collider()
		if collision_object.is_in_group("paddles"):
			velocity *= 1.05 # increase speed by 0.05
