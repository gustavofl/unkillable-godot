extends Node

func reviver_filhos():
	for child in get_children():
		child.reviver()