extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var health = 100
@export var gameover: CanvasLayer

# Get the gravity from the project settings to be synced with RigidBody nodes.



func _physics_process(delta):
	if health == 0:
		gameover.visible = true
		

	
