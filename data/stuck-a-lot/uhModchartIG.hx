//a
import openfl.filters.ShaderFilter;
import CustomShader;
function update() {
    if (FlxG.keys.justPressed.B) EngineSettings.botplay = !EngineSettings.botplay;
    if (inThingy) PlayState.camFollow.x -= 100;
}
var isAlrMiddleScroll = EngineSettings.middleScroll;
var middleScroll:Array<Int> = [416, 528, 640, 752];
var normal:Array<Int> = [736, 848, 960, 1072];

var musicStarted:Bool = false;
function musicstart() {
    musicStarted = true;
}

var inThingy:Bool = false;
var oldDadXY:Array<Float> = [];
function onPsychEvent(event:String, ?value1:Dynamic, ?value2:Dynamic) {
    switch(event) {
        case "MoveArrowsToMiddle":
            inThingy = true;
            PlayState.scripts.executeFunc("stageChangeVisible", [inThingy]);
            PlayState.scripts.executeFunc("changeCamMovement", [false]);
            PlayState.scripts.executeFunc("ljMoment", [false]);
            PlayState.boyfriend.alpha = 0.0001;
            PlayState.gf.alpha = 0.0001;
            PlayState.camGame.alpha = 0.0001;
            PlayState.camHUD.alpha = 0.0001;
            PlayState.dad.screenCenter();
            PlayState.dad.x += 550;
            PlayState.dad.y += 100;
            defaultCamZoom = 1.2;
            boyfriendFP.alpha = 1;
            PlayState.camGame.filtersEnabled = true;
            new FlxTimer().start(.5, function(tmr:FlxTimer) {
                FlxTween.tween(camHUD, {alpha: 0.75}, 1, {ease: FlxEase.expoIn});
                FlxTween.tween(camGame, {alpha: 1}, 1, {ease: FlxEase.expoIn});
            });
            if (isAlrMiddleScroll) return;
            for (i in 0...PlayState.playerStrums.members.length) {
                PlayState.playerStrums.members[i].x = middleScroll[i];
                PlayState.cpuStrums.members[i].alpha = 0.0001;
            }
        case "Hide Hud":
            FlxTween.tween(camHUD, {alpha: 0}, 1, {ease: FlxEase.quadOut});
            FlxTween.tween(boyfriendFP, {alpha: 0}, 0.5, {ease: FlxEase.expoIn});
    }
}

var funnyAbliteration:CustomShader;
function createPost() {
    boyfriendFP = new Boyfriend(PlayState.boyfriend.x+400, PlayState.boyfriend.y+400, mod + ":bf-fp");
    boyfriendFP.alpha = 0.0001;
    add(boyfriendFP);
    boyfriends.push(boyfriendFP);
    
    funnyAbliteration = new CustomShader(mod + ":daFunnyChrom");
    funnyAbliteration.data.amount.value = [0.5];
    PlayState.camGame.setFilters([new ShaderFilter(funnyAbliteration)]);
    PlayState.camGame.filtersEnabled = false;
}
function beatHit(curBeat) {
    if (inThingy) {
        funnyAbliteration.data.amount.value = [2];
        FlxTween.num(funnyAbliteration.data.amount.value[0], 0.7, 0.25, {ease: FlxEase.linear}, function(v:Float) {
            funnyAbliteration.data.amount.value[0] = v;
        });
    }
}

function uhIdk() {
    defaultCamZoom = 0.6;
}

function ending() {
    defaultCamZoom = 0.5;
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
    boyfriendFP.alpha = 0.0001;
    PlayState.camGame.filtersEnabled = false;
    PlayState.camGame.alpha = 0.0001;
    camHUD.alpha = 0.0001;
    FlxTween.tween(camHUD, {alpha: 1}, 0.5, {ease: FlxEase.expoIn});
    FlxTween.tween(camGame, {alpha: 1}, 1, {ease: FlxEase.expoIn});
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