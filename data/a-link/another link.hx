import openfl.filters.ShaderFilter;

var trippyshader:ShaderFilter;
var time = 0;

function onDadHit(note:Note){
    if(PlayState.health <= (4 / 100 * PlayState.maxHealth)){
        return;
    }
    else{
        if (note.isSustainNote) {
            PlayState.currentSustains.push({time: Conductor.songPosition, healthVal: -note.sustainHealth * (global["lampChange"] == true ? 2 : 1)});
        } else {
            if (PlayState.health > 0.25)
                PlayState.health -= (1 / 100 * PlayState.maxHealth) * (global["lampChange"] == true ? 2 : 1);
	 }
   
    }
}
var missingNo:ShaderFilter;
var missingNoCamGame:ShaderFilter;
var abliteration:FlxTween;
function create() {
    abliteration = FlxTween.tween(this, {}, 0);
    EngineSettings.botplay = true;
}

var canMISSING:Bool = false;
function beatHit(curBeat) {
    var chance = FlxG.random.bool(20);
    if ((PlayState.dad.animation.curAnim.name == "idle" && PlayState.dad.animation.curAnim.name != null) || chance) {
    if ((curBeat % FlxG.random.int(1, 5)) || chance && curBeat % FlxG.random.int(2, 5))
        canMISSING = true;
    else
        canMISSING = false;
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

function createPost() {
    trippyshader = new CustomShader(mod + ":vhs");
	PlayState.camGame.setFilters([new ShaderFilter(trippyshader)]);
	trippyshader.data.iTime.value = [0.002];
    
    missingNo = new CustomShader(mod + ":MISSINGNO!!");
	PlayState.dad.shader = missingNo;
	PlayState.iconP2.shader = missingNo;
    missingNo.data.binaryIntensity.value = [1000];
	// missingNo.data.intensityChromatic.value = [1000];
	// missingNo.data.time.value = [9];
	// missingNo.data.prob.value = [50];
    PlayState.camGame.filtersEnabled = true;
}

function onGenerateStaticArrows() {
    for(e in PlayState.cpuStrums) {
        e.shader = missingNo;
    }
}

function update(elapsed){
    time++;
    if (PlayState.health <= 0.2)
          FlxG.camera.shake(.005,.1);
    if (canMISSING)
        missingNo.data.binaryIntensity.value = [1 / FlxG.random.int(1, 4)];
    else
        missingNo.data.binaryIntensity.value = [1000];
}

