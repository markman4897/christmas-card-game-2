class_name BaubleBorough_0
extends BaubleBorough


var elf_text = {
	"start": {
		"type": "response",
		"text": "how awful! how terrible! if only some nondescript elf could come and help me, the honest",
		"next": "1"
	},
	"1": {
		"type": "response",
		"text": "and generous mayor of bauble borough!",
		"next": "2"
	},
	"2": {
		"type": "response",
		"text": "so many presents! but alas, my meagre frame cannot hope to move them all to the next room!",
		"next": "3"
	},
	"3": {
		"type": "response",
		"text": "you there, elf! come to my aid and you will be handsomely rewarded with whatever your",
		"next": "4"
	},
	"4": {
		"type": "question",
		"text": "small heart desires!",
		"options": [
			{
				"text": "i want a pony!",
				"next": "end"
			},
			{
				"text": "i need the city key",
				"next": "end"
			},
			{
				"text": "just some food please...",
				"next": "end"
			}
		]
	},
	"end": {
		"type": "response",
		"text": "hold your tongue! this is no time for daydreaming. to work you go!",
		"return": "prompt_over"
	}
}


var elf_text_2 = {
	"start": {
		"type": "response",
		"text": "due to various troubles having to do with my finances, i am at this moment unable to provide you",
		"next": "1"
	},
	"1": {
		"type": "response",
		"text": "with anything costing over 25c. so, here’s a 10c gift certificate to any star sandwiches establishment.",
		"next": "end"
	},
	"end": {
		"type": "response",
		"text": "also, here’s this old key i found in the city hall.",
		"return": "change_scene"
	}
}

var elf2_text = {
	"start": {
		"type": "response",
		"text": "poor mayor.",
		"next": "1"
	},
	"1": {
		"type": "response",
		"text": "did you know he recently had a hip surgery? it didn't go well...",
		"next": "end"
	},
	"end": {
		"type": "response",
		"text": "i sure hope he will get better soon.",
		"return": "none"
	}
}

func _ready():
	$logic/portals/door_trigger.monitoring = false
	
	# set up elves
	$objects/static/elf.connect_trigger(self, "_elf_trigger")
	$objects/static/elf2.connect_trigger(self, "_elf2_trigger")
	
	if SS.save.locations_state.sokoban > 0:
		$objects/static/elf.set_idle_animation("celebrate_2")
		elf_text = elf_text_2
		AC.play_bg_music("happy")
	else:
		AC.play_bg_music("sad")


#
# SIGNAL HANDLING
#

func _elf_trigger(_a, _b, _c, _d) -> void:
	S.summon_textBox(self, elf_text, "_after_text")

func _elf2_trigger(_a, _b, _c, _d) -> void:
	S.summon_textBox(self, elf2_text)


#
# OTHER FUNCS
#

func _after_text(arg):
	if arg == "prompt_over":
		$background/bg.play("door_open")
		$logic/portals/door_trigger.monitoring = true
	elif arg == "change_scene":
		SS.save.locations_state.bauble_borough = 1
		elf_text = elf_text_2
