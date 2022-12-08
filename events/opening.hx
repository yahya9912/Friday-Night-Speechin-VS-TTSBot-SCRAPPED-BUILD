//a
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
var songName = PlayState.song.song.toLowerCase();
var openers:FlxSprite;
var tween:FlxTween;


function create(){
    openers = new FlxSprite(0, (PlayState.guiSize.y / 2) - 20);
    var tex = Paths.getSparrowAtlas('openers/' + songName);
    openers.frames = tex;
    openers.animation.addByPrefix('speechin', "speechin", 24);
    
    
    /*openers.setGraphicSize(Std.int(openers.width*.85));
    openers.updateHitbox();
    add(openers);*/

    openers.antialiasing = true;
    openers.cameras = [PlayState.camHUD]; 
}

function onGuiPopup() {
    openers.animation.play(songName, false);
    add(openers);
}

/*function postUpdate(val:Int){
    FlxTween.tween(openers, {x: -25, alpha: 1}, 1, {
        ease: FlxEase.quartInOut,
        startDelay: 0,
        onComplete: function(twn:FlxTween)
        {
            FlxTween.tween(openers, {x: -openers.width, alpha: 0}, 1, {
                ease: FlxEase.quartInOut,
                startDelay: 1,
                onComplete: function(twn:FlxTween)
                {
                    openers.destroy();
                    camfreeze = false;
                }
            });
        }
    });
}*/