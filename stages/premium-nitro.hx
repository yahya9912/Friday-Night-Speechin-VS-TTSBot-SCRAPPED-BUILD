var stage:Stage = null;
function create() {
	stage = loadStage('premium-nitro');
}
function update(elapsed) {
	stage.update(elapsed);
}
function beatHit(curBeat) {
	stage.onBeat();
}