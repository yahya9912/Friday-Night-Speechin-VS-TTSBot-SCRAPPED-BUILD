function beatHit(curBeat:Int) {
    switch (curBeat)
    {
        case 576:
            //insert a thank you for playing image :D
        case 592: //should be the song's end
            FlxG.sound.music.stop();
            FlxG.switchState(new TitleState()); //title cuz this is the last song you play in the mod
    }
}

function beatHit(curBeat) {
    if (curBeat >= 260 && curBeat < 324)
    {
        FlxG.camera.zoom += 0.015;
        PlayState.camHUD.zoom += 0.03;
    }
}