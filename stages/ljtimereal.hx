//a
var stage:Stage = null;
function create() {
	stage = loadStage('discord server');
}
function update(elapsed) {
	stage.update(elapsed);
}
function beatHit(curBeat) {
	stage.onBeat();
}
function musicstart() {
    FlxTween.num(defaultCamZoom, 0.5, 0.4, {ease: FlxEase.expoOut}, function(v:Float) {
        defaultCamZoom = v;
    });
}

function stageChangeVisible(visible:Bool) {
	for (e in stage.sprites) {
		e.alpha = (visible) ? 0.0001 : 1;
	}
}