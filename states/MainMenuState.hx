function create() {
    normalCreate();
    FlxG.mouse.useSystemCursor = true;


    menuItems.setGraphicSize(Std.int(menuItems.width * 0.6));
    menuItems.x = 0;

}

function beatHit(curBeat) {
    normalBeatHit();
}
function update(elapsed:Float) {
    normalUpdate(elapsed);
    trace(menuItems.x);
}
