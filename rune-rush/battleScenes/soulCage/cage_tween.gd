extends Sprite2D
# This is the tweening script for when a fight sequence starts
func _ready():
	scale = Vector2(0.2, 0.2)

	var tween = get_tree().create_tween()

	tween.tween_property(self, "scale", Vector2(1,1), 0.7)
	tween.parallel().tween_property(self, "rotation", deg_to_rad(360), 0.7)

	# Spawn ghosts every 0.1 seconds
	var timer = Timer.new()
	timer.wait_time = 0.1
	timer.autostart = true
	timer.timeout.connect(spawn_ghost)
	add_child(timer)

#spawn ghost function
func spawn_ghost():
	#pulls from the original Sprite node to track its current movement
	var ghost = Sprite2D.new()
	ghost.texture = self.texture
	ghost.position = self.position
	ghost.scale = self.scale
	ghost.rotation = self.rotation
	ghost.modulate = Color(1, 1, 1, 0.4)

	get_parent().add_child(ghost)

	#adjusts the opacity, rotation, and scale of the ghost
	var ghost_tween = get_tree().create_tween()
	ghost_tween.tween_property(ghost, "modulate:a", 0.0, 0.4)
	ghost_tween.tween_property(ghost, "rotation", deg_to_rad(360), 0.7)
	ghost_tween.parallel().tween_property(ghost, "scale", Vector2(1,1), 0.7)
	ghost_tween.tween_callback(ghost.queue_free)
