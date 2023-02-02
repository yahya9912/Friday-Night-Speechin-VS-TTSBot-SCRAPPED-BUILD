//a
var stage:Stage = null;
function create() {
	stage = loadStage('vc');
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