extends Area2D

@onready var resourcestore = get_tree().get_first_node_in_group("resourceStore")
var health = 3
var respawnZone


# Called when the node enters the scene tree for the first time.
func _ready():
	resourcestore.gasNodes.append(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health == 0:
		resourcestore.gasNodes.erase(self)
		respawnZone.respawn("GAS")
		queue_free()


func _on_body_entered(body):
	if body.target == self:
		health -= 1
		body.haveResource = true
		body.moveToResource = false
		body.typeHolding = "GAS"
