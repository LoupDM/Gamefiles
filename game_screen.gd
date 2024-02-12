extends Control



var dialogue_tree = {
	"start": {
	"text": "Thank you for calling ValueLyfe, your best healthcare provider. Please listen to the following options so that we may better help you.",
	"options": [
	{"text": "For A New Claim: Press 1", "next": "new_claim"},
	{"text": "For An Existing Claim: Press 2", "next": "existing_claim"},
	{"text": "For New Products Info: Press 3", "next": "new_products"},
	{"text": "For Organ Information: Press 4", "next": "organ_info"}
	]# ... (your dialogue tree structure)
	}
}


func _ready():
	load_dialogue("start")
	
	
func _on_option_selected(next_id):
	load_dialogue(next_id)
	
func load_dialogue(id):
	var data = dialogue_tree[id]
	type_text(data["text"])  # Use type_text instead of append_text
	setup_options(data["options"])

func type_text(text, delay=0.05):  # Define a function to display text with delay
	$RichTextLabel.text = ""  # Clear any existing text
	#print(text)
	for letter in text:
		$RichTextLabel.append_text(letter)
		await get_tree().create_timer(delay).timeout
		

func setup_options(options):
	for child in $VBoxContainer.get_children():
		child.queue_free()
	
	#@var delay = 0.8  # Adjust delay for button appearance speed
	# Iterate through options, type text, and create buttons with delay
	
	for current_option in options:
		
		var button = Button.new()
		button.text = current_option["text"]
		button.connect("pressed", func(): _on_option_selected(current_option["next"]) )
		$VBoxContainer.add_child(button)




