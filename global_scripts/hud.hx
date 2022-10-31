var color:FlxColor = 0xFF000000;

function create() {
    var bartop = new FlxSprite(-50,0).makeGraphic(1380,100);
    bartop.scrollFactor.set(0.0,0.0);
    bartop.cameras = [camHUD];
    bartop.color = color;
    PlayState.add(bartop);

    var barbot = new FlxSprite(-50,620).makeGraphic(1380,100);
    barbot.scrollFactor.set(0.0,0.0);
    barbot.cameras = [camHUD];
    barbot.color = color;
    PlayState.add(barbot);

    FlxG.mouse.visible = false;
}