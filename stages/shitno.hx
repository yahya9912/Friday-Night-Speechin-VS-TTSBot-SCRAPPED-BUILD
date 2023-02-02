//a
import Section;
var stage:Stage = null;
var MRBEAST:FlxSprite;
var explosion:FlxSprite;

var SANS:Boyfriend;
function create() {
	stage = loadStage('shitno');
	PlayState.gf.visible = false;
	PlayState.dad.alpha = 0.0001;

	SANS = new Boyfriend(PlayState.boyfriend.x, PlayState.boyfriend.y, mod + ":sansIndie");
	boyfriends.push(SANS);
	add(SANS);
	SANS.alpha = 0.0001;

	MRBEAST = new FlxSprite(PlayState.boyfriend.x - 100, PlayState.boyfriend.y - 100);
	MRBEAST.frames = Paths.getSparrowAtlas('MRBEATS');
	add(MRBEAST);
	MRBEAST.alpha = 0.0001;
	MRBEAST.animation.addByPrefix('bruh', 'mrbeast', 24, false);
	MRBEAST.animation.play('bruh');

	explosion = new FlxSprite(PlayState.boyfriend.x + 100, PlayState.boyfriend.y - 100);
	explosion.frames = Paths.getSparrowAtlas('splashes');
	add(explosion);
	explosion.scale.set(5,5);
	explosion.alpha = 0.0001;
	explosion.animation.addByPrefix('bruh', 'note splash blue 1', 24, false);
	explosion.animation.play('bruh');

}
var newOffset:Bool = false;
function update(elapsed) {
	stage.update(elapsed);
	if (!PlayState.section.mustHitSection) {
		PlayState.camFollow.x += 200;
		PlayState.camFollow.y += 150;
	}
	if (PlayState.section.mustHitSection && newOffset) {
		PlayState.camFollow.x -= 250;
		PlayState.camFollow.y -= 50;
	}
}
function beatHit(curBeat) {
	stage.onBeat();
}

var yourMother:Array<Int> = [416, 528, 640, 752];
var yourMother2:Array<Int> = [726, 848, 960, 1072];
function onGenerateStaticArrows() {
	PlayState.camGame.alpha = 0.0001;
    PlayState.camHUD.alpha = 0;
	for (e in PlayState.playerStrums.members) e.alpha = 0;
	for (i in PlayState.cpuStrums.members) i.alpha = 0;
}

function onPsychEvent(arg, ?param1, ?param2) {
	switch(arg) {
		case "Hide P2 Icon":
			PlayState.iconP2.alpha = 0.0001;
		case "Fade In Intro":
			FlxTween.tween(PlayState.camGame, {alpha: 1.0}, 2.5, {ease: FlxEase.quadInOut});
			cameraTweenStuff(-0.3, 5.0);
			PlayState.scripts.executeFunc("doOpener");
		case "HUD Fade":
			var val1 = param1;
			if (Math.isNaN(val1) || val1 <= 0 || val1 == '')
				val1 = 4;
    		trace('this thing fades the hud why doesnt it work');
			FlxTween.tween(PlayState.camHUD, {alpha: 1}, 
			    val1 * (Conductor.stepCrochet / 1000), {ease: FlxEase.linear});
			// FlxTween.tween(PlayState.uiHUD, {alpha: 0.6}, 
			// 	val1 * (Conductor.stepCrochet / 1000), {ease: FlxEase.linear});
			for (i in PlayState.playerStrums.members) {
				FlxTween.tween(i, {alpha: 0.8}, 
					val1 * (Conductor.stepCrochet / 1000), {ease: FlxEase.linear});
    		}
			for (note in PlayState.notes) {
				PlayState.playerStrums.members[0].x = yourMother[0];
				PlayState.playerStrums.members[1].x = yourMother[1];
				PlayState.playerStrums.members[2].x = yourMother[2];
				PlayState.playerStrums.members[3].x = yourMother[3];
			}
		case 'Grey Turn Around':
			// PlayState.boyfriend.playAnim('turn');

			new FlxTimer().start(0.86, function(tmr:FlxTimer) {
				for (note in PlayState.notes) {
					FlxTween.tween(PlayState.playerStrums.members[0], {x: yourMother2[0]}, 1.2, {ease: FlxEase.quadInOut});
					FlxTween.tween(PlayState.playerStrums.members[1], {x: yourMother2[1]}, 1.2, {ease: FlxEase.quadInOut});
					FlxTween.tween(PlayState.playerStrums.members[2], {x: yourMother2[2]}, 1.2, {ease: FlxEase.quadInOut});
					FlxTween.tween(PlayState.playerStrums.members[3], {x: yourMother2[3]}, 1.2, {ease: FlxEase.quadInOut});
				}
				FlxTween.tween(PlayState.boyfriend, {x: boyfriend.x + 350}, 1.2, {ease: FlxEase.quadInOut});
				newOffset = true;
				// PlayState.boyfriend.characterData.camOffsetX = 200;
				// PlayState.boyfriend.characterData.camOffsetY -= 50;
				});
		case "Shitno Laugh":
			PlayState.dad.alpha += 0.15;
			PlayState.iconP2.visible = true;
			if (PlayState.health > 1.01) 
				PlayState.health = 1.0;
		case "funny":
			MRBEAST.alpha = 1;
			MRBEAST.animation.play('bruh', true);
		}
}
function cameraTweenStuff(amount:Float, duration:Float) {
		camZoomTween = FlxTween.num(PlayState.defaultCamZoom, PlayState.defaultCamZoom + amount, duration, {ease: FlxEase.quadOut}, function(v:Float) { PlayState.defaultCamZoom = v; });
}

function startFunny() {
	SANS.alpha = 1;
	PlayState.boyfriend.alpha = 0.0001;
	SANS.x = PlayState.boyfriend.x;
	SANS.y = PlayState.boyfriend.y - 150;
}

function end() {
	MRBEAST.alpha = 0.0001;
	SANS.alpha = 0.0001;
	explosion.alpha = 1;
	explosion.animation.play('bruh', true);
}