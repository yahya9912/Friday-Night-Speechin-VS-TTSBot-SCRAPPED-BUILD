//a
import openfl.filters.ShaderFilter;
import ScoreText;
var stage:Stage = null;
function create() {
	stage = loadStage('A LINK');
    what = new CustomShader(mod + ":scrollShader");
    what.data.killMe.value = [0];
	stage.getSprite("A LINKS").shader = what;
	// EngineSettings.botplay = true;
}
var yay:FlxTween;
function onDadHit(note:Note) {
	funny = FlxG.random.int(0, uhIdk[0].length-1);
	if (!FlxG.random.bool(15)) return;
	if (yay != null) yay.cancel();
	var uh = FlxG.random.float(1, 5);
	yay = FlxTween.num(yes, yes + uh, 1, {ease: FlxEase.quadOut}, function(v:Float) {
		yes = v + elapsedEEE*2;
	});
}

var toggleBgBeat:Bool = false;
var yes:Float = 0.0;
var elapsedEEE:Float = 0;
function update(elapsed) {
	stage.update(elapsed);
	elapsedEEE = elapsed;
	yes += elapsed*2;
    what.data.killMe.value = [yes];
	if (!toggleBgBeat) return;
	var decBeat = curDecBeat;
	if (decBeat < 0)
		decBeat = 1 + (decBeat % 1);
	var iconlerp = FlxMath.lerp(1.35, 1.3, FlxEase.cubeOut(decBeat % 1));
	stage.getSprite("A LINKS").scale.set(iconlerp, iconlerp);
}
function beatHit(curBeat) {
	stage.onBeat();
}

var funny:Int = 999;
function toggleBGbeat(?force:Bool) {
	if (!force) toggleBgBeat = !toggleBgBeat;
	else toggleBgBeat = force;
}

var uhIdk = [
	["ScOrE: ", "sCoRE: ", "sCoRE: ", "SCORE: ", "scORe: ", "LJ MOMENT: ", "Null Object Refrence: ", "LJ please commit I want to do something: ", "Misses: ", "Accuracy", "Average: "],
	["miSsEs: ", "mISsES: " , "mIssEs: ", "MISSES: ", "MIsSes: ", "LJ MOMENT: ", "Null Object Refrence: ", "LJ please commit I want to do something: ", "Score: ", "Accuracy", "Average: "],
	["AcCUraCy: ", "aCCUracY: ", "accURacY: ", "ACCURACY: ", "aCCurAcy: ", "LJ MOMENT: ", "Null Object Refrence: ", "LJ please commit I want to do something: ", "Score: ", "Misses: ", "Average: "],
	["AvEraGE: ", "aVeRAge: ", "AVerAgE: ", "AVERAGE: ", "aveRaGE: ", "LJ MOMENT: ", "Null Object Refrence: ", "LJ please commit I want to do something: ", "Score: ", "Misses: ", "Accuracy"]
];
function updatePost(elapsed) {
	if (funny == 999) return;
	scoreText.text = '';
	if (EngineSettings.botplay) return;
	var arrayText:Dynamic = [
		ScoreText.generateScore(PlayState),
		ScoreText.generateMisses(PlayState),
		ScoreText.generateAccuracy(PlayState),
		ScoreText.generateAverageDelay(PlayState),
		ScoreText.generateRating(PlayState)
	];
	for (i in 0...arrayText.length) {
		if (i != 4)
			scoreText.text += uhIdk[i][CoolUtil.wrapInt(funny * i, 0, uhIdk[i].length)] + arrayText[i].split(":")[1];
		else 
			scoreText.text += arrayText[i];
		scoreText.text += EngineSettings.scoreJoinString;
	}
}