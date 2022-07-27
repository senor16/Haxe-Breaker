package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.text.FlxText;
/**
 * ...
 * @author ...
 */
class MenuState extends FlxState {
	var playButton:FlxButton;
var titleText:FlxText;
	override public function create() {
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
		super.create();
		FlxG.mouse.visible = true;
		playButton = new FlxButton(0, 0, "Play", clickPlay);
		playButton.screenCenter();
		playButton.scale.x = playButton.scale.y = 2;
		playButton.label.scale.x = playButton.label.scale.y = 2;
		playButton.onUp.sound = FlxG.sound.load(AssetPaths.boundaryCollision__wav);
		add(playButton);
		
		// Title
		var ypos :Float=40, size=15;
		titleText = new FlxText(20, ypos, 0, "Summer Breaker", 30);
		titleText.alignment = CENTER;
		titleText.screenCenter(X);
		add(titleText);
	}

	public function clickPlay() {
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function(){
			FlxG.switchState(new GameplayState());
		});		
	}
}
