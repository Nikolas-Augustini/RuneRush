class_name Hitbox extends Area2D

#var attacker_stats: Stats add in later for a proper stats system

var damage: int = 10 #temp damage for enemy

var hitbox_lifetime: float
var shape: Shape2D
#TODO::add hitbox logging


#setup initial values of the object
func _init(damage: int, hitbox_lifetime: float, shape: Shape2D) -> void:
	damage = damage
	hitbox_lifetime = hitbox_lifetime
	shape = shape

#says that the hitbox will be detecting other shapes rather than being detected by other shapes
func _ready() -> void:
	monitorable = false
	area_entered.connect(_on_area_entered)
	
#temporarily passes till we can detect a hurt box
func _on_area_entered(area: Area2D) -> void:
	pass
