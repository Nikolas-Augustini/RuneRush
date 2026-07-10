class_name Hurtbox extends Area2D

var health: int = 100

func _ready():
	add_to_group("player_hurtbox")

func apply_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		print("You died.")
		queue_free()
