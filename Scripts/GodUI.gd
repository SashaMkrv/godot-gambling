extends Control


onready var time := $"/root/Time"

var mode := "Slots"

func _ready():
	swapMode()


func swapMode():
	match mode:
		"Slots":
			openSlots()
		"Shop":
			openInventory()
		_:
			print("What is this mode, " + mode)


func _on_Timer_timeout():
	time.tick()


func openSlots():
	get_tree().paused = false
	$Timer.paused = false
	$MarginContainer/VBoxContainer/BottomBar.visible = true
	$MarginContainer/VBoxContainer/SlotWrapper.visible = true
	$MarginContainer/VBoxContainer/ShopUI.visible = false
	$MarginContainer/VBoxContainer/TopBarStatsUI/InventoryClose.visible = false
	$MarginContainer/VBoxContainer/TopBarStatsUI/InventoryOpen.visible = true


func openInventory():
	get_tree().paused = true
	$Timer.paused = true
	$MarginContainer/VBoxContainer/BottomBar.visible = false
	$MarginContainer/VBoxContainer/SlotWrapper.visible = false
	$MarginContainer/VBoxContainer/ShopUI.visible = true
	$MarginContainer/VBoxContainer/TopBarStatsUI/InventoryClose.visible = true
	$MarginContainer/VBoxContainer/TopBarStatsUI/InventoryOpen.visible = false
	


func _on_InventoryOpenButton_pressed():
	openInventory()


func _on_InventoryCloseButton_pressed():
	openSlots()
