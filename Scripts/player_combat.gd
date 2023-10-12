extends Node2D

signal combatOver

@onready var cardBase = preload("res://Scenes/card_base.tscn")
@onready var SCREENSIZE:Vector2 = get_viewport().content_scale_size
@onready var playerHandCentrePt = SCREENSIZE * Vector2(0.5, 1.25)
@onready var ovalRadiusH = SCREENSIZE.x * 0.4
@onready var ovalRadiusV = SCREENSIZE.y * 0.35
var ovalAngle = deg_to_rad(90)
var ovalAngleVector = Vector2()
var playerDeck = ["Cleave", "Claw", "Cleave"]
var deckSize = playerDeck.size()
var cardSelected

func _ready():
	combatOver.connect(endGame)
	print(playerHandCentrePt)
	
func _input(event):
	if Input.is_action_just_pressed("ui_leftClick"):
		if deckSize == 0:
			combatOver.emit() #emitting a signal can be slow
		else:
			drawCard()

func _process(delta):
	pass
	
func drawCard():
	var newCard = cardBase.instantiate()
	cardSelected = randi() % deckSize
	newCard.cardName = playerDeck[cardSelected]
	ovalAngleVector = Vector2(ovalRadiusH * cos(ovalAngle), ovalRadiusV * sin(ovalAngle))
	newCard.position = playerHandCentrePt - ovalAngleVector - newCard.size/2
	newCard.rotation = (ovalAngle - deg_to_rad(90)) / 2.5
#	newCard.position = get_global_mouse_position()
	$Cards.add_child(newCard)
	playerDeck.erase(playerDeck[cardSelected])
	deckSize -= 1
	ovalAngle -= 0.2

func endGame(): #Shld ending a comabt be decided by the combat scne?
	print("hey")
	get_tree().change_scene_to_file("res://Scenes/World.tscn")
