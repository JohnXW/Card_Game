extends "res://Scripts/cards_database.gd"

var state = inHand
var cardName = "Claw"
var t:float = 0
var cardPos = position
var cardRot = 0
var windowSize = DisplayServer.window_get_size()
@onready var cardInfo = DATA[get(cardName)]
@onready var cardImg = str("res://Art Assets/",cardInfo[0],"/",cardName,".png")
#@onready var cardInfo = Cards_Database.DATA[Cards_Database.get(cardName)]

enum{
	reset,
	inHand,
	focusInHand,
	inMouse,
	placed
}


func _ready():
	var cardSize = size
#	print(windowSize)
#	print(cardImg)
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
		reset:
			t = 0
			position = cardPos
			rotation = cardRot
			scale = Vector2i(1,1)
			state = inHand

		inHand:
			pass
			
		focusInHand:
			rotation = 0
			position = Vector2(cardPos[0], cardPos[1]-30)
			scale = Vector2(1.3,1.3)
			if Input.is_action_just_pressed("ui_leftClick"):
				state = inMouse
#			t += delta/1
#			scale = scale.lerp(Vector2(2,2), t)
		inMouse:
			if Input.is_action_just_released("ui_leftClick"):
				state = placed
				
			else:
				position = Vector2(get_global_mouse_position().x - size.x/2, get_global_mouse_position().y - size.y/2)
		
		placed:
			state = reset
	
#	print(cardInfo)


func _on_focus_mouse_entered():
	if state != inMouse:
		state = focusInHand

func _on_focus_mouse_exited():
	if state != inMouse:
		state = reset
		


func _on_card_collision_area_entered(area):
	if area.name == "ActivateArea":
		$Card/ColorRect.visible = true


func _on_card_collision_area_exited(area):
	if area.name == "ActivateArea":
		$Card/ColorRect.visible = false
