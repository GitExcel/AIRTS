extends Node2D
var minerals = 0
var gas = 0
var mineralNodes: Array
var gasNodes: Array
var workers: Array
var buildings: Array
var mineralWorkers: Array
var gasWorkers: Array
@onready var gastext = get_tree().get_first_node_in_group("gasText")
@onready var mineraltext = get_tree().get_first_node_in_group("mineralText")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	gastext.text = "Gas: " + str(gas) 
	mineraltext.text = "Minerals: " + str(minerals) 
	if workers.size() >= 1:
		for i in workers.size():
			if mineralWorkers.size() > gasWorkers.size():
				gasWorkers.append(workers[i])
				workers[i].group = "GAS"
				workers.erase(workers[i])
				
				print("+1 gas worker")
			else:
				mineralWorkers.append(workers[i])
				workers[i].group = "MINERAL"
				workers.erase(workers[i])
				print("+1 mineral worker")
				
				workers
			
func addGas():
	if mineralWorkers.size() > 0:
		gasWorkers.append(mineralWorkers[0])
		mineralWorkers[0].group = "GAS"
		mineralWorkers.erase(mineralWorkers[0])
		
func addMineral():
	if gasWorkers.size() > 0:
		mineralWorkers.append(gasWorkers[0])
		gasWorkers[0].group = "MINERAL"
		gasWorkers.erase(gasWorkers[0])


func _on_button_pressed():
	gas += 100


func _on_button_2_pressed():
	minerals += 100
