//a
import flixel.math.FlxMath;
import flixel.effects.FlxFlicker;
import flixel.input.mouse.FlxMouseEventManager;
import sys.FileSystem;
import sys.io.Process;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.group.FlxTypedGroup;
import haxe.io.Path;
import Date;
import Sys;
import StringTools;
import Conductor;
import ModSupport;

entirelyCustom = true;

var theSystem = Sys.systemName();
var homeDir = Sys.getEnv(if (Sys.systemName() == "Windows") "UserProfile" else "HOME");

var theScrollBG:FlxSprite;
var rightBar:FlxSprite;
var bars:FlxSprite;

var curDay:FlxText;
var curTime:FlxText;

var menuNames:Array<String> = [
    "Story", "Freeplay", "Medals", "Credits", "Options", "Options", "Options"
];

var menuItems:Array<Array<Dynamic>> = [];
var obsIsOpen:Bool = false;
function create() {
    CoolUtil.playMenuMusic();
    // var elProcess = new Process("tasklist", []);
    // var output = elProcess.stdout.readAll().toString().toLowerCase();
    // // I would NEVER Steal from an FNF mod that is not spoken of, ESPECIALLY BOB AND BOSIP...
    // var blockedShit:Array<String> = ['obs64.exe', 'obs32.exe', 'streamlabs obs.exe', 'streamlabs obs32.exe'];
    // for (item in blockedShit) if (StringTools.contains(output, item)) obsIsOpen = true;
    // if (output == "winedevice.exe") theSystem = "Linux";
    // elProcess.close();

    // if (FileSystem.exists(FileSystem.absolutePath("Z://home//"+ homeDir.split("\\")[2] +"//.bashrc"))) theSystem = "Linux";
	backdropShader = new CustomShader(Paths.shader("BackdropShader", mod));
    backdropShader.data.iTime.value = [0.0];
    backdropShader.data.offset.value = [1, 1];

    bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF2a2c2f);
    bg.setGraphicSize(FlxG.width, FlxG.height);
    bg.updateHitbox();
    add(bg);

    theScrollBG = new FlxSprite(0, 0, Paths.image('menuStuff/GridBG'));
    theScrollBG.setGraphicSize(FlxG.width, FlxG.height);
    theScrollBG.updateHitbox();
    theScrollBG.shader = backdropShader;
    theScrollBG.scrollFactor.set(0,0);
    theScrollBG.color = 0xFF383a3d;
    add(theScrollBG);
    backdropShader.data.scaling.value = [theScrollBG.scale.x, theScrollBG.scale.y];

    bars = new FlxSprite(0, 0, Paths.image('menuStuff/sickBars'));
    bars.setGraphicSize(FlxG.width/2 + 172, FlxG.height);
    bars.updateHitbox();
    bars.scrollFactor.set(0,0);
    add(bars);
    
    theCoolText = new FlxTypedGroup();
    add(theCoolText);

    rightBar = new FlxSprite().makeGraphic(FlxG.width/2 - 172, FlxG.height, 0xFF313338);
    rightBar.updateHitbox();
    rightBar.x = FlxG.width - rightBar.width;
    add(rightBar);

    curDay = new FlxText(0,0,0, "placeholder", 26);
    curDay.font = Paths.font("DiscordFonts/GG_SANS_EXTRABOLD");
    curDay.setPosition(rightBar.x + 20, 18);
    add(curDay);

    curTime = new FlxText(0,0,0, "placeholder", 26);
    curTime.font = Paths.font("DiscordFonts/GG_SANS_EXTRABOLD");
    curTime.setPosition(FlxG.width - curTime.width - 20, 18);
    add(curTime);

    for (i in 0...menuNames.length) {
        var item = menuNames[i];
        var spr:FlxSprite = new FlxSprite(0,0, Paths.image("menuStuff/menuItem"));
        spr.x = FlxG.width - spr.width - 48;
        if (i == 0) spr.y += spr.height + 15;
        else spr.y = menuItems[i-1][0].y + spr.height + 35;
        spr.ID = i;
        spr.color = 0xFFA0A0A0;

        add(spr);

        var text:FlxText = new FlxText(0,0,0, menuNames[i], 64);
        text.font = Paths.font("DiscordFonts/GG_SANS_EXTRABOLD");
        text.setPosition(spr.x + spr.width/2 - text.width/2, spr.y + spr.height/2 - text.height/2);
        text.width = spr.width - 15;
        text.color = 0xFFA0A0A0;
        text.ID = i;
        add(text);

        FlxMouseEventManager.add(spr, function(){}, function(){
            if (FlxG.mouse.overlaps(spr) || FlxG.mouse.overlaps(text)) onEnter();
        }, function(){
            if (transititon) return;
            curSel = CoolUtil.wrapInt(spr.ID, 0, menuItems.length);
            spr.color = 0xFFFFFFFF;
            text.color = 0xFFFFFFFF;
        }, function(){
            if (transititon) return;
            spr.color = 0xFFA0A0A0;
            text.color = 0xFFA0A0A0;
        });

        menuItems.push([spr, text]);
    }
    switch(theSystem.toLowerCase()) {
        case "linux", "mac": coolText.push("Hey you should go play Nonsense V2- oh wait, sorry you can't even boot the game!! haha");
        default: coolText.push("Oh cool you can play the Nonsense V2 mod since your on " + theSystem + "!"); //you're* 🤓
    }
    for (i in 0...5) if (FlxG.random.bool(30)) coolText.push("Hey do you happen to have " + bruh(homeDir+"\\Downloads", [], 2) + " On your System? No? oke");
    for (mod in FileSystem.readDirectory(Paths.get_modsPath())) {
        if (Path.extension(mod) != "") continue;
        if (FlxG.random.bool(15)) coolText.push("Hey you also have the " + mod + " Mod?");
        switch(mod.toLowerCase()) {
            case "indie cross": 
                coolText.push("INDIE CROCKS"); coolText.push("INDIE CROCKS");
                coolText.push("Heya Kid, its me sans from the Indie Cross YCE port you have downloaded");
                coolText.push("Hey in the Indie Cross YCE Port (If you have LJ's mod installed) you can Type: indie crocs on the TitleScreen!");
                if (FlxG.random.bool(0.1)) coolText = ["INDIE COCKS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"];
        }
    }
    switch(Sys.args()[0]) {
        case "penis": pushInfoToBar("You've Unlocked Penis Mode! ! !");
        case "-mod": pushInfoToBar("thanks for loading up this mod with -mod");
        case "-install-mod": pushInfoToBar("Why would you install this mod through the Command Prompt?");
        case "-?", "-help": pushInfoToBar("what where you trying to ask help for?");
        case "-forcedevmode", "-livereload": 
            ModSupport.forceDevMode = false;
            pushInfoToBar("Nuh uh, no DevMode 4 u");
            trace(CoolUtil.isDevMode());
    }
    if (obsIsOpen) {
        pushInfoToBar("Hi Youtube!! Oh Everyone that see's this Subscribe to-   Hey we censered this because it's Self Promoting");
        coolText.push("If you see this CommunityGame, what the hell are you doing here?");
        coolText.push("Oh your Recording Software is on... hehehehehe");
        coolText.push("CLIP THAT CHAT, OMG CLIP THAT!!");
        coolText.push(".............. hi, u recording me?");
    }

    new FlxTimer().start(FlxG.random.int(3,5), function(tmr) {
        pushInfoToBar();
        tmr.reset(FlxG.random.int(5,13));
    });
    updateCoolDateNtime();

    switch(FlxG.random.int(0,1)) {
        case 0:
            var whoChats:Array<String> = FileSystem.readDirectory(Paths.get_modsPath()+"/"+mod+"/images/deathStuff/icons");
            var scales:Array<Int> = [0.35,0.17,0.17,0.2,0.6,0.65,0.17,0.17,0.35,0.17,0.55,0.17,0.17,0.17,0.45,0.27,0.17];
            var chatRng = FlxG.random.int(0, whoChats.length-1);
            var chatSpr:FlxSprite = new FlxSprite(0,0, Paths.image("deathStuff/icons/"+whoChats[chatRng].split(".")[0]));
            chatSpr.scale.set(scales[chatRng], scales[chatRng]);
            chatSpr.updateHitbox();
            chatSpr.setPosition(25, 125);
            
            embed = new FlxUI9SliceSprite(0,0, (Paths.image('SquareShit')), new Rectangle(0, 0, 650, chatSpr.height + 20), [20, 20, 460, 460]);
            embed.color = 0xFF2c3032;
            embed.antialiasing = true;
            embed.updateHitbox();
            add(embed);
            add(chatSpr);
            embed.setPosition(chatSpr.x- 10, chatSpr.y - 10);
            
            var msg:FlxText = new FlxText(0,0, embed.width - chatSpr.width - 25, "", 26);
            msg.font = Paths.font("DiscordFonts/GG_SANS_SEMIBOLD");
            msg.setPosition(chatSpr.x + chatSpr.width + 25, embed.y + embed.height/2 - msg.height/2);
            add(msg);

            var circle:FlxSprite = new FlxSprite(0,0, Paths.image("Circle"));
            circle.scale.set(0.5,0.5);
            circle.color = 0xFFef5858;
            circle.updateHitbox();
            circle.setPosition(chatSpr.x + chatSpr.width - circle.width/2, chatSpr.y);
            add(circle);

            var num:FlxText = new FlxText(0,0, circle.width, "0", 20);
            num.font = Paths.font("DiscordFonts/GG_SANS_EXTRABOLD");
            num.setPosition(circle.x + circle.width/2 - num.width/4, circle.y + circle.height/2 - num.height/2);
            add(num);

            var texts:Array<String> = [
                "Hey Boyfriend", "Hey", "Yo Answer me", "Yo Hello?", "Hey respond please", "check out this funny meme", "what YCE mod are you playing?",
                "Fucking Bitch Respond", "I got a sick idea", "lets make an FNF mod", "1 + 1 = 2, right? My code returned 3", "Respond or Perish",
                "Thats it, ima kills you (kills you)", "Guess what...?", "Respond please im begging", "Kitten, don't disrespect me", "how do I make a variable I forgor",
            ];
            if (obsIsOpen) {
                texts.push("Hey are you recording me?");
                texts.push("Turn off your Recording Software");
                texts.push("Bro stop leaking our DM's on YouTube");
                texts.push("hello utubr");
                texts.push("sticky my beloved");
            }
            switch(Sys.args()[0]) {
                case "penis": texts.push("Did you enable Penis Mode??"); texts.push("Did you enable Penis Mode??");
                case "-mod": texts.push("Why load the mod throught the CMD?");
                case "-install-mod": texts.push("Ah cool you installed the TTS Mod");
                case "-?", "-help": texts.push("Whats up? you asked for help?");
                case "-forcedevmode", "-livereload": texts.push("You can't enable Dev mode bro");
            }
            new FlxTimer().start(FlxG.random.float(0.5,2), function(tmr) {
                CoolUtil.playMenuSFX(0);
                msg.text = texts[FlxG.random.int(0, texts.length-1)];
                var txt = Std.int(num.text.split("+")[0]);
                num.text = (txt > 8) ? "9+" : txt+1;
                num.setPosition(circle.x + circle.width/2 - num.width/4, circle.y + circle.height/2 - num.height/2);
                tmr.reset(FlxG.random.float(1,2));
            });
        case 1:
            var playin:Array<String> = FileSystem.readDirectory(Paths.get_modsPath()+"/"+mod+"/images/openers");
            var xmlStore:Array<Dynamic> = [];
            for (item in playin) if (!StringTools.endsWith(item, ".png")) xmlStore.push(item);
            for (item in xmlStore) playin.remove(item);
            var randomPlayer = FlxG.random.int(0, playin.length-1);
            var sparrow:Bool = false;
            for (item in xmlStore) {
                if (playin[randomPlayer].split(".")[0].toLowerCase() == item.split(".")[0].toLowerCase()) {
                    sparrow = true;
                    break;
                }
            }

            var nowPlayin:FlxSprite = new FlxSprite(0,0);
            var path = "openers/" + playin[randomPlayer].split(".")[0];
            if (!sparrow) nowPlayin.loadGraphic(Paths.image(path));
            else {
                nowPlayin.frames = Paths.getSparrowAtlas(path);
                nowPlayin.animation.addByPrefix("idle", "", 24, true);
                nowPlayin.animation.play("idle", true);
            }
            nowPlayin.scale.set(0.5,0.5);
            nowPlayin.updateHitbox();
            nowPlayin.y += 100;
            nowPlayin.x -= nowPlayin.width;
            add(nowPlayin);
            FlxTween.tween(nowPlayin, {x: 25}, 1.25, {ease: FlxEase.backOut});
    }
}

