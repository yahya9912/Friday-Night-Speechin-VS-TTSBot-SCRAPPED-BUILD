import ("Reflect");
import("Main");
import("StringTools");

var engineVer = Reflect.getProperty(Main, "engineVer");
var canMove:Bool = true;
var camIntensity = 40;
if (!StringTools.startsWith(engineVer, "1.")) {
	function createPost() {
		for (char in [PlayState.boyfriend, PlayState.dad]) {
			char.addCameraOffset('singLEFT', -20, 0);
			char.addCameraOffset('singRIGHT', 20, 0);
			char.addCameraOffset('singUP', 0, -20);
			char.addCameraOffset('singDOWN', 0, 20);
			char.addCameraOffset('singLEFT-alt', -20, 0);
			char.addCameraOffset('singRIGHT-alt', 20, 0);
			char.addCameraOffset('singUP-alt', 0, -20);
			char.addCameraOffset('singDOWN-alt', 0, 20);
		}
	}
} else {
trace("your yoshicrafter engine is outdated bro, you should consider updating");
function postUpdate(elapsed:Float) {
	if (PlayState.section == null || !canMove)	return;
	var animName = "";
	if (PlayState.section.mustHitSection) animName = PlayState.boyfriend.animation.curAnim.name;
	else animName = PlayState.dad.animation.curAnim.name;
    switch(animName) {
        case "singLEFT", "singLEFT-alt":
            PlayState.camFollow.x -= camIntensity;
        case "singRIGHT", "singRIGHT-alt":
            PlayState.camFollow.x += camIntensity;
        case "singUP", "singUP-alt":
            PlayState.camFollow.y -= camIntensity;
        case "singDOWN", "singDOWN-alt":
            PlayState.camFollow.y += camIntensity;
        }
    }
}
function changeCamMovement(bool:Bool) {
	canMove = bool;
}

// who did this fucking code, i made it better now anyways. your welcome - LJ