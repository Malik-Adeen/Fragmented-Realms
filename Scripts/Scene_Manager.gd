extends Node

var scene_transition_scene = preload("res://UI/ScreenTransition/scene_transition_layer.tscn")

#var scenes : Dictionary = { "Level1" : "res://Levels/level_1.tscn" , 
							#"Level2" : "res://Levels/level_2.tscn"  } 


class TreeNode:
	var level_name: String
	var scene_path: String
	var children: Array

	func _init(level_name: String, scene_path: String):
		self.level_name = level_name
		self.scene_path = scene_path
		self.children = [] 
#will hold the child nodes i.e other nodes with scene or level paths 


class LevelTree:
	var root: TreeNode

	func _init():
		root = null

	func add_level(parent_name: String, level_name: String, scene_path: String):
		if root == null: 
#			the reason for passing a null string here to add the first level here as root
			root = TreeNode.new(level_name, scene_path)
		else:
			var parent_node = find_node(root, parent_name)
			if parent_node:
				parent_node.children.append(TreeNode.new(level_name, scene_path))
	func find_node(node: TreeNode, level_name: String) -> TreeNode:
		if node.level_name == level_name:
			return node
		for child in node.children:
			var result = find_node(child, level_name)
			if result != null:
				return result
		return null

	func get_scene_path(level_name: String) -> String:
		var node = find_node(root, level_name)
		return node.scene_path if node else ""


#creating a obj of tree i.e scene tree
var level_tree = LevelTree.new()

func _ready():
	# Initialize the tree structure
	level_tree.add_level( "", "Level1", "res://Levels/level_1.tscn")  # Root node
	level_tree.add_level("Level1", "Level2", "res://Levels/level_2.tscn")  # Child of Level1

func transition_to_scene(level: String):
	var scene_path: String = level_tree.get_scene_path(level)

	if scene_path != "":
		var scene_transition_screen_instance = scene_transition_scene.instantiate()
		get_tree().get_root().add_child(scene_transition_screen_instance)
		await get_tree().create_timer(3.0).timeout
		get_tree().change_scene_to_file(scene_path)
		if InventoryManager.has_inventory_item("Key"):
			print("Key found")
		InventoryManager.remove_from_inventory("Key")
		scene_transition_screen_instance.queue_free()
	else:
		print("No more level to play")
		InventoryManager.remove_from_inventory("Key")
		GameManager.main_menu()



#old method without tree

#func transition_to_scene(level : String):
	#var scene_path : String = scenes.get(level , "")
	#
	#if scene_path != "" : 
		#var scene_transition_screen_instance = scene_transition_scene.instantiate()
		#get_tree().get_root().add_child(scene_transition_screen_instance)
		#await get_tree().create_timer(3.0).timeout
		#get_tree().change_scene_to_file(scene_path)
		#InventoryManager.remove_from_inventory("Key")
		#scene_transition_screen_instance.queue_free()
		#
	#else:
		#print("No more level to play")
		#GameManager.main_menu()
