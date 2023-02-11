//a
import flixel.FlxCamera;
import flixel.input.mouse.FlxMouseEventManager;
import CoolUtil;

var canSel:Bool = false;
var bg:FlxSprite;
function preCreate() {
	camOther = new FlxCamera();
	camOther.bgColor = 0;
	FlxG.cameras.add(camOther);
    camOther.alpha = 0.001;

    bg = new FlxSprite().makeGraphic(FlxG.width*1.5, FlxG.height*1.5, 0xff000000);
    bg.screenCenter();
    bg.alpha = 0.75;
    bg.cameras = [camOther];
    add(bg);
}

var paused:FlxText;
var descPaused:FlxText;
var funnySongs:Array<Strings> = [
    "stuck-a-lot", "hello", "shit-vc"
];
var funnyRNGtext:Array<Array<String>> = [
    ["User Has Paused... The... Wait\n How did you... You can't... no\n
    ...", "Usor Had Puased Da Gane !!1!!1!", 
    "User Paused At An LJ Moment"],
    ["Hi, Im ItsLJcool", "User Has Paused The Game... Pussy", "User Got Ratio'd On Twitter", "I Don't Know What Im Doing Anymore",
     "var paused:Bool = false;\nfunction onEnter() {\n      paused = true;\n}\n", "User Paused At An LJ Moment"],
    ["This channel smells like shit", "Fun Fact: There Is A Secret Song Somewhere in the pause menu\nDon't Tell the devs this\n-LJ\n"]
];

var daMenu:Array<String> = [
    "resume",
    "restart",
    "exit"
];
var daMenuItems:Array<FlxSprite> = [];
var moused:Bool = false;
function createPost() {
    for (item in grpMenuShit.members) {
        item.destroy();
    }
    state.blueballAmount.text = "";
	if (PlayState.chartTestMode) state.blueballAmount.text += 'CHART TESTING MODE';
	else state.blueballAmount.text += 'Bans: '+PlayState.blueballAmount;
    state.blueballAmount.updateHitbox();

    for (uh in [state.levelInfo, state.levelDifficulty, state.blueballAmount]) {
        uh.cameras = [camOther];
        uh.font = Paths.font("discordFonts/GG_SANS_SEMIBOLD.ttf");
    }
    paused = new FlxText(0,0,0, "Stream Is Paused", 64);
    paused.font = Paths.font("discordFonts/GG_SANS_EXTRABOLD.ttf");
    paused.updateHitbox();
    paused.screenCenter();
    paused.y -= 100;
    paused.cameras = [camOther];
    add(paused);

    descPaused = new FlxText(0,0,0, "The User Has Paused The Game", 32);
    descPaused.font = Paths.font("discordFonts/GG_SANS_MEDIUM.ttf");
    descPaused.updateHitbox();
    descPaused.screenCenter();
    descPaused.y = paused.y + paused.height;
    descPaused.cameras = [camOther];
    add(descPaused);
    for (i in 0...funnySongs.length) {
        if (funnySongs[i] != PlayState.song.song.toLowerCase()) continue;
        if (!FlxG.random.bool(85)) continue;
        var randomInt = FlxG.random.int(0,funnyRNGtext[i].length-1);
        descPaused.text = funnyRNGtext[i][randomInt];
        descPaused.updateHitbox();
        descPaused.screenCenter();
        descPaused.y = paused.y + paused.height;
    }

    for (i in 0...daMenu.length) {
        var bgItem:FlxSprite = new FlxSprite().loadGraphic(Paths.image("pauseMenu/"+daMenu[i]));
        bgItem.updateHitbox();
        bgItem.antialiasing = true;
        bgItem.cameras = [camOther];
        bgItem.screenCenter();
        if (daMenuItems[i-1] != null) bgItem.x = daMenuItems[i-1].x + daMenuItems[i-1].width + 25;
        else bgItem.x = paused.x - paused.x/2 + paused.width/2+25;
        bgItem.y = descPaused.y + descPaused.height + 25;
        bgItem.ID = i;
        FlxMouseEventManager.add(bgItem, function(){}, function(){onSelect();}, function(){
            moused = true;
            discordSel = bgItem.ID;
            newChangeSel(0);
        });
        daMenuItems.push(bgItem);
        add(bgItem);
    }

    FlxTween.tween(camOther, {alpha: 1}, 0.25, {ease: FlxEase.quadOut, onComplete: function() {
        canSel = true;
    }});
    newChangeSel(0);
}

var discordSel:Int = 0;
function onSelect() {
    if (!canSel) return false;
    switch(discordSel) {
        case 0:
            FlxTween.tween(camOther, {alpha: 0}, 0.25, {ease: FlxEase.quadOut, onComplete: function() {
                close();
            }});
        case 1:
            FlxG.resetState();
        case 2:
            FlxG.switchState(new MainMenuState());
    }
    
    
    return false; // this is here to insure it doens't accidenlty selects still;
}

function newChangeSel(bruh:Int = 0) {
    discordSel = CoolUtil.wrapInt(discordSel+bruh, 0, daMenuItems.length);
    moused = false;
    for (item in daMenuItems) {
        if (item.ID != discordSel) {
            item.color = 0xFFFFFFFF; continue;
        }
        item.color = 0xFF808080;
    }
    return false;
}
var keys = FlxG.keys;
function update() {

    if (keys.justPressed.S || keys.justPressed.DOWN) newChangeSel(-1);
    if (keys.justPressed.W || keys.justPressed.UP) newChangeSel(1);

    state.levelInfo.x = 0 - 40;
    state.levelInfo.y = FlxG.height - state.levelInfo.height;
    state.levelDifficulty.setPosition(state.levelInfo.x + state.levelInfo.width + 20, state.levelInfo.y);
    state.blueballAmount.setPosition(state.levelDifficulty.x + state.levelDifficulty.width + 20, state.levelInfo.y);
}