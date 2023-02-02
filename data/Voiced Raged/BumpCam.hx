function beatHit(curBeat) {
    if (curBeat >= 32 && curBeat < 176 )
    {
        FlxG.camera.zoom += 0.025;
        PlayState.camHUD.zoom += 0.05;
    }
if (curBeat >= 207 && curBeat < 373 )
    {
        FlxG.camera.zoom += 0.025;
        PlayState.camHUD.zoom += 0.05;
    }
}