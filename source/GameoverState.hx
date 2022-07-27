package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class GameoverState extends FlxState {
	
	var menuButton:FlxButton;
	var titleText:FlxText;
	var thanksText:FlxText;
	var creditsText:FlxText;
	var wonText:FlxText;
	var lostText:FlxText;
	override public function create() {
		super.create();
		FlxG.mouse.visible = true;
		menuButton = new FlxButton(0, 0, "Back to Menu", clickMenu);
		menuButton.screenCenter();
		menuButton.y += 150;
		menuButton.onUp.sound = FlxG.sound.load(AssetPaths.boundaryCollision__wav);
		//menuButton.color = FlxColor.BLUE;
		
		add(menuButton);
		
		/* Texts */
		// Title
		var ypos :Float=20, size=15;
		titleText = new FlxText(20, ypos, 0, "Summer Breaker", 30);
		titleText.alignment = CENTER;
		titleText.screenCenter(X);		
		add(titleText);
		
		// Won
		ypos += titleText.height*1.5;	
		wonText = new FlxText(20, ypos, 0, "You completed the game", size+5);
		wonText.alignment = CENTER;
		wonText.screenCenter(X);
		//add(wonText);
		// Lost		
		lostText = new FlxText(20, ypos, 0, "You completed the game", size+5);
		lostText.alignment = CENTER;
		lostText.screenCenter(X);
		add(lostText);
		// Thanks
		ypos += wonText.height*2;	
		thanksText = new FlxText(20, ypos, 0, "Thanks for playing", size);
		thanksText.alignment = CENTER;
		thanksText.screenCenter(X);
		add(thanksText);
		// Credits
		ypos += thanksText.height*2;		
		creditsText = new FlxText(20, ypos, 200, "Credits \n\nGraphics : sese \n\nCode : senor16", size);
		creditsText.alignment = CENTER;
		creditsText.screenCenter(X);
		add(creditsText);
		
		
	}

	public function clickMenu() {
		FlxG.switchState(new MenuState());
	}
}
