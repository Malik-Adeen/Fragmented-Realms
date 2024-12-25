extends Node

var Inventory : Dictionary

func add_to_inventory(type : String , value : String):
	Inventory[type] = value
	
	
func has_inventory_item(value : String) -> bool :
	if value == null:
		return false 
	var item = Inventory.find_key(value)
	
	if item:
		return true
		
	return false

func remove_from_inventory(value : String) -> void : 
	if value == null : 
		return 
		
	Inventory.erase(value)
	print("key removed")
	
	

#class InventoryNode:
	#var item: String
	#var value: int
	#var next: InventoryNode  # Points to the next node in the list
#
	#func _init(item: String, value: int = 0):
		#self.item = item
		#self.value = value
		#self.next = null  # The next node is initially null
#
#class InventoryLinkedList:
	#var head: InventoryNode  # The first node in the list
#
	#func _init():
		#head = null
#
	# Add an item to the end of the inventory
	#func add_to_inventory(item: String, value: int = 0):
		#var new_node = InventoryNode.new(item, value)
		#if head == null:  # If the list is empty
			#head = new_node
		#else:
			#var current = head
			#while current.next != null:
				#current = current.next
			#current.next = new_node  # Append to the end
		#print("Added item: ", item, " with value: ", value)
#
	# Remove an item from the inventory
	#func remove_from_inventory(item: String):
		#var current = head
		#var previous = null
#
		#while current != null:
			#print("Checking node with item: ", current.item)  # Debug: Print the current item
			#if current.item == item:
				#if previous == null:  # If it's the first node
					#head = current.next
				#else:
					#previous.next = current.next
				#print(item + " removed from inventory")
				#return  # Item removed, exit the function
			#previous = current
			#current = current.next
#
		#print(item + " not found in inventory")
#
	# Check if the inventory contains an item
	#func has_inventory_item(item: String) -> bool:
		#var current = head
		#while current != null:
			#if current.item == item:
				#print("Yes it has that key")
				#return true
			#current = current.next
		#print("does not have the key")
		#return false
#
	#Print all items in the inventory
	#func print_inventory():
		#var current = head
		#if current == null:
			#print("Inventory is empty.")
			#return
#
		#print("Inventory items:")
		#while current != null:
			#print("Item: ", current.item, ", Value: ", current.value)
			#current = current.next
#
#var inventory: InventoryLinkedList
#
#func _ready():
	#inventory = InventoryLinkedList.new()
#
#func add_to_inventory(type : String , value : String):
	#inventory.add_to_inventory(value)
#
#func has_inventory_item(value : String) -> bool:
	#return inventory.has_inventory_item(value)
#
#func remove_from_inventory(value : String) -> void:
	#inventory.remove_from_inventory(value)
#
#
#
#
