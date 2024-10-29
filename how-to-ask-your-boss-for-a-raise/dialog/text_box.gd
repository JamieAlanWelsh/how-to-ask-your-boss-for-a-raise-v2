extends MarginContainer


@onready var label = $MarginContainer/Label
# Timer is used for the typewriter-style effect
@onready var timer = $LetterDisplayTimer


# if width is exceeded, textbox will start to resize vertically
const MAX_WIDTH = 256

var text = ""
var letter_index = 0

# how many seconds pass between each character of text being displayed
# different values are used for different characters because of style?
var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.2


# signal is emitted once the entire text has been displayed
signal finished_displaying()


func display_text(text_to_display: String):
	text = text_to_display
	# initially sets the label's text to the full string so that the textbox can calculate its size
	label.text = text_to_display
	
	# Waits for the text box to be resized to fit the content asynchronously
	await resized
	# sets the width of the textbox, minimum is the current width to max width
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	# Wrap text vertically if wmaximum textbox width is exceeded
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized # wait for x resize
		await resized # wait for y resize
		# new minimum y size is set after the textbox expands vertically
		custom_minimum_size.y = size.y
	
	# ensure that textbox is positioned and centered properly after readjustments
	global_position.x -= size.x / 2
	global_position.y -= size.y + 24
	
	# after all resizing, clear the label and prepare for displaying text
	label.text = ""
	_display_letter()


func _display_letter():
	label.text += text[letter_index]
	
	letter_index += 1
	if letter_index >= text.length():
		finished_displaying.emit()
		return
	
	match text[letter_index]:
		"!", ".", ",", "?":
			timer.start(punctuation_time)
		" ":
			timer.start(space_time)
		# any other case i.e. letters
		_:
			timer.start(letter_time)


# when timer node finishes countdown it emits a signal called timeout()
# each time the timeout finished we call display letter to display the next letter of text
func _on_letter_display_timer_timeout() -> void:
	_display_letter()
