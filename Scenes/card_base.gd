extends "res://cards_database.gd"

var cardName = "Cleave"
@onready var cardInfo = DATA[get(cardName)]
@onready var cardImg = str("res://Art Assets/",cardInfo[0],"/",cardName,".png")
#@onready var cardInfo = Cards_Database.DATA[Cards_Database.get(cardName)]

func _ready():
	print(cardImg)
	print(DATA[get(cardName)])
	var cardSize = $Frame.texture.get_height()
	$CardImage.texture = load(cardImg)
	$CardImage.scale *= cardSize/$CardImage.texture.get_height() - 1
#	print(cardSize/$Card.texture.get_size())
	
#	print(cardInfo)
