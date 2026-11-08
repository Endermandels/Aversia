extends CanvasLayer
# Global

@export var command_char: String = "/" ## Character denoting command (like /debug)
@export var history_limit: int = 100 ## Number of labels before start to delete new labels
@export var default_text_color: Color = Color.DIM_GRAY ## Default color of print_line text
@export var default_text_submit_color: Color = Color.WHITE ## Default color of submitted text
@export var hide_on_ready: bool = true ## Whether to hide the Console on startup
@export var allow_non_commands: bool = true ## Whether to allow regular chatting (not commands)
@export_group("Nodes")
@export var scroll_box: ScrollContainer
@export var chat_box: VBoxContainer
@export var line_edit: LineEdit

var command_received: String = ""

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("console"):
		toggle()

func _ready() -> void:
	if hide_on_ready:
		hide()
	else:
		line_edit.grab_focus()
	line_edit.text_submitted.connect(_on_line_edit_text_submitted)
	line_edit.gui_input.connect(_on_line_edit_gui_input)

func _on_line_edit_text_submitted(new_text: String) -> void:
	if new_text.begins_with(command_char):
		command_received = new_text.substr(1).strip_edges() # Store command received
	elif allow_non_commands:
		print_line(new_text, default_text_submit_color)
	line_edit.text = ""

## Close the console even while typing
func _on_line_edit_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("console"):
		line_edit.release_focus() # Since gui_input is called before unhandled_key_input

## Make sure LineEdit is always focused
func _process(_delta: float) -> void:
	if visible:
		line_edit.grab_focus()

## Get command_received (resets command_received to "")
func get_command() -> String:
	var res = command_received
	command_received = ""
	return res

## Add a Label to the Chat Box
func print_line(text: String, col: Color = default_text_color) -> void:
	var label: Label = Label.new()

	label.text = text
	label.add_theme_font_size_override("font_size", line_edit.get_theme_font_size("font_size"))
	label.modulate = col
	chat_box.add_child(label)
	
	if chat_box.get_child_count() > history_limit:
		chat_box.get_child(0).queue_free()

	print(text) # Why not?

	await get_tree().process_frame # Need to wait before child is registered
	scroll_box.ensure_control_visible(label)

## Clear the Chat Box
func clear() -> void:
	for n in chat_box.get_children():
		n.queue_free()

## Toggle showing or hiding the console
func toggle() -> void:
	if not visible:
		line_edit.text = ""
		line_edit.grab_focus()
		show()
	else:
		hide()
