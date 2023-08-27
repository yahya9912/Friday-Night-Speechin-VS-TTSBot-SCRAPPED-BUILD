var stage:Stage = null;
function create() {
	stage = loadStage('Anti Impersonators');
}
function update(elapsed) {
	stage.update(elapsed);
}
function beatHit(curBeat) {
	stage.onBeat();
}