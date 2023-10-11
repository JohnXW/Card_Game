extends CharacterBody2D

class_name Player

signal healthChange
@export var speed: int = 100
@onready var animations = $AnimationPlayer


var playerHurt:bool = false
var movedirection
var direction = "down"
var playerAttackingInProgress:bool = false


func handleInput():
	movedirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = movedirection * speed

func updateAnimation(): 
	if velocity.length() == 0:
		animations.stop()
	
	else:
		if velocity.x < 0: 
			direction = "left"

		elif velocity.x > 0: 
			direction = "right"

		elif velocity.y > 0:
			direction = "down"

		elif velocity.y < 0: 
			direction = "up"

		animations.play("walk_" + direction)
	

		
	
func _physics_process(delta):
	handleInput()
	move_and_slide()
	updateAnimation()

