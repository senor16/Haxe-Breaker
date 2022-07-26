package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class MenuState extends FlxState {
	var playButton:FlxButton;

	override public function create() {
		super.create();
		FlxG.mouse.visible = true;
		playButton = new FlxButton(0, 0, "Play", clickPlay);
		playButton.screenCenter();
		
		playButton.onUp.sound = FlxG.sound.load(AssetPaths.boundaryCollision__wav);
		add(playButton);
	}

	public function clickPlay() {
		FlxG.switchState(new GameplayState());
	}
}
