extends Node2D

const cardBase = preload("res://Scenes/card_base.tscn")
const playerHand = preload("res://Scripts/player_hand.gd")
var bruh = ["Cleave", "Claw"]

func _input(event):
	if Input.is_action_just_pressed("ui_leftClick"):
		var newCard = cardBase.instantiate()
		newCard.cardName = bruh[randi_range(0,bruh.size()-1)]
		newCard.position =get_global_mouse_position()
		$Cards.add_child(newCard)
		
#func _process(delta):
#	print(Engine.get_frames_per_second())
