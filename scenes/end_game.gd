extends Node

onready var anim_up = $Anime_up
onready var anim_up2 = $Anime_up2
onready var anim_walk = $AnimeWalk
onready var anim_walk2 = $AnimeWalk2
onready var anime_play = $AnimationPlayer

func _ready():
	$AnimationPlayer.play("danse2")


func _process(delta):
	anim_up.animation = 'up'
	anim_up.play()
	anim_up2.animation = 'up'
	anim_up2.play()
	anim_walk.animation = 'walk'
	anim_walk.play()
	anim_walk2.animation = 'walk'
	anim_walk2.play()
	

	
