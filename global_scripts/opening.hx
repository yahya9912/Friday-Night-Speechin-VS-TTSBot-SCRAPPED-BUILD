import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
var songName = PlayState.song.song.toLowerCase();
var openers:FlxSprite;
var tween:FlxTween;


function create(){
    openers = new FlxSprite(-1500, 0).loadGraphic(Paths.image('openers/' + songName));
    openers.setGraphicSize(Std.int(openers.width * 0.6));
    openers.updateHitbox();

    openers.antialiasing = true;
    openers.cameras = [PlayState.camHUD]; 
}

function onGuiPopup() {
    add(openers);
}

function postUpdate(elapsed:Float){    
    new FlxTimer().start(1.0, function(tmr:FlxTimer)
    {
        FlxTween.tween(openers, {x: -5}, 1,
            {						
                ease: FlxEase.quadInOut
            }	
            );
    });
    new FlxTimer().start(4.5, function(tmr:FlxTimer)
    {
        FlxTween.tween(openers, {x: -9999}, 1,
        {						
            ease: FlxEase.quadInOut,
            onComplete: function(twn:FlxTween) {
            openers.destroy();
        }	
        });
    });}