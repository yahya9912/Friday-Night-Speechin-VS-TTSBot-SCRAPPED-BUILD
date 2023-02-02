//a
var bars:Array<FlxSprite> = [];
function create() {
    // bartop = new FlxSprite(-50,-10).makeGraphic(1380,100, 0xFF000000);
    // bartop.scrollFactor.set(0.0,0.0);
    // bartop.cameras = [camHUD];
    // PlayState.add(bartop);

    // barbot = new FlxSprite(-50,630).makeGraphic(1380,100, 0xFF000000);
    // barbot.scrollFactor.set(0.0,0.0);
    // barbot.cameras = [camHUD];
    // PlayState.add(barbot);
    // // FlxG.mouse.visible = false;

    // LJ is going to fix yourr damn code AGAIN!!!
    for (i in 0...2) {
        var bar:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, 100);
        bar.scrollFactor.set();
        bar.cameras = [PlayState.camHUD];
        bar.y = (i == 0) ? FlxG.height + bar.height/2 : (FlxG.height/2+FlxG.height/2) - bar.height/2;
        add(bar);
        bars.push(bar);
    }
}

function ljMoment(toggle:Bool) {
    for (e in bars) e.visible = toggle;
}