extends "res://Scripts/cards_database.gd"

var cardName = "Claw"
var windowSize = DisplayServer.window_get_size()
@onready var cardInfo = DATA[get(cardName)]
@onready var cardImg = str("res://Art Assets/",cardInfo[0],"/",cardName,".png")
#@onready var cardInfo = Cards_Database.DATA[Cards_Database.get(cardName)]

func _ready():
#	print(windowSize)
#	print(cardImg)
#	print(DATA[get(cardName)])
	var cardSize:float = $Card/Frame.texture.get_height()
	#load image
	$Card/Frame/CardImage.texture = load(cardImg) 
	#Scale image to fit border
	$Card/Frame/CardImage.scale *= (cardSize-14)/($Card/Frame/CardImage.texture.get_height())
	#load name of card
	$Card/DescriptionBox/VBoxContainer/TitleLabel.text = cardInfo[1]
	#load description
	$Card/DescriptionBox/VBoxContainer/DescriptionLabel.text = cardInfo[2]
	#load mana cost
	$Card/ManaBox/MarginContainer/ManaLabel.text = str(cardInfo[3])
	#print(cardSize/$Card.texture.get_size())

	
#	print(cardInfo)
