//a
function create() {
    bartop = new FlxSprite(-50,-10).makeGraphic(1380,100, 0xFF000000);
    bartop.scrollFactor.set(0.0,0.0);
    bartop.cameras = [camHUD];
    PlayState.add(bartop);

    barbot = new FlxSprite(-50,630).makeGraphic(1380,100, 0xFF000000);
    barbot.scrollFactor.set(0.0,0.0);
    barbot.cameras = [camHUD];
    PlayState.add(barbot);
    // FlxG.mouse.visible = false;
}

function ljMoment(toggle:Bool) {
    for (e in [bartop, barbot]) e.visible = toggle;
}