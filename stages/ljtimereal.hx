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