package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class Pad extends FlxSprite {
	static inline var SPEED:Float = 300;
	static inline var WIDTH:Int = 640;

	public function new(X:Float, Y:Float) {
		super(X, Y);
		//		loadGraphic(AssetPaths.pad__png, true);
		makeGraphic(100, 20, FlxColor.WHITE);
		drag.x = drag.y = 1600;
		this.health = 1;
	}

	function updateMovement() {
		var left:Bool = false;
		var right:Bool = false;

		left = FlxG.keys.anyPressed([LEFT, A]);
		right = FlxG.keys.anyPressed([RIGHT, D]);

		if (left && right)
			left = right = false;
		if (left)
			velocity.x = -SPEED;
		if (right)
			velocity.x = SPEED;
		if (this.x < 0)
			this.x = 0;
		if (this.x + this.graphic.width > WIDTH)
			this.x = WIDTH - this.graphic.width;
	}

	override public function update(elapsed:Float) {
		updateMovement();
		super.update(elapsed);
	}

	override public function hurt(damage:Float) {
		super.hurt(damage);
		if (this.health <= 0) {
			FlxG.switchState(new GameoverState());
		}
	}
}
