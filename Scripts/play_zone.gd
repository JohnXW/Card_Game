extends Node2D


func _process(delta):
	$"FPS Counter/fps".text = str(Engine.get_frames_per_second())
