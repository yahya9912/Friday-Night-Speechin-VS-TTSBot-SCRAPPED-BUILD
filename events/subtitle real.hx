var songName = PlayState.song.song.toLowerCase();

function text(value:String){
    var subtitle = new FlxText(0, 0, 0, "poop haha");
    subtitle.setFormat(Paths.font("vcr.ttf"), 48, 0xFF0b85d6);

    subtitle.screenCenter();
    subtitle.scrollFactor.set();
    subtitle.cameras = [camHUD];
    subtitle.text = value;
    PlayState.add(subtitle);
    trace(subtitle.text);

    new FlxTimer().start(0.2, function(tmr:FlxTimer)
        {
            FlxTween.tween(subtitle, {alpha: 0}, 0.6,
                {						
                    ease: FlxEase.quadInOut,
                    onComplete: function(twn:FlxTween) {
                        subtitle.destroy();
                    }
                }	
                );
        });
    }
