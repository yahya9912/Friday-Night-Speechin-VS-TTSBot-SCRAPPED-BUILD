//a
import flixel.FlxCamera;
import LoadingState;
import CoolUtil;
import Settings;
import openfl.filters.ShaderFilter;

var characters:Array<String> = [
    "PastaSelect_MX_0",
    "PastaSelect_LordX_0",
    "PastaSelect_Hypno_0"
];

var spritesChar:Array<FlxSprite> = []; 
var selectCam:FlxCamera;
var selectorArrow:FlxSprite;
var displacementList:Array<Int> = [-4, 2, 0];

    save.data.playLordX = null;
    save.data.playHypno = null;
    save.data.playMX = null;
    save.flush();

var crt:ShaderFilter;
function create() {
    FlxG.state.persistentUpdate = false; // bugs
    FlxG.state.persistentDraw = false;
    if (FlxG.sound.music != null)
        FlxG.sound.music.stop();
    FlxG.sound.playMusic(Paths.music("PastaNightSelect"), 1);

    selectCam = new FlxCamera(0, 0, 768, 672);
    FlxG.cameras.reset(selectCam);

    crt = new CustomShader(mod + ":crt");
	selectCam.setFilters([new ShaderFilter(crt)]);
	crt.data.time.value = [0.0];
    selectCam.filtersEnabled = true;
    // lmao
    // lol i stole your code :troll:
    selectCam.x += (FlxG.width / 2 - selectCam.width / 2);
    selectCam.y += (FlxG.height / 2 - selectCam.height / 2);

    var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('pastaCutscene/PastaSelect_BG'));
    var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('pastaCutscene/PastaSelect_BG'));
    bg.setGraphicSize(Std.int(bg.width * 3));
    bg.setPosition(selectCam.width / 2 - bg.width / 2, selectCam.height / 2 - bg.height / 2);
    add(bg);

    for (i in 0...characters.length) {
        var itsPastaTime:FlxSprite = new FlxSprite().loadGraphic(Paths.image("pastaCutscene/" + characters[i] + "3"));
        itsPastaTime.setGraphicSize(Std.int(itsPastaTime.width * 3));
        itsPastaTime.setPosition(bg.x + bg.width / 2 - itsPastaTime.width / 2, bg.y + bg.height / 2 - itsPastaTime.height / 2);
        itsPastaTime.x += (i - 1) * (3 * 45) + 3;
        itsPastaTime.x = Std.int(itsPastaTime.x);
        itsPastaTime.y = (176 * 3) - itsPastaTime.height + (displacementList[i] * 3);
        itsPastaTime.ID = i;
        spritesChar.push(itsPastaTime);
        add(itsPastaTime);
    }
    selectorArrow = new FlxSprite().loadGraphic(Paths.image('pastaCutscene/PastaSelect_Arrow'));
    selectorArrow.setGraphicSize(Std.int(selectorArrow.width * 3));
    add(selectorArrow);

    eatPasta(0);
}

// keys cool
var controls = FlxG.keys.pressed;
var controlsJust = FlxG.keys.justPressed;
var controlsJustNUM = FlxControls.anyJustPressed;
var controlsNUM = FlxControls.anyPressed;

var selected:Bool = false;
var totalElapsed:Float = 0;
function update(elapsed) {
    totalElapsed += elapsed;
    if (controlsJust.A && !selected)
        eatPasta(-1);
    if (controlsJust.D && !selected)
        eatPasta(1);

    if (controlsJustNUM([13]) && !selected)
        selectedYay();
    if (crt != null)
        crt.data.time.value = [totalElapsed];
}

function selectedYay() {
    selected = true;
    switch(selectedCharacter){ 
        case 0:
            save.data.playMX = true;
        case 1:
            save.data.playLordX = true;
        case 2:
            save.data.playHypno = true;
        default:
            save.data.playMX = null;
            save.data.playLordX = null;
            save.data.playHypno = null;
    }
    for (spr in spritesChar) {
        if (selectedCharacter == spr.ID) {
            spr.loadGraphic(Paths.image("pastaCutscene/" + characters[spr.ID] + "2"));
            new FlxTimer().start(0.5, function(tmr:FlxTimer) {
                spr.loadGraphic(Paths.image("pastaCutscene/" + characters[spr.ID] + "1"));
                new FlxTimer().start(0.5, function(tmr:FlxTimer) {
                    LoadingState.loadAndSwitchState(new PlayState());
                    // close();
                });
            });
        }
    }
}

var selectedCharacter:Int = 0;
function eatPasta(sus:Int = 0) {

    selectedCharacter += sus;
    if (selectedCharacter >= characters.length)
        selectedCharacter = 0;
    if (selectedCharacter < 0)
        selectedCharacter = characters.length - 1;

    for (spr in spritesChar) {
        if (selectedCharacter == spr.ID) {
            spr.loadGraphic(Paths.image("pastaCutscene/" + characters[spr.ID] + "1"));
            selectorArrow.setPosition(spritesChar[selectedCharacter].x + spritesChar[selectedCharacter].width / 2 - selectorArrow.width / 2, 124 * 3);
        }
        else
            spr.loadGraphic(Paths.image("pastaCutscene/" + characters[spr.ID] + "3"));
        
    }
}