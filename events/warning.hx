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
        FlxTween.tween(worning, {x: 0}, 0.8,
            {						
                ease: FlxEase.quartInOut
            }	
            );
    });
    new FlxTimer().start(3.5, function(tmr:FlxTimer)
    {
        FlxTween.tween(worning, {x: -9999}, 0.6,
        {						
            ease: FlxEase.smoothStepInOut,
            onComplete: function(twn:FlxTween) {
            worning.destroy();
        }	
        });
    });}