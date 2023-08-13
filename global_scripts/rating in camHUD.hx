function onShowCombo(combo, lastCoolText) {
	//the code
	if (engineSettings.maxRatingsAllowed != 0)
	var tweens:Array<VarTween> = [];
	
	var rating:FlxSprite = new FlxSprite();
	rating.loadGraphic(lastRating.bitmap);
	rating.cameras = [camHUD];
	rating.screenCenter();
	rating.x = lastCoolText.x + 280;
	rating.y -= 240;
	rating.acceleration.y = 550;
	rating.velocity.y -= FlxG.random.int(140, 175);
	rating.velocity.x -= FlxG.random.int(0, 10);
	rating.angle = FlxG.random.int(6, -6);
	rating.antialiasing = lastRating.antialiasing;

	var comboSpr:FlxSprite = new FlxSprite().loadGraphic(Paths.image('combo'));
	comboSpr.cameras = [camHUD];
	comboSpr.screenCenter();
	comboSpr.x = lastCoolText.x + 320;
	comboSpr.y -= 205;
	comboSpr.acceleration.y = 600;
	comboSpr.velocity.y -= 150;
	comboSpr.velocity.x += FlxG.random.int(1, 10);
	add(rating);
	if (combo >= 2)
		add(comboSpr);

	comboSpr.scale.set(0.5, 0.5);
	comboSpr.antialiasing = true;
	rating.scale.x = rating.scale.y = lastRating.scale * 0.7;

	comboSpr.updateHitbox();
	rating.updateHitbox();

	var seperatedScore:Array<Int> = [];
	var stringCombo = Std.string(combo);
	for (i in 0...stringCombo.length)
	{
		seperatedScore.push(Std.parseInt(stringCombo.charAt(i)));
	}

	while (seperatedScore.length < 3)
		seperatedScore.insert(0, 0);

	var daLoop:Int = 0;
	for (i in seperatedScore)
	{
		var numScore:FlxSprite = new FlxSprite().loadGraphic(Paths.image('num' + Std.int(i)));
		numScore.cameras = [camHUD];
		numScore.screenCenter();
		numScore.x = lastCoolText.x + (43 * daLoop) + 350;
		numScore.y -= 140;

		numScore.antialiasing = true;
		numScore.setGraphicSize(Std.int(numScore.width * 0.425));
		numScore.updateHitbox();

		numScore.acceleration.y = FlxG.random.int(200, 300);
		numScore.velocity.y -= FlxG.random.int(140, 160);
		numScore.velocity.x = FlxG.random.float(-5, 5);

		if (combo >= 1 || combo == 0)
			add(numScore);

		tweens.push(FlxTween.tween(numScore, {alpha: 0}, 0.2, {
			onComplete: function(tween:FlxTween)
			{
				numScore.destroy();
			},
			startDelay: Conductor.crochet * 0.002
		}));

		daLoop++;

		tweens.push(FlxTween.tween(rating, {alpha: 0}, 0.2, {
			startDelay: Conductor.crochet * 0.001
		}));
	
		tweens.push(FlxTween.tween(comboSpr, {alpha: 0}, 0.2, {
			onComplete: function(tween:FlxTween)
			{
				comboSpr.destroy();
	
				rating.destroy();
			},
			startDelay: Conductor.crochet * 0.001
		}));
	}
	if (engineSettings.maxRatingsAllowed > -1) optimizedTweenSet.push(tweens);

	return false;

	// 1.000.000 0o0
	// also this is for remove the stinky old rating in the game (this engine is shittty ass to get compiled so I make the softcoded version/script idfk why I made this text long ;-;)
	//lastCoolText.x = 1000000;
	//lastCoolText.y = 1000000;
	//lastCoolText.alpha = 0.0001; // I hope it's work nope, it's not :\
}