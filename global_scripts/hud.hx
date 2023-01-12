//a

function create() {
    var bartop = new FlxSprite().makeGraphic(FlxG.width*2,100, 0xFF000000);
    bartop.scrollFactor.set();
    bartop.cameras = [camHUD];
    bartop.screenCenter();
    bartop.y = (FlxG.height/2-FlxG.height/2);
    PlayState.add(bartop);

    var barbot = new FlxSprite().makeGraphic(FlxG.width*2,100, 0xFF000000);
    barbot.scrollFactor.set();
    barbot.cameras = [camHUD];
    barbot.screenCenter();
    barbot.y = FlxG.height - barbot.height;
    PlayState.add(barbot);
    // FlxG.mouse.visible = false;
}