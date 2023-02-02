//a // how dare you fucking capitalize the Sacret a !!
var songName = PlayState.song.song.toLowerCase();
var openers:Dynamic;
var tween:FlxTween;
function create() {
    var path = 'openers/' + songName;
    if (!Assets.exists(Paths.getSparrowAtlas(path))) {
        openers = new FlxText(0,10,0, "huh, no Opener... Wierd", 16);
        openers.updateHitbox();
        openers.cameras = [PlayState.camHUD];
        openers.x = (FlxG.width / 2 - FlxG.width / 2) - openers.width - 150;
        return;
    }
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