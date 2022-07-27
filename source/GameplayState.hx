package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.effects.particles.FlxEmitter;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
enum ObjectType
{
	BALL;
	PAD;
	BLOCK;
}

/**
 * ...
 * @author ...
 */
class GameplayState extends FlxState
{

	static inline var MAX_LEVEL:Int = 5;

	var currentLevel = 1;
	var listExplodeEmitter:FlxTypedGroup<FlxEmitter>;

	var soundPad:FlxSound;
	var soundLoose:FlxSound;
	var soundBlock:FlxSound;
	var listBlocks:FlxTypedGroup<FlxSprite>;
	var pad:Pad;
	var ball:Ball;
	var remmainingBlocks:Int;

	override public function create()
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
		super.create();
		if (FlxG.sound.music == null)
		{
			FlxG.sound.playMusic(AssetPaths.S31_Night_Prowler__ogg);
		}

		soundPad = FlxG.sound.load(AssetPaths.arkanoid_raquette__wav);
		soundLoose = FlxG.sound.load(AssetPaths.arkanoid_perdu__wav);
		soundBlock = FlxG.sound.load(AssetPaths.arkanoid_brique__wav);

		FlxG.mouse.visible = false;

		// Pad
		pad = new Pad(0, FlxG.height - 25);

		add(pad);

		// Ball
		ball = new Ball(0, 0);

		add(ball);

		// Explosion particles
		listExplodeEmitter = new FlxTypedGroup<FlxEmitter>();
		add(listExplodeEmitter);

		// Blocks
		listBlocks = new FlxTypedGroup<FlxSprite>();
		add(listBlocks);
		loadLevel(currentLevel);
	}

	public function loadLevel(pLevel:Int)
	{
		pad.screenCenter(X);
		ball.x = pad.x + (pad.width - ball.width) / 2;
		ball.y = pad.y - ball.height;

		if (FlxG.random.bool())  // If the random return true, the ball go to the right
		{
			ball.right = true;
			ball.left = false;
		}
		else   // If not, the ball go to the left
		{
			ball.right = false;
			ball.left = true;
		}
		ball.down = false;
		ball.up = true;
		remmainingBlocks = 0;
		switch (pLevel)
		{
			case 1:
				for (line in 0...4 + 1)
				{
					for (column in 0...17 + 1)
					{
						remmainingBlocks++;
						listBlocks.add(new Block(column * 35+5, line*30));
					}
				}
			case 2:
				for (line in 0...6 + 1)
				{
					for (column in 1...16 + 1)
					{
						if (column%4!=0){
							listBlocks.add(new Block(column * 35+30, line*30));
							remmainingBlocks++;
						}
					}
				}
			case 3:
				for (line in 0...7 + 1)
				{
					if (line%4!=0)
					{
						for (column in 1...16 + 1)
						{
							listBlocks.add(new Block(column * 35+5, (line-1)*30));
							remmainingBlocks++;
						}
					}
				}
			case 4:
				for (line in 0...5 + 1)
				{
					for (column in 1...18 + 1)
					{
						if (column%3!=0){
							listBlocks.add(new Block(column * 35-5, line*30));
							remmainingBlocks++;
						}
					}
				}
			case 5:
				for (line in 0...7 + 1)
				{
					if (line%4!=0)
					{
						for (column in 1...15 + 1)
						{
							if (column%4!=0){
								listBlocks.add(new Block(column * 35+30, line*30));
								remmainingBlocks++;
							}
						}
					}
				}
		}

	}

	public function addExplosion(X:Float,Y:Float)
	{
		var explosion : FlxEmitter = new FlxEmitter(X, Y,20);
		explosion.makeParticles(3, 3, FlxColor.fromRGB(232,125,82), 20);
		listExplodeEmitter.add(explosion);
		explosion.lifespan.max = 1;
		explosion.acceleration.start.min.y = 800/2;
		explosion.acceleration.start.max.y = 1000/2;
		explosion.acceleration.start.min.y = 800/2;
		explosion.acceleration.start.max.y = 1000/2;
		explosion.start(true, 1);
	}

	override public function update(elapsed:Float)
	{
		if (!ball.isOff)
		{
			if (remmainingBlocks <= 0)
			{
				if (currentLevel < MAX_LEVEL)
				{
					
					var timer:FlxTimer = new FlxTimer().start(1, function(time)
					{
						currentLevel++;
						loadLevel(currentLevel);
					});
					FlxG.camera.fade(FlxColor.BLACK, 4, true);
					ball.isOff = true;

				}
				else
				{
					FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
					{
						FlxG.switchState(new GameoverState(true));
					});
				}
			}

			FlxG.collide(ball, listBlocks, ballTouchedBlocks);
			if (FlxG.pixelPerfectOverlap(ball, pad))
			{
				ball.hitPad(pad);
				soundPad.play();
			}

			if (ball.y  > FlxG.height && !ball.isOff)
			{
				pad.hurt(1);
				ball.isOff = true;
				soundLoose.play();
				FlxG.camera.shake(0.03, 0.3);
				if (pad.health <= 0)
				{
					FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
					{
						FlxG.switchState(new GameoverState(false));
					});

				}

			}
		}
		else
		{
			ball.x = pad.x + (pad.width - ball.width) / 2;
			ball.y = pad.y - ball.height;
			
			if (FlxG.keys.anyJustReleased([SPACE,ENTER])){
				ball.isOff = false;
			}
		}
		super.update(elapsed);
	}

	public function ballTouchedPad(b:FlxSprite, p:FlxSprite)
	{
		ball.hitPad(pad);
		soundPad.play();
	}

	public function ballTouchedBlocks(b:FlxSprite, block:FlxSprite)
	{
		if (b.isTouching(FlxObject.LEFT) || b.isTouching(FlxObject.RIGHT))
			ball.changeDirX();
		if (b.isTouching(FlxObject.UP) || b.isTouching(FlxObject.DOWN))
			ball.changeDirY();
		soundBlock.play();
		listBlocks.remove(block);
		remmainingBlocks --;

		addExplosion(block.x + block.width / 2, block.y + block.height / 2);
	}
}
