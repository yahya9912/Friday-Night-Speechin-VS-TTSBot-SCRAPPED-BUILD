var stage:Stage = null;
function create() {
	stage = loadStage('A LINK');
}
function update(elapsed) {
	stage.update(elapsed);
}
function beatHit(curBeat) {
	stage.onBeat();
}