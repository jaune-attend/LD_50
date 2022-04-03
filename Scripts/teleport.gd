extends Area2D
signal teleport

func _ready():
	$AnimationPlayer.play("teleport")


func _on_Teleport_area_entered(area):
	print('TELEPORT')
	emit_signal("teleport")
