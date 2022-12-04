import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
//code by W0CKY lmfaoaoaoaoao
function scare(value) {
    var length:Float = Std.parseFloat(value);
    var newJumpscare:FlxSprite;
    
    newJumpscare = new FlxSprite(0,0).loadGraphic(Paths.image('raaa'));
  
    newJumpscare.cameras = [PlayState.camHUD];
  //  newJumpscare.scale.scale(1.175);
    newJumpscare.scrollFactor.set();
   // newJumpscare.screenCenter();
    PlayState.add(newJumpscare);
 //  FlxG.sound.play(Paths.sound('shart'), 100);
   

    new FlxTimer().start(value ,function(tmr:FlxTimer)
        {
            FlxTween.tween(newJumpscare, {alpha: 0}, 0.4, { ease: FlxEase.quadInOut,  onComplete: function(twn:FlxTween) {newJumpscare.destroy();}});

        });
       /* if (curStep != null){  
            newJumpscare.x = FlxG.random.int(-100,100);
            newJumpscare.y = FlxG.random.int(-100, 100);
            }*/
         if (EngineSettings.downscroll)
                trace('lmfao yo pc ass');


}

function postUpdate(elapsed:Float){  



  /* if (!EngineSettings.downscroll){  
    Window.frameRate = FlxG.random.int(30, 60);
    trace('yo pc as LLLL')
    }*/
}
function onDadHit(event:NoteHitEvent) {

 //   scare(0.01);
}