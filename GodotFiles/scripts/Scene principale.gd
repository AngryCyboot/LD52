extends Spatial

var turn = 0 #change me plz
var survivors = 15 #change me plz
var UI 

# [stock,max,prod,conso]

var food = [0,0,0,0]
var energy = [0,0,0,0]
var oxy = [0,0,0,0]
var water = [0,0,0,0]
var shit = [0,0,0,0]

func _ready():
	UI = $Camera/UI
	pass
	
func _process(delta):
	if UI.phase():
		UI.passTurn()
		turn += 1
	
	pass
