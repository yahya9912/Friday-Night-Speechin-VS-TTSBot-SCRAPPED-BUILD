var stage:Stage = null;
function create() {
	stage = loadStage('your-stage');
}
function update(elapsed) {
	stage.update(elapsed);
}
function beatHit(curBeat) {
	stage.onBeat();
}