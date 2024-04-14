extends CharacterBody2D


var SPEED = 20
@export var target: Vector2
@export var startPos: Vector2
var dir

func _ready():
	pass
	
# Get the gravity from the project settings to be synced with RigidBody nodes.



func _physics_process(delta):
	dir = (target - startPos).normalized()
	velocity = dir * SPEED
	
	

	move_and_slide()
