extends Control

export (int) var max_currency_ui = $TextureProgress.max_value
#I'm exporting this as a variable to make it easier to alter the max currency here, if needed.

func _ready():
	max_currency_ui = 100
	

func _on_currency_changed(value):
	$CurrencyLabel.text = "Currency: "+str(value)
	$TextureProgress.value = value
	#Connect a signal that changes how much currency the player has to this function.
	#Emit that signal whenever the player's currency should change.