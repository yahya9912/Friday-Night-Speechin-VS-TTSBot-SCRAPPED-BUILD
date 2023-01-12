//A
var songName = PlayState.song.song.toLowerCase();
var openers:FlxSprite;
var tween:FlxTween;

function create() {
    if (CoolUtil.difficultyString().toLowerCase() == 'nitro') {
        openers = new FlxSprite(0, 10);
        openers.frames = Paths.getSparrowAtlas('openers/' + songName);
        getFrames(openers, ["nitro"], [true]);
    } else 
        openers = new FlxSprite(0, 10).loadGraphic(Paths.image('openers/' + songName));
    openers.setGraphicSize(Std.int(openers.width * 0.6));
    openers.updateHitbox();
    openers.cameras = [PlayState.camHUD];
    openers.x = (FlxG.width / 2 - FlxG.width / 2) - openers.width- 150;
}

function onGuiPopup() {
    add(openers);
    FlxTween.tween(openers, {x: (FlxG.width / 2 - FlxG.width / 2)}, 1, {ease: FlxEase.quadInOut, onComplete: function () {
        new FlxTimer().start(1, function(tmr:FlxTimer) {
            FlxTween.tween(openers, {x: (FlxG.width / 2 - FlxG.width / 2) - openers.width - 150}, 1, {ease: FlxEase.backIn});
        });
    }});
}
function getFrames(image:FlxSprite, names:Array<String>, looping:Array<Bool>) { // changes the Dialgoue Box image, causes a sec of lag tho
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