var stage:Stage = null;
function create() {
	stage = loadStage('too-slow');
}
function update(elapsed) {
	stage.update(elapsed);
}
function beatHit(curBeat) {
	stage.onBeat();
}