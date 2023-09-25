extends "res://cards_database.gd"

var cardName = "Cleave"
var windowSize = DisplayServer.window_get_size()
@onready var cardInfo = DATA[get(cardName)]
@onready var cardImg = str("res://Art Assets/",cardInfo[0],"/",cardName,".png")
#@onready var cardInfo = Cards_Database.DATA[Cards_Database.get(cardName)]

func _ready():
	print(windowSize)
	print(cardImg)
	print(DATA[get(cardName)])
	var cardSize = $Card/Frame.texture.get_height()
	#load image
	$Card/CardImage.texture = load(cardImg) 
	#Scale image to fit border
	$Card/CardImage.scale *= cardSize/$Card/CardImage.texture.get_height() - 1
	#load name of card
	$Card/NameBackground/NameLabel.text = cardInfo[1]
	#load description
	$Card/DescriptionBox/MarginContainer/DescriptionLabel.text = cardInfo[2]
	#load mana cost
	$Card/ManaBox/MarginContainer/ManaLabel.text = str(cardInfo[3])
	#print(cardSize/$Card.texture.get_size())

	
#	print(cardInfo)
