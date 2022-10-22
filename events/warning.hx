import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
var worning:FlxSprite;

function create(){
    worning = new FlxSprite(2280,0).loadGraphic(Paths.image('warming'));
    worning.cameras = [camHUD];
    worning.scrollFactor.set();
    add(worning);

    }

function postUpdate(elapsed:Float){    
    new FlxTimer().start(1.0, function(tmr:FlxTimer)
    {
        FlxTween.tween(worning, {x: 0}, 1,
            {						
                ease: FlxEase.quadInOut
            }	
            );
    });
    new FlxTimer().start(3.5, function(tmr:FlxTimer)
    {
        FlxTween.tween(worning, {x: -9999}, 1,
        {						
            ease: FlxEase.quadInOut,
            onComplete: function(twn:FlxTween) {
            worning.destroy();
        }	
        });
    });}