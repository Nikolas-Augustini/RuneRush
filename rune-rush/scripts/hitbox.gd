class_name Hitbox extends Area2D

#var attacker_stats: Stats add in later for a proper stats system

var damage: int = 10 #temp damage for enemy

var hitbox_lifetime: float
var shape: Shape2D
#TODO::add hitbox logging


#setup initial values of the object
func _init(damage: int, hitbox_lifetime: float, shape: Shape2D) -> void:
	self.damage = damage
	self.hitbox_lifetime = hitbox_lifetime
	self.shape = shape

#says that the hitbox will be detecting other shapes rather than being detected by other shapes
func _ready() -> void:
	monitorable = false
	area_entered.connect(_on_area_entered)

#creates a timer so the hitbox auto-destructs after a fixed amount of time -- this will later be utilized for different bullet patterns and attacks
	if hitbox_lifetime > 0.0:
		var new_timer = Timer.new()
		add_child(new_timer)
		new_timer.timeout.connect(queue_free)
		new_timer.calldeferred("start", hitbox_lifetime)
		
#this will be utilized to assign the shape of the hitbox
	if shape:
		var collision_shape = CollisionShape2D.new()
		collision_shape = shape
		add_child(collision_shape)
	
#temporarily passes till we can detect a hurt box
func _on_area_entered(area: Area2D) -> void:
	pass
