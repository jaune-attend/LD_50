extends Node
export (PackedScene) var star_scene
export (PackedScene) var enemy_scene
onready var player = $Player
onready var star = $star
onready var start_position = $StartPosition
onready var teleporter = $Teleport
var score = 0

func _ready():
	init()

func init():
	player.hide()
	star.hide()
	teleporter.set_deferred('monitoring', false)
	teleporter.hide()


func invoke_star():
	var new_pos = star.get_new_position()
	var star = star_scene.instance()
	star.connect('collect', self, 'collect_star')
	call_deferred("add_child", star)
	star.position = new_pos

func invoke_teleport():
	var new_pos = star.get_new_position()
	teleporter.position = new_pos
	teleporter.set_deferred('monitoring', true)
	teleporter.show()


func spawn_enemy():
	var new_pos = star.get_new_position()
	var enemy = enemy_scene.instance()
	var enemy_spawn = get_node("Path/EnemySpawn")
	var direction = enemy_spawn.rotation + PI / 2
	
	call_deferred("add_child", enemy)
	enemy.position = new_pos
	direction += rand_range(-PI / 4, PI / 4)
	enemy.rotation = direction
	
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	enemy.linear_velocity = velocity.rotated(direction)

func collect_star():
	score += 1
	var i = 0
	if score < 6:
		invoke_star()
		while i < score:
			i += 1
			spawn_enemy()
		$HUD.update_score(score)
	else:
		print('score higher than 10')
		invoke_teleport()

func new_game():
	score = 0
	$StartTimer.start()
	yield($StartTimer, "timeout")
	player.start(start_position.position)
	player.show()
	star.show()
	$HUD.show_start()
	$HUD.update_score(score)

func game_over():
	
	$HUD.show_game_over()
	$DeathTimer.start()
	yield($DeathTimer, "timeout")
	player.queue_free()
	star.queue_free()

func _on_teleport():
	print('TELEPORT ')
	$HUD.show_teleport()
