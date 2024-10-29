extends Resource

# The tutorial I'm watching chooses to create the inventory system as a resource because
# then we can paste the inventory system onto many things like characters and chests
# in our case this is overkill, but oh well
class_name Inv

signal update

@export var items: Array[InvItem]


# takes item resource and an index to add to inventory
func insert(item: InvItem, idx):
	print('testing call to insert function')
	items[idx] = item
	update.emit()


func check_for_item(idx):
	if items[idx]:
		return true
	else:
		return false

func use(idx):
	items.remove_at(idx)
	update.emit()
