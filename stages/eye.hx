var stage:Stage = null;
function create() {
	stage = loadStage('eye');
}
function update(elapsed) {
	stage.update(elapsed);
}
function beatHit(curBeat) {
	stage.onBeat();
}