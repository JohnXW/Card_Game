extends Camera2D

@export var tileMap: TileMap
const SCREEN_SIZE = Vector2(816, 480)
var cur_screen = Vector2(0, 0)

#func _ready():
#	var mapSize = tileMap.get_used_rect()
##	print(mapSize)
#	var tileSize = tileMap.cell_quadrant_size
##	print(tileSize)
#	var worldSizePixels = mapSize.size * (tileSize*3)
#	limit_right = worldSizePixels.x
#	limit_bottom = worldSizePixels.y
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _ready():
	global_position = $"../Player".global_position

func _physics_process(delta):
	var parent_screen: Vector2 = ($"../Player".global_position / SCREEN_SIZE).floor()
	if not parent_screen.is_equal_approx(cur_screen):
		update_screen(parent_screen)

func update_screen(new_screen: Vector2):
	cur_screen = new_screen
	global_position = cur_screen * SCREEN_SIZE + SCREEN_SIZE * 0.5
