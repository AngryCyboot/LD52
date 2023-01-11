extends Spatial

var turn = 0 #change me plz
export var end = 50
var survivors = 0 #change me plz
var UI 

# [0stock,1max,2prod,3conso,4frozen*] conso is only for UI

export var food = [75,0,0,0]
export var energy = [10,0,0,0]
export var oxy = [10,0,0,0]
export var water = [10,0,0,0,0]
export var shit = [0,0,0,0,0]
var allTheThings
var prod
var fields
var storage

func _ready():
	UI = $Camera/UI
	survivors = $Survivors.get_child_count()
	allTheThings = [energy,oxy,shit,water,food,turn,survivors]
	UI.initialise(end)
	prod = $Base.get_child(0)
	fields = $Champ.get_child(0)
	storage = $Base.get_child(1)
	for x in prod.get_children():
		x.connect("scream",self,"cracotte") 
	
	pass

func kill(nb):
	if nb < survivors * -1:
		nb = survivors * -1
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
	food[2] = 0
	oxy[2] = 0
	water[2] = 0
	energy[2] = 0
	shit[2] = 0
	turn += 1
	#buildings
	for x in prod.get_children():
		var data = x.status()
		if data[8] and data[5] or not data[8]:
			if data[6] :
				x.repair()
			else:
				energy[2] += data[0]
				oxy[2] += data[1]
				shit[2] += data[2]
				water[2] += data[3]
				food[2] += data[4]
	for x in fields.get_children():
		var data = x.status()
		if data[5]:
			x.grow()
	
	energy[1] = 60
	oxy[1] = 60
	food[1] = 60
	water[1] = 60
	shit[1] = 60
	for x in storage.get_children():
		var data = x.status()
		if data[6] and data[5]:
			x.repair()
		elif not data[6]:
			if x.name == "Batteries":
				energy[1] += 60
			if x.name == "FoodStorage":
				food[1] += 60
			if x.name == "OxygenStorage":
				oxy[1] += 60
			if x.name == "ShitStorage":
				shit[1] += 60
			if x.name == "WaterStorage":
				water[1] += 60
	#survivors
	if food[0] + food[2] < survivors :
		losses = food[0] + food[2] - survivors
	if oxy[0] + oxy[2] < survivors + losses :
		losses = oxy[0] + oxy[2] - survivors
	if water[0] + water[2] < survivors + losses :
		losses = water[0] + water[2] - survivors
	if energy[0] + energy[2] < survivors + losses :
		losses = energy[0] + energy[2] - survivors
	
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

func cracotte():
	food[2] = 0
	water[2] = 0
	shit[3] = 0
	oxy[2] = 0
	energy[2] = 0
	food[3] = survivors * -1
	water[3] = survivors * -1
	oxy[3] = survivors * -1
	energy[3] = survivors * -1
	shit[2] = survivors
	for x in prod.get_children():
		var data = x.status()
		if (data[5] or not data[8]) and not data[6]:
			if data[0] > 0:
				energy[2] += data[0]
			else :
				energy[3] += data[0]
			if data[1] > 0:
				oxy[2] += data[1]
			else :
				oxy[3] += data[1]
			if data[2] > 0:
				shit[2] += data[2]
			else :
				shit[3] += data[2]
			if data[3] > 0:
				water[2] += data[3]
			else :
				water[3] += data[3]
			if data[4] > 0:
				food[2] += data[4]
			else :
				food[3] += data[4]

func _process(delta):
	allTheThings = [energy,oxy,shit,water,food,turn,survivors]
	UI.update(allTheThings)
	if UI.phase():
		endTurn()
		allTheThings = [energy,oxy,shit,water,food,turn,survivors]
		UI.update(allTheThings)
		UI.passTurn()
	pass
