extends Node2D

var soldiers : Array
var numberOfAttacks: int
var smartAttacks: Array
var enemies: Array
var sliderValue: int
var smartAttack = preload("res://Prefabs/smartAttack.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Smart Attack"):
		
		var smartattackInstance = smartAttack.instantiate()
		get_tree().root.add_child(smartattackInstance)
