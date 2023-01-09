extends Spatial

var isUpTime = 0
var time = 0
var isUp = false
var alive = true

var Botanist = int()
var Engineering = int()
var Chemistry = int()

var Class = "Survivant"

var Class_list = [
				"Survivant",  # Sans spé
				"Ingénieur",
				"Botaniste",
				"Chimiste"
				]

func _ready():
	pass # Replace with function body.

func dead():
	self.visible = false
	alive = false
	

func placing(var pos):
	if alive:
		self.transform.origin=pos
		isUpTime = time
		isUp = true
	
func up():
	time = Time.get_ticks_msec()
	if (time - isUpTime) > 100 and not isUp and alive:
		$Survivant_mesh.transform.origin.y = 1
		isUpTime = Time.get_ticks_msec()
		isUp = true
	pass

func _process(delta):
	time = Time.get_ticks_msec()
	if ((time - isUpTime) > 300 or not alive) and isUp:
		$Survivant_mesh.transform.origin.y = 0.5
		isUp = false
	pass
