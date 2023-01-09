extends Spatial

var turn = 0 #change me plz
var end = 50
var survivors = 0 #change me plz
var UI 

# [0stock,1max,2prod,3conso,4frozen*] conso is only for UI

var food = [10,0,0,0]
var energy = [10,0,0,0]
var oxy = [10,0,0,0]
var water = [10,0,0,0,0]
var shit = [0,0,0,0,0]
var allTheThings

func _ready():
	UI = $Camera/UI
	survivors = $Survivors.get_child_count()
	allTheThings = [energy,oxy,shit,water,food,turn,survivors]
	UI.initialise(end)
	pass

func kill(nb):
	while nb < 0:
		var dead = $Survivors.get_child((Time.get_ticks_msec() % survivors))
		dead.dead()
		$Survivors.remove_child(dead)
		self.add_child(dead)
		nb +=1
		survivors = $Survivors.get_child_count()
	pass
	
func endTurn():
	var losses = 0
	turn += 1
	#buildings
	#survivors
	if food[0] + food[2] < survivors :
		losses = food[0] + food[2] - survivors
	if oxy[0] + oxy[2] < survivors + losses :
		losses = oxy[0] + oxy[2] - survivors
	if water[0] + water[2] < survivors + losses :
		losses = water[0] + water[2] + survivors
	if energy[0] + energy[2] < survivors + losses :
		losses = energy[0] + energy[2] + survivors
	
	shit[2] += survivors - losses #hehe ^^
	kill(losses)
	food[2] -= survivors
	oxy[2] -= survivors
	water[2] -= survivors
	energy[2] -= survivors
	
	#Final calculations
	
	if food[2] + food[0] > food[1]:
		food[0] = food[1]
	else:
		food[0] += food[2]
	food[2] = 0

	if oxy[2] + oxy[0] > oxy[1]:
		oxy[0] = oxy[1]
	else:
		oxy[0] += oxy[2]
	oxy[2] = 0

	if energy[2] + energy[0] > energy[1]:
		energy[0] = energy[1]
	else:
		energy[0] += energy[2]
	energy[2] = 0

	water[2] += water[4]
	water[4] = 0
	if water[2] + water[0] > water[1]:
		water[4] += water[2] + water[0] - water[1]
		water[0] = water[1]
	else:
		water[0] += water[2]
	water[2] = 0

	shit[2] += shit[4]
	shit[4] =0
	if shit[2] + shit[0] > shit[1]:
		shit[4] += shit[2] + shit[0] - shit[1]
		shit[0] = shit[1]
	else:
		shit[0] += shit[2]
	shit[2] = 0




func _process(delta):
	allTheThings = [energy,oxy,shit,water,food,turn,survivors]
	UI.update(allTheThings)
	if UI.phase():
		endTurn()
		UI.passTurn()
		food[3] = survivors
		water[3] = survivors
		oxy[3] = survivors
		energy[3] = survivors
		shit[2] = survivors
	pass