function onEnter() {
    if (transititon) return;
    transititon = true;
    CoolUtil.playMenuSFX(1);
    for (arry in menuItems) {
        for (item in arry) {
            if (item.ID == curSel) FlxFlicker.flicker(item, 1, 0.1, true, false, function(flicker:FlxFlicker) {
                switch(curSel) {
                    case 0: FlxG.switchState(new StoryMenuState());
                    case 1: FlxG.switchState(new FreeplayState());
                    case 2: FlxG.switchState(new MedalsState());
                    case 3: FlxG.switchState(new CreditsState());
                    case 4: FlxG.switchState(new options.screens.OptionMain());
                }
            });
        }
    }
}

var transititon:Bool = false;
function bruh(file:String, ?bannedList:Array<String> = [], ?limit:Int = 1, times:Int = 0) {
    if (bannedList == null) bannedList = [];
    if (limit == null) limit = 1;
    if (times == null) times = 0;
    var thing = FileSystem.readDirectory(file);
    if (thing == null) {
        var ye = file.split("\\");
        bannedList.push(ye[ye.length-1]);
        var newFile:String = "";
        for (item in ye) newFile += item + "\\";
        times++;
        bruh(newFile, bannedList, limit, times);
    } else {
        var queueToRemove:Array<Dynamic> = [];
        for (item in thing) {
            if (!FileSystem.isDirectory(file + "\\" + item)) queueToRemove.push(item);
            for (ban in bannedList) if (item == ban) queueToRemove.push(item);
        }
        for (item in queueToRemove) thing.remove(item);
        if (thing.length < 1) {
            thing = FileSystem.readDirectory(file);
            return Std.string(file + "\\" + thing[FlxG.random.int(0, thing.length-1)]);
        }
    
        var newFile = file + "\\" + thing[FlxG.random.int(0,thing.length-1)];
        bruh(newFile, (bannedList != []) ? bannedList : [], limit, times);
    }
}

