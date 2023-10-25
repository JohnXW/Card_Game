extends Node2D

signal combatOver

@onready var cardBase = preload("res://Scenes/card_base.tscn")
@onready var SCREENSIZE:Vector2 = get_viewport().content_scale_size
@onready var playerHandCentrePt = SCREENSIZE * Vector2(0.5, 1.25)
@onready var ovalRadiusH = SCREENSIZE.x * 0.4
@onready var ovalRadiusV = SCREENSIZE.y * 0.35
var ovalAngleVector = Vector2()
var playerDeck = ["Cleave", "Claw", "Cleave", "Claw"]
var deckSize = playerDeck.size()
var numCardsInHand: float = 0
var cardNum: int = 0
var cardAngle= deg_to_rad(90)
var cardSelected
var cardSpread = 0.4

func _ready():
	combatOver.connect(endGame)
	print(playerHandCentrePt)
	
func _input(event):
	if Input.is_action_just_pressed("ui_leftClick"):
		if deckSize == 0:
			combatOver.emit() #emitting a signal can be slow

func _process(delta):
	pass
	
func drawCard(drawNum):
#	cardAngle = PI/2 - cardSpread*((numCardsInHand/2) - numCardsInHand)
	for i in range(drawNum):
		var newCard = cardBase.instantiate()
		cardSelected = randi() % deckSize
		newCard.cardName = playerDeck[cardSelected]
	#	ovalAngleVector = Vector2(ovalRadiusH * cos(cardAngle), ovalRadiusV * sin(cardAngle))
	#	newCard.position = Vector2i(playerHandCentrePt - ovalAngleVector - newCard.size/2)
	#	newCard.rotation = (cardAngle - deg_to_rad(90)) / 2.5
	#	newCard.position = get_global_mouse_position()
		cardNum = 0
		$Cards.add_child(newCard)
		for cards in $Cards.get_children():
			cardAngle = PI/2 - cardSpread*((numCardsInHand/2) - cardNum)
			ovalAngleVector = Vector2(ovalRadiusH * cos(cardAngle), ovalRadiusV * sin(cardAngle))
			cards.position = Vector2i(playerHandCentrePt - ovalAngleVector - cards.size/2)
			cards.rotation = (cardAngle - deg_to_rad(90)) / 2.5
			cardNum += 1
		playerDeck.erase(playerDeck[cardSelected])
		numCardsInHand += 1
		deckSize -= 1
	#	cardAngle -= 0.2

func endGame(): #Shld ending a comabt be decided by the combat scne?
	print("hey")
	get_tree().change_scene_to_file("res://Scenes/World.tscn")



#when player attacks play the attack anim, after animation finshes animation.stop

func _on_texture_button_pressed():
	print("pressed")
	drawCard(2)
