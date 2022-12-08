//a
var songName = PlayState.song.song.toLowerCase();
var openers:FlxSprite;
var tween:FlxTween;


function create() {
    openers = new FlxSprite(0, 0).loadGraphic(Paths.image('openers/' + songName));
    openers.scale.scale(0.6);
    openers.cameras = [PlayState.camHUD];
    openers.x = (FlxG.width / 2 - FlxG.width / 2) - openers.width + 10;
}

function onGuiPopup() {
    add(openers);
    FlxTween.tween(openers, {x: (FlxG.width / 2 - FlxG.width / 2) + 10}, 1, {ease: FlxEase.backInOut, onComplete: function () {
        new FlxTimer().start(1, function(tmr:FlxTimer) {
            FlxTween.tween(openers, {x: (FlxG.width / 2 - FlxG.width / 2) - openers.width + 10}, 1, {ease: FlxEase.backIn});
        });
    }});
}