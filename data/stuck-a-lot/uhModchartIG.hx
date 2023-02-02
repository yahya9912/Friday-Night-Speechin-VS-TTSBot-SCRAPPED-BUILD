//a
function update() {
    if (FlxG.keys.justPressed.B) EngineSettings.botplay = !EngineSettings.botplay;
    if (inThingy) PlayState.camFollow.x -= 100;
    if (PlayState.section == null) return;
    PlayState.camFollow.y -= 200;
}
var isAlrMiddleScroll = EngineSettings.middleScroll;
var middleScroll:Array<Int> = [416, 528, 640, 752];
var normal:Array<Int> = [736, 848, 960, 1072];

var inThingy:Bool = false;
var oldDadXY:Array<Float> = [];
function onPsychEvent(event:String, ?value1:Dynamic, ?value2:Dynamic) {
    switch(event) {
        case "MoveArrowsToMiddle":
            inThingy = true;
            PlayState.scripts.executeFunc("stageChangeVisible", [inThingy]);
            PlayState.scripts.executeFunc("changeCamMovement", [!false]);
            PlayState.scripts.executeFunc("ljMoment", [false]);
            PlayState.boyfriend.alpha = 0.0001;
            PlayState.gf.alpha = 0.0001;
            PlayState.camGame.alpha = 0.0001;
            PlayState.camHUD.alpha = 0.0001;
            PlayState.dad.screenCenter();
            PlayState.dad.x += 550;
            PlayState.dad.y += 100;
            defaultCamZoom = 0.8;
            boyfriends.push(boyfriendFP);
            boyfriendFP.alpha = 1;
            new FlxTimer().start(.5, function(tmr:FlxTimer) {
                FlxTween.tween(camHUD, {alpha: 0.75}, 1, {ease: FlxEase.expoIn});
                FlxTween.tween(camGame, {alpha: 1}, 1, {ease: FlxEase.expoIn});
            });
            if (isAlrMiddleScroll) return;
            for (i in 0...PlayState.playerStrums.members.length) {
                PlayState.playerStrums.members[i].x = middleScroll[i];
                PlayState.cpuStrums.members[i].alpha = 0.0001;
            }
    }
}

function createPost() {
    boyfriendFP = new Boyfriend(PlayState.boyfriend.x+400, PlayState.boyfriend.y+350, mod + ":bf-fp");
    boyfriendFP.alpha = 0.0001;
    add(boyfriendFP);
}

function uhIdk() {
    defaultCamZoom = 0.6;
}

function backNormal() {
    inThingy = false;
    PlayState.scripts.executeFunc("stageChangeVisible", [inThingy]);
    PlayState.scripts.executeFunc("changeCamMovement", [true]);
    PlayState.scripts.executeFunc("ljMoment", [true]);
    PlayState.boyfriend.alpha = 1;
    PlayState.gf.alpha = 1;
    PlayState.dad.setPosition(oldDadXY[0], oldDadXY[1]);
    defaultCamZoom = 0.5;
    boyfriendFP.destroy();
    if (isAlrMiddleScroll) return;
    for (i in 0...PlayState.playerStrums.members.length) {
        PlayState.playerStrums.members[i].x = middleScroll[i];
        PlayState.cpuStrums.members[i].alpha = 0.0001;
    }
}

function onGenerateStaticArrows() {
    oldDadXY.push(PlayState.dad.x); oldDadXY.push(PlayState.dad.y);
    trace(oldDadXY);
}