extends AnimatedSprite2D


func _on_timer_timeout() -> void:
	#print("impact deleted")
	queue_free()
