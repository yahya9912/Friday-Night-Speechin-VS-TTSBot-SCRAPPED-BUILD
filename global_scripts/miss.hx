var healthTxt = FlxText;
function onPlayerHit(direction:Int) {

    PlayState.noteMiss();
    health = health - 0.00000003;
    healthTxt = new FlxText(0, Window.height * 0.65, 0, "");
    healthTxt.text = "health:" + Std.int(health);
    healthTxt.setFormat(Paths.font("sonic.ttf"), 24);
    healthTxt.cameras = [camHUD];
    PlayState.add(healthTxt);
}
