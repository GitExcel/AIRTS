extends Node2D

var soldiers : Array
var numberOfAttacks: int
var smartAttacks: Array
var enemies: Array
var sliderValue: int
var defendOn = false
var smartAttack = preload("res://Prefabs/smartAttack.tscn")
var smartDefend = preload("res://Prefabs/smart_defend.tscn")
@onready var infoBox = get_tree().get_first_node_in_group("InfoBox")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Smart Attack"):
		infoBox.makeText("[center]  SMART ATTACK CREATED")
		
		var smartattackInstance = smartAttack.instantiate()
		get_parent().add_child(smartattackInstance)
	if Input.is_action_just_pressed("defend"):
		defendOn = !defendOn

func defend(enemy):
	var smartDefendInstance = smartDefend.instantiate()
	infoBox.makeText("[center]  SMART DEFEND CREATED")
	smartDefendInstance.target = enemy
	get_parent().add_child(smartDefendInstance)
