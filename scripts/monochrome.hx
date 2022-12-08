import Sys;
var health:FlxText;
function create() {
    PlayState.boyfriend.visible = false;
    PlayState.gf.visible = false;
    if (EngineSettings.botplay == true) {
        Sys.exit(0);
    }
    if (EngineSettings.middleScroll == false) {
        EngineSettings.middleScroll = true;
    }
    
    healthTxt = new FlxText(580, Window.height * 0.2, 0, "HEALTH: ?");
    healthTxt.setFormat(Paths.font("vcr.ttf"), 24);
    healthTxt.cameras = [camHUD];
    PlayState.add(healthTxt);

}

function onGuiPopup() {
    PlayState.healthBar.visible = false;
    PlayState.healthBarBG.visible = false;
    PlayState.iconP1.visible = false;
    PlayState.iconP2.visible = false;
    PlayState.scoreTxt.visible = false;
    if (EngineSettings.botplay == true) {
        PlayState_.destroy;

    }
}

function onPlayerHit(){
    healthTxt.text = "HEALTH: " + Std.int(health * 50);
    if (rating = 'sick')
    health = FlxG.random.float(1,2);
    else
        {health = FlxG.random.float(1,2);}
}

