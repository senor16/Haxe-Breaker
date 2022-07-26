package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;

/**
 * ...
 * @author ...
 */
class Ball extends FlxSprite
{
	static inline var SPEED:Float = 300;
	static inline var WIDTH:Int = 640;
	static inline var HEIGHT:Int = 480;
	static inline var MERGE:Int = 45;

	var up:Bool = false;
	var down:Bool = false;
	var left:Bool = false;
	var right:Bool = false;
	var soundScreen :FlxSound;
	public var isOff = false;

	public function new(X:Float, Y:Float)
	{
		super(X, Y);
		loadGraphic(AssetPaths.bl__png, true);
		right = true;
		up = true;

		soundScreen = FlxG.sound.load(AssetPaths.boundaryCollision__wav);
	}

	function updateMovement()
	{

		// Collision with the screen
		if (this.y + this.graphic.height < MERGE)
		{
			if (this.x > WIDTH)   // Right, come back from the left
			{
				this.x = 0;
			}
		}
		else
		{
			if (this.x + this.graphic.width > WIDTH)   // Right,
			{
				right = false;
				left = true;
				soundScreen.play();
			}
		}
		if (this.x < -5)   // Left
		{
			left = false;
			right = true;
			soundScreen.play();
		}

		if (this.y < -5)   // Up
		{
			up = false;
			down = true;
			soundScreen.play();
		}

		/*if (up && down)
				up = down = false;
			if (left && right)
				left = right = false; */

		if (up)
			velocity.y = -SPEED;
		if (down)
			velocity.y = SPEED;
		if (left)
			velocity.x = -SPEED;
		if (right)
			velocity.x = SPEED;

		var newAngle:Float = 0;
		if (up)
		{
			newAngle = -90;
			if (left)
				newAngle -= 45;
			else if (right)
				newAngle += 45;
		}
		else if (down)
		{
			newAngle = 90;
			if (left)
				newAngle += 45;
			else if (right)
				newAngle -= 45;
		}
		else if (left)
			newAngle = 180;
		else if (right)
			newAngle = 180;

		velocity.set(SPEED, 0);
		velocity.rotate(FlxPoint.weak(0, 0), newAngle);

	}

	override public function update(elapsed:Float)
	{
		if (!this.isOff)
		{
			updateMovement();
			super.update(elapsed);
		}
	}

	public function changeDirX()
	{
		left = !left;
		right = !right;
	}

	public function changeDirY()
	{
		up = !up;
		down = !down;
	}

	public function hitPad(pad:FlxSprite)
	{
		this.y = pad.y - this.graphic.height-2;
		changeDirY();
	}

	public function hitBlock(block:FlxSprite)
	{
		changeDirY();
	}
}
