extends Node2D

signal combatOver
@onready var cardBase = preload("res://Scenes/card_base.tscn")
var playerDeck = ["Cleave", "Claw", "Cleave"]
var deckSize = playerDeck.size()
var cardSelected

func _ready():
	combatOver.connect(endGame)
	
func _input(event):
	if Input.is_action_just_pressed("ui_leftClick"):
		var newCard = cardBase.instantiate()
		if deckSize == 0:
			combatOver.emit() #emitting a signal can be slow
		else:
			cardSelected = randi() % deckSize
			newCard.cardName = playerDeck[cardSelected]
			newCard.position = get_global_mouse_position()
			$Cards.add_child(newCard)
			playerDeck.erase(playerDeck[cardSelected])
			deckSize -= 1

func _process(delta):
	pass

func endGame(): #Shld ending a comabt be decided by the combat scne?
	print("hey")
	get_tree().change_scene_to_file("res://Scenes/World.tscn")
