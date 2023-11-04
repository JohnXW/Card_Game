extends Node2D

signal combatOver
signal damage

@onready var cardBase = preload("res://Scenes/card_base.tscn")
@onready var SCREENSIZE:Vector2 = get_viewport().content_scale_size
@onready var playerHandCentrePt = SCREENSIZE * Vector2(0.5, 1.25)
@onready var ovalRadiusH = SCREENSIZE.x * 0.4
@onready var ovalRadiusV = SCREENSIZE.y * 0.35
var ovalAngleVector = Vector2()
var playerDeck = ["Cleave", "Claw", "Cleave", "Claw"]
var playerTotalStamina:int = 3
var playerStamina:int = 3
var deckSize = playerDeck.size()
var numCardsInHand: float = 0
var cardNum: int = 0
var cardAngle= deg_to_rad(90)
var cardDrawn
var cardHolding = null
var cardHoldingInfo
var cardSpread = 0.4

func _ready():
	combatOver.connect(endGame)
	print(playerHandCentrePt)
	drawCard(deckSize)
	$"Player Area/Deck/VBoxContainer/TextureRect/MarginContainer/Label".text = str(playerStamina) + "/" + str(playerTotalStamina)
	
func _input(event):
#	print(numCardsInHand)
	if Input.is_action_just_released("ui_leftClick"):
		if cardHolding != null:
			cardHoldingInfo = Cards_Database.DATA[Cards_Database.get(cardHolding)]
			if playerStamina >= cardHoldingInfo[3]:
				playerStamina -= cardHoldingInfo[3]
				$"Player Area/Deck/VBoxContainer/TextureRect/MarginContainer/Label".text = str(playerStamina)+ "/" + str(playerTotalStamina)
				print(cardHoldingInfo[4])
				damage.emit(cardHoldingInfo[4])
				for i in numCardsInHand:
					if $Cards.get_child(i).cardName == cardHoldingInfo[1]:
						$Cards.get_child(i).free()
						numCardsInHand -= 1
						organiseHand()
						break
			

func drawCard(drawNum):
#	cardAngle = PI/2 - cardSpread*((numCardsInHand/2) - numCardsInHand)
	for i in range(drawNum):
		var newCard = cardBase.instantiate()
		cardDrawn = randi() % deckSize
		newCard.cardName = playerDeck[cardDrawn]
	#	newCard.position = get_global_mouse_position()
		$Cards.add_child(newCard)
		numCardsInHand += 1
		organiseHand()
		playerDeck.erase(playerDeck[cardDrawn])
		deckSize -= 1
	#	cardAngle -= 0.2
	
func organiseHand():
	cardNum = 0
#	print($Cards.get_child_count())
	for cards in $Cards.get_children():
		cardAngle = PI/2 - cardSpread*(((numCardsInHand-1)/2) - cardNum)
		ovalAngleVector = Vector2(ovalRadiusH * cos(cardAngle), ovalRadiusV * sin(cardAngle))
		cards.position = Vector2i(playerHandCentrePt - ovalAngleVector - cards.size/2)
		cards.cardPos = cards.position
		cards.rotation = (cardAngle - deg_to_rad(90)) / 2.5
		cards.cardRot = cards.rotation
		cardNum += 1
#	for i in numCardsInHand:
#		cardAngle = PI/2 - cardSpread*(((numCardsInHand-1)/2) - cardNum)
#		ovalAngleVector = Vector2(ovalRadiusH * cos(cardAngle), ovalRadiusV * sin(cardAngle))
#		$Cards.get_child(i).position = Vector2i(playerHandCentrePt - ovalAngleVector - $Cards.get_child(i).size/2)
#		$Cards.get_child(i).cardPos = $Cards.get_child(i).position
#		$Cards.get_child(i).rotation = (cardAngle - deg_to_rad(90)) / 2.5
#		$Cards.get_child(i).cardRot = $Cards.get_child(i).rotation
#		cardNum += 1
			

func endGame(): #Shld ending a comabt be decided by the combat scne?
	get_tree().change_scene_to_file("res://Scenes/World.tscn")



#when player attacks play the attack anim, after animation finshes animation.stop

func _on_texture_button_pressed():
	if deckSize == 0:
		combatOver.emit() #emitting a signal can be slow


func _on_activate_area_area_entered(area):
	cardHolding = area.get_parent().cardName
		

func _on_activate_area_area_exited(area):
	cardHolding = null
