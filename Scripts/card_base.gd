extends "res://Scripts/cards_database.gd"

var state = inHand
var cardName = "Claw"
var windowSize = DisplayServer.window_get_size()
@onready var cardInfo = DATA[get(cardName)]
@onready var cardImg = str("res://Art Assets/",cardInfo[0],"/",cardName,".png")
#@onready var cardInfo = Cards_Database.DATA[Cards_Database.get(cardName)]


enum{
	inHand,
	focusInHand
}


func _ready():
	var cardSize = size
#	print(windowSize)
#	print(cardImg)
#	print(DATA[get(cardName)])
	var frameSize:float = $Frame.texture.get_height()
	#load image
	$Frame/CardImage.texture = load(cardImg) 
	#Scale image to fit border
	$Frame/CardImage.scale *= (frameSize-14)/($Frame/CardImage.texture.get_height())
	#load name of card
	$DescriptionBox/VBoxContainer/TitleLabel.text = cardInfo[1]
	#load description
	$DescriptionBox/VBoxContainer/DescriptionLabel.text = cardInfo[2]
	#load mana cost
	$ManaBox/MarginContainer/ManaLabel.text = str(cardInfo[3])
#	$Focus.texture_hover = load("res://Art Assets/Attacks/Arrow.png")
	$Focus.scale *= cardSize/$Focus.size
	
func _physics_process(delta):
	match state:
		inHand:
			pass
		focusInHand:
			pass

	
#	print(cardInfo)


func _on_focus_mouse_entered():
	print(self.name)
	self.scale = Vector2(3,3)



func _on_focus_mouse_exited():
	self.scale = Vector2(1,1)