var curTimeName:String = " am";
var test = new Date(2023, 1,1, 0, 0, 0);
function updateCoolDateNtime() {
    curDay.text = (Date.now().getMonth()+1) + "/" + Date.now().getDate() + "/" + Date.now().getFullYear();
    curDay.updateHitbox();
    curDay.setPosition(rightBar.x + 20, 18);

    var trackNonMilitary = Date.now().getHours();
    if (trackNonMilitary == 0) {
        curTimeName = " am";
        trackNonMilitary = 12;
    }
    if (trackNonMilitary > 11) curTimeName = " pm";
    if (trackNonMilitary > 12) trackNonMilitary -= 12;
    var minAdj = Date.now().getMinutes();
    if ((trackNonMilitary == 3 && minAdj < 1)) pushInfoToBar("OMG HE IS PLAYING AT 3:00am !!!! NO WAY");
    var seperator:String = ":";
    if (minAdj < 10) seperator = ":0";
    curTime.text = trackNonMilitary + seperator + minAdj + curTimeName;
    curTime.updateHitbox();
    curTime.setPosition(FlxG.width - curTime.width - 20, 18);
}

var updateDayCycle:Float = 0.0;
function update(elapsed:Float) {
    if (FlxG.sound.music.playing && FlxG.sound.music.playing != null) {
        Conductor.songPosition = FlxG.sound.music.time;
    }
    backdropShader.data.iTime.value = [backdropShader.data.iTime.value[0] + elapsed*0.5];
    if (FlxG.keys.justPressed.SEVEN && CoolUtil.isDevMode()) FlxG.switchState(new dev_toolbox.ToolboxMain());

    updateDayCycle += elapsed;
    if (updateDayCycle > 2) {
        updateDayCycle = 0;
        updateCoolDateNtime();
    }

    for (i in 0...theCoolText.members.length) {
        var item = theCoolText.members[i];
        if (item == null) continue;
        if (item.x < (0 - item.width - 20)) {
            theCoolText.remove(item, true);
            remove(item);
            item.kill();
            item.destroy();
            continue;
        }
        item.x -= 200*elapsed;
        if (i == 0) continue;
        var prevItem = theCoolText.members[i-1];
        if (prevItem == null) continue;
        if (prevItem.x > (rightBar.x - prevItem.width)-50) item.x = rightBar.x + 20;
    }
}

var coolText:Array<String> = [
    "|  A Link  |",
    "Hey, how is the " + theSystem + " Operating System working out for you?",
    "In the Death State, any words with 'Z' are replaced with 'X' due to YCE being a bitch",
    "Hi, Im ItsLJcool!", "DO NOT PLAY FRIDAY NIGHT SPEECHIN': VS TTS AT 3:00 AM !!!"
];
var theCoolText:FlxTypedGroup<FlxText>;
function pushInfoToBar(?forceText:String) {
    var coolTexted = (forceText == null) ? coolText[FlxG.random.int(0, coolText.length-1)] : forceText;
    text = new FlxText(0,0,0, coolTexted, 32);
    text.font = Paths.font("DiscordFonts/GG_SANS_EXTRABOLD");
    text.updateHitbox();
    text.setPosition(rightBar.x + 20, FlxG.height - text.height - 20);
    theCoolText.add(text);
}