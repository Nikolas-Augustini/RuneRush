class_name Hitbox extends Area2D

#var attacker_stats: Stats add in later for a proper stats system

var damage: int = 10 #temp damage for enemy
var hitbox_lifetime: float
var shape: Shape2D
var owner_group: String
#TODO::add hitbox logging


#setup initial values of the object
func _init(p_damage: int, p_hitbox_lifetime: float, p_shape: Shape2D, p_owner_group: String) -> void:
	self.damage = p_damage
	self.hitbox_lifetime = p_hitbox_lifetime
	self.shape = p_shape
	self.owner_group = p_owner_group

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
		collision_shape.shape = shape
		add_child(collision_shape)
	
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	
	
#detects if the hitbox entered is in the bullet group. then detects if it is set to apply damage as not all bullets are set to damage the soul
func _on_area_entered(area: Area2D) -> void:
	if owner_group == "bullet":
		if area.is_in_group("player_hurtbox"):
			if area.has_method("apply_damage"):
				print("damage taken!")
				area.apply_damage(damage)
