extends TextureButton

@export var backgroundMusicPlayer: AudioStreamPlayer
@export var nextPopupWindow: PopupPanel
@export var backgroundMusic: AudioStreamOggVorbis
@export var mainMenu: MarginContainer
@export var game_ui: Node
@export var display_popup_button: MarginContainer

func _pressed() -> void:
	backgroundMusicPlayer.set_stream(backgroundMusic)
	backgroundMusicPlayer.play()
	nextPopupWindow.popup()
	game_ui.current_popup=nextPopupWindow
	display_popup_button.show()
	mainMenu.hide()
	
	
