//a
var stage:Stage = null;
function create() {
	stage = loadStage('discord server');
}
var musicStarted:Bool = false;
function update(elapsed) {
	stage.update(elapsed);
    if (!musicStarted) return;
    PlayState.camFollow.y -= 200;
}
function beatHit(curBeat) {
	stage.onBeat();
}
function musicstart() {
    FlxTween.num(defaultCamZoom, 0.5, 0.4, {ease: FlxEase.expoOut}, function(v:Float) {
        defaultCamZoom = v;
    });
    musicStarted = true;
}
function stageChangeVisible(visible:Bool) {
	for (e in stage.sprites) {
		e.alpha = (visible) ? 0.0001 : 1;
	}
}