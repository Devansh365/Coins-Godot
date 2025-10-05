extends StaticBody3D

var coinhave := 0
var coin_slots := []
var coinplaced := 0
var done = false

func _ready() -> void:
	# Connect the pickup signal
	Signalman.coinpicked.connect(coinpicked)
	
	# Store references to all coin nodes on the door
	coin_slots = [
		$"../coin1",
		$"../coin2",
		$"../coin3"
	]
	
	# Make sure all start hidden
	for slot in coin_slots:
		slot.visible = false


func interact() -> void:
	# Player interacts with the door
	if coinhave > 0:
		# Find the first invisible coin slot to fill
		for slot in coin_slots:
			if not slot.visible:
				slot.visible = true
				coinhave -= 1
				coinplaced += 1
				Signalman.coinplaced.emit()
				return  # Stop after placing one coin
		
		# If all slots are already visible
	if coinplaced == 3:
		if done == false:
		
			$"../../AnimationPlayer".play("open")
			done = true



func coinpicked() -> void:
	# Called when a coin is picked up
	if coinhave < coin_slots.size():
		coinhave += 1
