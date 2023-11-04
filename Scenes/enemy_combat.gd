extends Node2D

var enemyHealth = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")
	$HealthBar.max_value = enemyHealth
	$HealthBar.value = enemyHealth


func _on_player_combat_damage(damage):
	enemyHealth -= damage
	$HealthBar.value = enemyHealth
	if enemyHealth <= 0:
		self.queue_free()
