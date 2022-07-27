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
class GameoverState extends FlxState
{

	var menuButton:FlxButton;
	var titleText:FlxText;
	var thanksText:FlxText;
	var creditsText:FlxText;
	var statusText:FlxText;

	var won:Bool;
	public function new(iswon:Bool)
	{
		super();
		won = iswon;
	}

	override public function create()
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
		super.create();

		FlxG.mouse.visible = true;
		menuButton = new FlxButton(0, 0, "Back to Menu", clickMenu);
		menuButton.screenCenter();
		menuButton.y += 150;
		menuButton.scale.x = menuButton.scale.y = 2;
		menuButton.label.scale.x = menuButton.label.scale.y = 2;
		menuButton.onUp.sound = FlxG.sound.load(AssetPaths.boundaryCollision__wav);

		add(menuButton);

		/* Texts */
		// Title
		var ypos :Float=20, size=15;
		titleText = new FlxText(20, ypos, 0, "Summer Breaker", 30);
		titleText.alignment = CENTER;
		titleText.screenCenter(X);
		add(titleText);

		// Status Won or Lost
		ypos += titleText.height*1.5;
		if (won)
			statusText = new FlxText(20, ypos, 0, "You completed the game", size+5);
		else
			statusText = new FlxText(20, ypos, 0, "Game Over", size+5);
		statusText.alignment = CENTER;
		statusText.screenCenter(X);
		add(statusText);

		// Thanks
		ypos += statusText.height*2;
		thanksText = new FlxText(20, ypos, 0, "Thanks for playing", size);
		thanksText.alignment = CENTER;
		thanksText.screenCenter(X);
		add(thanksText);
		// Credits
		ypos += thanksText.height*2;
		creditsText = new FlxText(20, ypos, 200, "Credits \n\nGraphics : ATB Man \n\nCode : senor16", size);
		creditsText.alignment = CENTER;
		creditsText.screenCenter(X);
		add(creditsText);

	}

	public function clickMenu()
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
		{
			FlxG.switchState(new MenuState());
		});

	}
}
