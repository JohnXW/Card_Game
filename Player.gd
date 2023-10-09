extends Node2D

@onready var cardBase = preload("res://Scenes/card_base.tscn")
var playerDeck = ["Cleave", "Claw", "Cleave"]
var deckSize = playerDeck.size()
var cardSelected

func _input(event):
	if Input.is_action_just_pressed("ui_leftClick"):
		var newCard = cardBase.instantiate()
		cardSelected = randi() % deckSize
		newCard.cardName = playerDeck[cardSelected]
		newCard.position = get_global_mouse_position()
		$Cards.add_child(newCard)
		playerDeck.erase(playerDeck[cardSelected])
		deckSize -= 1

func _process(delta):
	pass
