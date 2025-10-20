extends Node2D

var score_left = 0
var score_right = 0

@onready var ball: CharacterBody2D = $Ball
@onready var label: Label = $CanvasLayer/Control/Label


func _ready() -> void:
	ball.out_of_bounds.connect(_on_ball_out_of_bounds)
	
	new_game()
	
func new_game():
	score_left = 0
	score_right =0
	update_score_display()
	ball.start()

func update_score_display():
	label.text = str(score_left) + " - " + str(score_right)

func _on_ball_out_of_bounds() -> void:
	if ball.position.x < get_viewport_rect().size.x / 2:
		# then it was on the left
		score_right += 1
	else:
		score_left += 1
		
	update_score_display()
