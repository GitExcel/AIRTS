extends Node2D
@onready var markerx = $Markerx
@onready var markery = $Markery

@onready var mineral = preload("res://Prefabs/mineral.tscn")
@onready var gas = preload("res://gas.tscn")
var doonce = true


# Called when the node enters the scene tree for the first time.
func _ready():
	for m in 3:
		
		var mineral1 = mineral.instantiate()
		get_parent().add_child(mineral1)
		mineral1.position = Vector2(randf_range(self.global_position.x, markerx.global_position.x),
		randf_range(self.global_position.y, markery.global_position.y))
		mineral1.respawnZone = self
	for g in 3:
		var gas1 = gas.instantiate()
		get_parent().add_child(gas1)
		gas1.position = Vector2(randf_range(self.global_position.x, markerx.global_position.x),
		randf_range(self.global_position.y, markery.global_position.y))
		gas1.respawnZone = self
		
		

func _process(delta):
	if doonce:
		doonce = false
		for m in 3:
			
			var mineral1 = mineral.instantiate()
			get_parent().add_child(mineral1)
			mineral1.position = Vector2(randf_range(self.global_position.x, markerx.global_position.x),
			randf_range(self.global_position.y, markery.global_position.y))
			mineral1.respawnZone = self
		for g in 3:
			var gas1 = gas.instantiate()
			get_parent().add_child(gas1)
			gas1.position = Vector2(randf_range(self.global_position.x, markerx.global_position.x),
			randf_range(self.global_position.y, markery.global_position.y))
			gas1.respawnZone = self
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.

		
func respawn(type):
	if type == "MINERAL":
		var mineral1 = mineral.instantiate()
		get_parent().add_child(mineral1)
		mineral1.position = Vector2(randf_range(self.global_position.x, markerx.global_position.x),
		randf_range(self.global_position.y, markery.global_position.y))
		mineral1.respawnZone = self
	if type == "GAS":
		var gas1 = gas.instantiate()
		get_parent().add_child(gas1)
		gas1.position = Vector2(randf_range(self.global_position.x, markerx.global_position.x),
		randf_range(self.global_position.y, markery.global_position.y))
		gas1.respawnZone = self
		
	
