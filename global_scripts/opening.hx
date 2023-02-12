//a // how dare you fucking capitalize the Sacret a !!
import GameOverSubstate;
import sys.io.File;
var songName = PlayState.song.song.toLowerCase();
var openers:Dynamic;
var tween:FlxTween;
GameOverSubstate.gameOverMusic = "gameOver";
GameOverSubstate.retrySFX = "gameOverEnd";
GameOverSubstate.scriptName = mod + ":deathStates/defaultDeath";
function create() {
    var path = 'openers/' + songName;
    if (CoolUtil.difficultyString().toLowerCase() == 'nitro') {
        openers = new FlxSprite(0, 10);
        openers.frames = Paths.getSparrowAtlas('openers/' + songName);
        getFrames(openers, ["nitro"], [true]);
    } else 
        openers = new FlxSprite(0, 10).loadGraphic(Paths.image('openers/' + songName));
    
    openers.setGraphicSize(Std.int(openers.width * 0.6));
    openers.updateHitbox();
    openers.cameras = [PlayState.camHUD];
    openers.x = (FlxG.width / 2 - FlxG.width / 2) - openers.width - 150;
    add(openers);
    deathStateMedals();
}

function deathStateMedals() {
    var daSaveFunny:Array<Dynamic> = [
        [2, "zanderStuff"], // zanderStuff
        [2, "ljStuff"], // ljStuff
        [0, "diamondStuff"], // diamondStuff
        [4, "ttsStuff"], // ttsStuff
        [1, "wizardStuff"], // wizardStuff
        [1, "alexgStuff"],  // alexgStuff
        [23, "memes"]
    ];
    var arry = [
        save.data.zanderStuff,
        save.data.ljStuff,
        save.data.diamondStuff,
        save.data.ttsStuff,
        save.data.wizardStuff,
        save.data.alexgStuff,
        save.data.memesLOL
    ];
    for (i in 0...daSaveFunny.length) {
    if (daSaveFunny[i][0] == null || daSaveFunny[i][0] == 0) continue;
    if (daSaveFunny[i][1] == "memes") {
        if (arry[i].length-1 < daSaveFunny[i][0]) continue;
    } else {
        if (arry[i] < daSaveFunny[i][0]) continue;
    }
    trace("didn't continue, award");
    switch(daSaveFunny[i][1]) {
        case "zanderStuff":
            Medals.unlock("Zander Stop Being Dead");
        case "ljStuff":
            Medals.unlock("MR COOL !!");
        case "diamondStuff":
            Medals.unlock("El Diamond Jaja");
        case "ttsStuff":
            Medals.unlock("Stop Linking Stuff");
        case "wizardStuff":
            Medals.unlock("Hat Of The Wizard");
        case "alexgStuff":
            Medals.unlock("Alex GUH?");
        case "memes":
            Medals.unlock("Too Many Memes");
            var p = Paths.json('medals', 'mods/'+mod);
            var medalJSON:Dynamic;
            if (!Assets.exists(p)) return;
                medalJSON = Json.parse(Assets.getText(p));
            for (lol in medalJSON.medals) {
                if (lol.name != "Too Many Memes") continue;
                lol.desc = "Find All The Hidden Memes In Game Over";
                File.saveContent('mods/'+mod+"/medals.json", Json.stringify(medalJSON, null, "\t"));
            }
    }
}
}

function musicstart() {
    if (PlayState.song.song.toLowerCase() == "shit-vc") return;
    doOpener();
}
function doOpener() {
    if (openers == null) return; // just in case someone does an unfunny thing
    FlxTween.tween(openers, {x: (FlxG.width / 2 - FlxG.width / 2)}, 1, {ease: FlxEase.quadInOut, onComplete: function () {
        new FlxTimer().start(1, function(tmr:FlxTimer) {
            FlxTween.tween(openers, {x: (FlxG.width / 2 - FlxG.width / 2) - openers.width - 150}, 1, {ease: FlxEase.backIn, onComplete: function() {
                openers.destroy();
            }});
        });
    }});
}
function getFrames(image:FlxSprite, names:Array<String>, looping:Array<Bool>) { // me when LJ (Myself) steals his own code that was stolen :troll:
    availableAnims = [];
    var numbers = ["0","1","2","3","4","5","6","7","8","9"];
    if (image.frames != null) {
        for(e in image.frames.frames) {
            var animName = e.name;
            while (numbers.contains(animName.substr(-1))) {
                animName = animName.substr(0, animName.length - 1);
            }
            if (!availableAnims.contains(animName))
                availableAnims.push(animName);
        }
    }
    for (i in 0...availableAnims.length) {
        image.animation.addByPrefix(names[i], availableAnims[i], 24, looping[i]);
    }
    image.animation.play(names[0]);
    image.updateHitbox();
}