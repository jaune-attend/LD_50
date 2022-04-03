extends Area2D
signal collect
var score
var screen_size


func get_new_position():
	screen_size = get_viewport_rect().size
	randomize()
	var x_random = Vector2(0, screen_size.x)
	var y_random = Vector2(0, screen_size.y)

	var x = randi() % int(x_random[1]- x_random[0]) + 1 + x_random[0] 
	var y =  randi() % int(y_random[1]-y_random[0]) + 1 + y_random[0]
	var random_pos = Vector2(x, y)
	position=random_pos
	return position

func _ready():
	get_new_position()
	show()
	$CollisionShape2D.set_deferred('disabled', false)

func _on_Star_area_entered(area):
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	emit_signal('collect')
