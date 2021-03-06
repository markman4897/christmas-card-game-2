extends Node


const SAVE_FILE_LOCATION = "user://save.tres"

var save : SaveFileDefault


func load_from_file():
	if ResourceLoader.exists(SAVE_FILE_LOCATION):
		# TODO: should include validity check
		save = ResourceLoader.load(SAVE_FILE_LOCATION)
	else:
		save = SaveFileDefault.new()
		save_to_file()

func save_to_file():
	var _void = ResourceSaver.save(SAVE_FILE_LOCATION, save)

func clear_settings_file():
	var dir = Directory.new()
	if dir.file_exists(SAVE_FILE_LOCATION):
		dir.remove(SAVE_FILE_LOCATION)
		save = null
		load_from_file()

#
# Handling quitting the game
#

func _notification(what):
	if (what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST
		or what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST):
			save_to_file()
