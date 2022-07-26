package;

import flixel.FlxSprite;

/**
 * ...
 * @author ...
 */
class Block extends FlxSprite {
	var isDestroyed:Bool;

	public function new(X:Float, Y:Float) {
		super(X, Y);
		isDestroyed = false;
		loadGraphic(AssetPaths.spritesheet__png, true, 30, 30);
	}
}
