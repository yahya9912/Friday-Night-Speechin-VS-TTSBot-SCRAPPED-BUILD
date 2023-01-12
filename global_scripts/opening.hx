var songName = PlayState.song.song.toLowerCase();
var openers:FlxSprite;
var tween:FlxTween;


function create() {
    openers = new FlxSprite(0, 10).loadGraphic(Paths.image('openers/' + songName));
    openers.setGraphicSize(Std.int(openers.width * 0.6));
    openers.updateHitbox();
    openers.cameras = [PlayState.camHUD];
    openers.x = (FlxG.width / 2 - FlxG.width / 2) - openers.width + 10;
}

function onGuiPopup() {
    add(openers);
    FlxTween.tween(openers, {x: (FlxG.width / 2 - FlxG.width / 2) + 10}, 1, {ease: FlxEase.quadInOut, onComplete: function () {
        new FlxTimer().start(1, function(tmr:FlxTimer) {
            FlxTween.tween(openers, {x: (FlxG.width / 2 - FlxG.width / 2) - openers.width + 0}, 1, {ease: FlxEase.backIn});
        });
    }});
}