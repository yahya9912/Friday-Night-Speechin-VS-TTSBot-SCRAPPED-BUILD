import openfl.filters.ShaderFilter;

var trippyshader:ShaderFilter;
var time = 0;

function onDadHit(note:Note){
    if (PlayState.health <= (4 / 100 * PlayState.maxHealth)) return;
    else {
        if (funnyLoseHealth) PlayState.health += (note.isSustainNote) ? 0.03125/2 : 0.125/2;
        if (note.isSustainNote) {
            PlayState.currentSustains.push({time: Conductor.songPosition, healthVal: -note.sustainHealth * (global["lampChange"] == true ? 2 : 1)});
        } else {
            if (PlayState.health > 0.25)
                PlayState.health -= (1 / 100 * PlayState.maxHealth) * (global["lampChange"] == true ? 2 : 1);
	 }
   
    }
    constantMissNo.data.binaryIntensity.value = [1 / FlxG.random.float(0.25, 1)];
}
var missingNo:ShaderFilter;
var missingNoCamGame:ShaderFilter;
function onPlayerHit(note:Note) {
    constantMissNo.data.binaryIntensity.value = [1 / FlxG.random.float(0.25, 1)];
    if (PlayState.health <= 0.25) return;
    if (funnyLoseHealth) PlayState.health -= (note.isSustainNote) ? 0.03125/2 : 0.125/2;
}

function onGenerateStaticArrows() {
    for (e in PlayState.cpuStrums.members) e.alpha = 0;
}

var canMISSING:Bool = false;
var funnyLoseHealth:Bool = false;
function beatHit(curBeat) {
    if (curBeat % 4 == 0) {
        funnyLoseHealth = FlxG.random.bool(10);
    }

    var chance = FlxG.random.bool(20);
    if ((PlayState.dad.animation.curAnim.name == "idle" && PlayState.dad.animation.curAnim.name != null) || chance) {
    if ((curBeat % FlxG.random.int(1, 5)) || chance && curBeat % FlxG.random.int(2, 5))
        canMISSING = true;
    else
        canMISSING = false;
    }
    if (curBeat >= 224 && curBeat < 226)
        constantMissNoLess.data.binaryIntensity.value = [1 / FlxG.random.float(2.5,5)];
    else 
        constantMissNoLess.data.binaryIntensity.value = [1 / FlxG.random.float(0.25, 0.75)];
    switch(curBeat) {
        case 128:
            PlayState.timerNow.shader = constantMissNo;
            PlayState.timerFinal.shader = constantMissNo;
            PlayState.camHUD.setFilters([new ShaderFilter(constantMissNoLess)]);
            PlayState.camHUD.filtersEnabled = true;
        case 226:
            for (e in PlayState.playerStrums.members) {
                e.shader = constantMissNo;
            }
            PlayState.camHUD.filtersEnabled = false;
    }
    if (beatShaderCool) {
        if (killMe2 != null) killMe2.cancel();
        funnyAbliteration.data.amount.value = [beatStartVal];
        killMe2 = FlxTween.num(funnyAbliteration.data.amount.value[0], beatToVal, beatTime, {ease: FlxEase.linear}, function(v:Float) {
            funnyAbliteration.data.amount.value[0] = v;
        });
    }

    // if (FlxG.random.bool(1)) {
    //     canMISSING = true;
    //     PlayState.iconP1.shader = missingNo;
    //     PlayState.boyfriend.shader = missingNo;
	// 	PlayState.iconP1.changeCharacter("placeholder", mod);
    //     PlayState.health += 0.0001;
    //     PlayState.health -= 0.0001;
    // } else {
    //     canMISSING = false;
    //     PlayState.iconP1.shader = null;
    //     PlayState.boyfriend.shader = null;
	// 	PlayState.iconP1.changeCharacter("bf tts", mod);
    //     PlayState.health += 0.0001;
    //     PlayState.health -= 0.0001;
    // }
}

var killMe:FlxTween;
var killMe2:FlxTween;
function shaderGO(valueStart:Float = 2.0, valueTo:Float = 0.5, time:Float = 0.25) {
    if (killMe != null) killMe.cancel();
    funnyAbliteration.data.amount.value = [valueStart];
    killMe = FlxTween.num(funnyAbliteration.data.amount.value[0], valueTo, time, {ease: FlxEase.linear}, function(v:Float) {
        funnyAbliteration.data.amount.value[0] = v;
    });
}
function bgStuff(?force) {
	if (force == "true") force = true;
	else force = false;
    PlayState.scripts.executeFunc("toggleBGbeat", [force]);
}
var beatShaderCool:Bool = false;
var beatStartVal:Float = 0.0;
var beatToVal:Float = 0.0;
var beatTime:Float = 0.0;
function toggleShaderBeat(?startVal:Float, ?toVal:Float, ?time:Float, ?forceToggle:String) {
    if (forceToggle == "true") forceToggle = true;
    else if (forceToggle == "false") forceToggle = false;
    beatStartVal = startVal;
    beatToVal = toVal;
    beatTime = time;
    if (forceToggle == null) beatShaderCool = !beatShaderCool;
    else beatShaderCool = forceToggle;
}
function camZoom(valueTo:Float, time:Float = 1, tween:Bool) {
    return;
    if (tween) {
    FlxTween.num(FlxG.camera.zoom, valueTo, time, {ease: FlxEase.linear}, function(v:Float) {
        FlxG.camera.zoom = v;
        trace(FlxG.camera.zoom);
    });
    } else FlxG.camera.zoom = valueTo;
}

function updatePost() {
    if (curBeat >= 128 && curBeat < 208) {
        PlayState.timerNow.text = "???";
        PlayState.timerFinal.text = "???";
    }
}

function createPost() {
    trippyshader = new CustomShader(mod + ":old");
	trippyshader.data.iTime.value = [0.002];
    
    missingNo = new CustomShader(mod + ":MISSINGNO!!");
	PlayState.dad.shader = missingNo;
	PlayState.iconP2.shader = missingNo;
    missingNo.data.binaryIntensity.value = [1000];
	// missingNo.data.intensityChromatic.value = [1000];
	// missingNo.data.time.value = [9];
	// missingNo.data.prob.value = [50];
    
    funnyAbliteration = new CustomShader(mod + ":daFunnyChrom");
    funnyAbliteration.data.amount.value = [0.5];
    
	PlayState.camGame.setFilters([new ShaderFilter(trippyshader), new ShaderFilter(funnyAbliteration)]);
    PlayState.camGame.filtersEnabled = true;
    
    constantMissNo = new CustomShader(mod + ":MISSINGNO!!");
    constantMissNo.data.binaryIntensity.value = [1000];

    constantMissNoLess = new CustomShader(mod + ":MISSINGNO!!");
    constantMissNoLess.data.binaryIntensity.value = [1000];
}

function update(elapsed){
    if (PlayState.health <= 0.2) FlxG.camera.shake(.005,.1);
    if (canMISSING)
        missingNo.data.binaryIntensity.value = [1 / FlxG.random.int(1, 4)];
    else
        missingNo.data.binaryIntensity.value = [1000];
    
    
    for (e in PlayState.cpuStrums.members) e.alpha = 0.5 + Math.sin(Conductor.songPosition / 300) / 2;
    for (note in PlayState.notes) {
        if (!note.mustPress) note.alpha = 0.5 + Math.sin(Conductor.songPosition / 300) / 2;
    }
}

function create() {
    PlayState.gf.visible = false;
    if (EngineSettings.middleScroll == false) {
        EngineSettings.middleScroll = true;
    }
}