//a
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.FlxBasic;
import sys.FileSystem;
import haxe.io.Path;
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUIButton;
import flixel.input.mouse.FlxMouseEventManager;
import openfl.filters.ShaderFilter;

var banText:FlxText;
var userWhoBanned:FlxText;
var embed:FlxSprite;
var deathText:FlxText;

var altStuff:Bool = false;
var randomBanText:Array<String> = [
    "{} was just banned!", "{} got banned!", "{} was thrown off the server", "{} got struck by the ban hammer",
    "hocus pocus, {} got ponocus", "{} leaked Indie Cross", "{} was not cheezed to be met", "{} was selling Meth", 
    "{} Saw Zander's code", "{} Got Ratio'd", "Achivement Unlocked: Get Banned By {1}",
    "{} forgot to use Case Switches", "Imagine Dying To {1}, Couldn't be me", "{} Ran Out Of Nitro", "{} used Kade Engine 1.5.2",
    "{} Forgor to share their Screen", 
];
// {} gets replaced by the character your playing
var randomDeathText:Array<String> = [
    "haha L noob", "I don't like the name '{}'", "{} is under 13", "{} plays League Of Legends", "{} is friends with [504]Brandon",
    "couldn't do 1+1"
];
function create() {
    remove(character);
    var sprite:FlxSprite = new FlxSprite().makeGraphic(FlxG.width*2, FlxG.height*2, 0xFF242728);
    sprite.scrollFactor.set();
    sprite.updateHitbox();
    sprite.screenCenter();
    add(sprite);
    if (PlayState.song.song.toLowerCase() == "a-link") randomBanText.push("{1} says: A LINK", "{} died reading the word:\nA LINK\n");

    var killMe = FlxG.random.int(0,randomBanText.length-1);
    var split = randomBanText[killMe].split("{}");
    if (split[1] == null) {
        altStuff = true;
        split = randomBanText[killMe].split("{1}");
    }
    banText = new FlxText(0,0,0,"lolText",64);
    banText.text = split[0]+getCharacter()+split[1];
    banText.updateHitbox();
    banText.font = Paths.font("DiscordFonts/GG_SANS_EXTRABOLD");

    altStuff = false;
    killMe = FlxG.random.int(0,randomDeathText.length-1);
    split = randomDeathText[killMe].split("{}");

    deathText = new FlxText(0,0,0,"Reason: ",40);
    if (split[1] != null) deathText.text += split[0]+getCharacter()+split[1];
    else deathText.text += randomDeathText[killMe];
    deathText.updateHitbox();
    deathText.font = Paths.font("DiscordFonts/GG_SANS_MEDIUM");

    if (banText.width > deathText.width) var width = banText.width;
    else var width = deathText.width;


    embed = new FlxUI9SliceSprite(0,0, (Paths.image('SquareShit')), new Rectangle(0, 0, width + 100, 600), [20, 20, 460, 460]);
    embed.color = 0xFF2c3032;
    embed.antialiasing = true;
    embed.updateHitbox();
    add(embed);

    embedColor = new FlxUI9SliceSprite(embed.x,embed.y, (Paths.image('SquareShit')), new Rectangle(0, 0, 15, embed.height), [20, 20, 460, 460]);
    embedColor.color = PlayState.boyfriend.getColors()[0];
    embedColor.antialiasing = true;
    embedColor.updateHitbox();
    embedColor.angle = 180;
    add(embedColor);

    banText.y = embed.y; banText.x += embedColor.width + 20;
    deathText.x = banText.x;
    deathText.y = banText.y + banText.height;
    add(banText);
    add(deathText);
    
    character.setPosition(embed.getGraphicMidpoint().x - character.width/2, embed.getGraphicMidpoint().y - character.height/2 + 100);

    camFollow.setPosition(embed.getGraphicMidpoint().x, embed.getGraphicMidpoint().y);
    FlxG.camera.zoom = 0.7;
    FlxG.camera.focusOn(camFollow.getPosition());
    add(character);

    theFunnyBG = [banText,deathText,embed,embedColor,character];
    createPost();
}

function getCharacter() {
    if (altStuff) var switchThing = PlayState.SONG.player2;
    else var switchThing = PlayState.SONG.player1;
    switch(switchThing.split(":")[1]) {
        case "bf", "bf-nitro", "bf-fp":
            return "Boyfriend#1234";
        case "lj", "LJ":
            return "ItsLJcool#7560";
        case "tts-player", "tts", "tts-raged":
            return "TTS Bot#3590";
        default:
            return "Unknown#0000";
    }
}

var messageInChannel:FlxText;
var barGeneral:FlxUI9SliceSprite;
var type:FlxInputText;
function createPost() {

    barGeneral = new FlxUI9SliceSprite(0,0, (Paths.image('SquareShit')), new Rectangle(0, 0, embed.width + 150, 100), [20, 20, 460, 460]);
    barGeneral.antialiasing = true;
    barGeneral.color = 0xFF40444b;
    barGeneral.updateHitbox();
    barGeneral.x = embed.getGraphicMidpoint().x - barGeneral.width/2;
    barGeneral.y = FlxG.height - barGeneral.height + 50;
    add(barGeneral);

    messageInChannel = new FlxText(0,0,0,"Message #international-titular", 40);
    messageInChannel.antialiasing = true;
    messageInChannel.color = 0xFF72767d;
    messageInChannel.updateHitbox();
    messageInChannel.x = barGeneral.x + 50;
    messageInChannel.y = barGeneral.y + barGeneral.height/2 - messageInChannel.height/2;
    messageInChannel.font = Paths.font("DiscordFonts/GG_SANS_NORMAL");
    add(messageInChannel);
    type = new FlxInputText(barGeneral.x + 50,0,barGeneral.width - 20, "", 32, 0xFFFFFFFF, 0x00000000, true);
    type.y = barGeneral.y + barGeneral.height/2 - type.height/2;
    type.updateHitbox();
    type.width = barGeneral.width - 20;
    type.height = barGeneral.height - 20;
    type.font = Paths.font("DiscordFonts/GG_SANS_NORMAL");
    // type.callback = function() {
    //     type.updateHitbox();
    // };
    add(type);
    type.hasFocus = false;

    altStuff = false;
    isTyping = new FlxText(0,0,0,getCharacter()+" is typing...", 30);
    isTyping.x = barGeneral.x;
    isTyping.y = barGeneral.y + barGeneral.height;
    isTyping.font = Paths.font("DiscordFonts/GG_SANS_SEMIBOLD");
    isTyping.alpha = 0.0001;
    add(isTyping);

    removeThing = new FlxUI9SliceSprite(0,0, (Paths.image('SquareShit')), new Rectangle(0, 0, 100, 100), [20, 20, 460, 460]);
    removeThing.antialiasing = true;
    removeThing.color = 0xFF644141;
    removeThing.updateHitbox();
    removeThing.x = barGeneral.x + barGeneral.width;
    removeThing.y = FlxG.height - barGeneral.height + 50;
    add(removeThing);
    var playIcon:FlxSprite = CoolUtil.createUISprite("delete");
    playIcon.scale.set(3,3);
    playIcon.updateHitbox();
    playIcon.x = removeThing.x + removeThing.width/2 - playIcon.width/2;
    playIcon.y = removeThing.y + removeThing.height/2 - playIcon.height/2;
    add(playIcon);
    for (item in [removeThing, playIcon]) {
        FlxMouseEventManager.add(item, function(){}, function(){
            type.text = "";
        }, function(){});
    }
}

var theFunnyBG:Array<Dynamic> = [];

var chats:Array<Dynamic> = [];
var whoChats:Array<String> = FileSystem.readDirectory(Paths.get_modsPath()+"/"+mod+"/images/deathStuff/icons");
var randomFonts:Array<String> = [
    "GG_SANS_BOLD",
    "GG_SANS_BOLD_ITALIC",
    "GG_SANS_EXTRABOLD",
    "GG_SANS_MEDIUM",
    "GG_SANS_MEDIUM_ITALIC",
    "GG_SANS_NORMAL",
    "GG_SANS_NORMAL_ITALIC",
    "GG_SANS_SEMIBOLD"
];
var scales:Array<Int> = [0.35,0.17,0.17,0.6,0.17,0.17,0.35,0.17,0.6,0.17,0.45,0.27,0.17];
function pushRNGchat() {
    var rngIcon = FlxG.random.int(0,whoChats.length-1);
    var icon:FlxSprite = new FlxSprite().loadGraphic(Paths.image("deathStuff/icons/" + whoChats[rngIcon].split(".")[0]));
    icon.scale.set(scales[rngIcon], scales[rngIcon]);
    icon.updateHitbox();
    
    var daText:String = "";
    var rngBool:Bool = FlxG.random.bool(40);
    var nothing:Int = 0;
    var rngSpecific = FlxG.random.int(0,specificCoolText[rngIcon].length-1);
    var rngNormal = FlxG.random.int(0,rngText.length-1);
    var pingedRNG = FlxG.random.int(0,pingedText.length-1);
    var isPingedRandom = FlxG.random.bool(30);

    var sprite:Dynamic = null;
    var messPinged:Bool = false;
    var randomFont = FlxG.random.int(0,randomFonts.length-1);

    var highligtedText:FlxText;
    var otherText:FlxText;
    for (repl in replaceStuff) {
        var split = "";
        if (rngBool) split = specificCoolText[rngIcon][rngSpecific].split(repl);
        else split = rngText[rngNormal].split(repl);
        if (isPingedRandom) split = pingedText[pingedRNG].split(repl);
        if (split[1] == null) {
            nothing++;
            if (nothing == replaceStuff.length) daText = split[0];
            continue;
        }
        var RNG:Array<Array<Dynamic>> = [
            ["INDIE CROCKS",false], ["LJdependency",false], ["ZANDCHAD",false], ["normal",false], ["MRBEATS",true],
            ["meme", true]
        ];
        switch(repl) {
            case "{i}":
                sprite = addSprite(RNG[0][0], RNG[0][1]);
                daText += split[0]+split[1];
            case "{lj}":
                sprite = addSprite(RNG[1][0], RNG[1][1]);
                daText += split[0]+split[1];
            case "{zc}":
                sprite = addSprite(RNG[2][0], RNG[2][1]);
                daText += split[0]+split[1];
            case "{n}":
                sprite = addSprite(RNG[3][0], RNG[3][1]);
                daText += split[0]+split[1];
            case "{mrB}":
                sprite = addSprite(RNG[4][0], RNG[4][1]);
                daText += split[0]+split[1];
            case "{m}":
                sprite = addSprite(RNG[5][0], RNG[5][1]);
                daText += split[0]+split[1];
            case "{r}":
                var rand = FlxG.random.int(0,RNG.length-1);
                sprite = addSprite(RNG[rand][0], RNG[rand][1]);
                daText += split[0]+split[1];
            case "{}":
                altStuff = false;
                daText += split[0];
                messPinged = true;
            case "{1}":
                altStuff = true;
                daText += split[0]+getCharacter()+split[1];
            case "{e}":
                daText += split[0];
                messPinged = true;
            default:
                daText += split[0]+split[1];
        }
        if (messPinged) {
            highligtedText = new FlxText(0,0,0, "", 32);
            highligtedText.font = Paths.font("DiscordFonts/"+randomFonts[randomFont]);
            highligtedText.antialiasing = true;
            highligtedText.updateHitbox();
            if (repl == "{e}") highligtedText.text = "everyone";
            else highligtedText.text = getCharacter();
            
            otherText = new FlxText(0,0,0, split[1], 32);
            otherText.font = Paths.font("DiscordFonts/"+randomFonts[randomFont]);
            otherText.antialiasing = true;
            otherText.updateHitbox();
        }
    }
    
    var texted:FlxText = new FlxText(0,0,0, daText, 32);
    texted.font = Paths.font("DiscordFonts/"+randomFonts[randomFont]);
    texted.antialiasing = true;
    texted.updateHitbox();
    var heightStuff:Int = texted.height + 55;
    var widthStuff:Int = texted.width + 250;
    if (sprite != null) {
        heightStuff += sprite.height;
        widthStuff += sprite.width;
    }
    if (highligtedText != null) {
        widthStuff += highligtedText.width + otherText.width;
    }
    var rect = new Rectangle(0, 0, widthStuff, heightStuff);
    var daChatBox:FlxUI9SliceSprite = new FlxUI9SliceSprite(barGeneral.x,0, (Paths.image('SquareShit')), rect, [20, 20, 460, 460]);
    daChatBox.antialiasing = true;
    daChatBox.updateHitbox();
    daChatBox.y = barGeneral.y - daChatBox.height;
    daChatBox.color = (!messPinged) ? 0xFF40444b : 0xFF49443c;
    add(daChatBox);
    icon.x = daChatBox.x + 10;
    icon.y = daChatBox.y + 5;
    texted.x = icon.x + icon.width + 50;
    texted.y = daChatBox.y + (daChatBox.height/2-daChatBox.height/2) + texted.height/2;
    var blueOutline:FlxUI9SliceSprite;
    if (messPinged) {
        blueOutline = new FlxUI9SliceSprite(0,0, (Paths.image('SquareShit')), new Rectangle(0, 0, highligtedText.width+50, highligtedText.height+10), [20, 20, 460, 460]);
        blueOutline.antialiasing = true;
        blueOutline.updateHitbox();
        blueOutline.color = 0xFF4e4d73;
        add(blueOutline);
    }
    add(texted);
    add(icon);
    if (sprite != null) {
        sprite.x = texted.x;
        sprite.y = daChatBox.y + texted.height + 20; 
        add(sprite);
    }
    var pingedStuff:FlxUI9SliceSprite;
    if (messPinged) {
        pingedStuff = new FlxUI9SliceSprite(barGeneral.x,0, (Paths.image('SquareShit')), new Rectangle(0, 0, 10, heightStuff), [20, 20, 460, 460]);
        pingedStuff.antialiasing = true;
        pingedStuff.updateHitbox();
        pingedStuff.y = barGeneral.y - pingedStuff.height;
        pingedStuff.color = 0xFFfaa81a;
        pingedStuff.angle = 180;
        add(pingedStuff);
        icon.x += pingedStuff.width;
        texted.x += pingedStuff.width;

        highligtedText.x = texted.x + texted.width;
        highligtedText.y = daChatBox.y + (daChatBox.height/2-daChatBox.height/2) + texted.height/2;

        otherText.x = highligtedText.x + highligtedText.width;
        otherText.y = daChatBox.y + (daChatBox.height/2-daChatBox.height/2) + texted.height/2;
        blueOutline.x = highligtedText.x-40;
        blueOutline.y = highligtedText.y-5;
        add(highligtedText);
        add(otherText);
    }

    if (chats[0] != null) {
        for (i in 0...chats.length) {
            for (item in chats[i]) {
                if (item == null) continue;
                item.y -= daChatBox.height;
            }
        }
    }
    for (item in theFunnyBG) {
        if (item == null) continue;
        item.y -= daChatBox.height;
    }
    var uh = [daChatBox,texted,icon,sprite,pingedStuff,highligtedText,otherText,blueOutline];
    chats.push(uh);
    if (rngIcon == 2 && FlxG.random.bool(99)) {
        new FlxTimer().start(FlxG.random.float(1,3), function() {
            deleteUserMessage(uh);
        });
    }
}

function deleteUserMessage(uh) {
    uh[1].text = "Original Message Was Removed";
    uh[1].font = Paths.font("DiscordFonts/GG_SANS_NORMAL_ITALIC");
    uh[2].destroy();
    if (uh[5] != null) {
        uh[5].destroy();
        uh[6].destroy();
        uh[7].destroy();
    }
    if (uh[3] != null) uh[3].destroy();
    remove(uh[1]);
    var heightStuff:Int = uh[1].height + 55;
    var widthStuff:Int = uh[1].width + 250;
    if (uh[3] != null) {
        heightStuff += uh[3].height;
        widthStuff += uh[3].width;
    }
    var rect = new Rectangle(0, 0, widthStuff, heightStuff);
    var daChatBox:FlxUI9SliceSprite = new FlxUI9SliceSprite(barGeneral.x,0, (Paths.image('SquareShit')), rect, [20, 20, 460, 460]);
    daChatBox.antialiasing = true;
    daChatBox.updateHitbox();
    daChatBox.y = uh[0].y;
    daChatBox.color = uh[0].color;
    add(daChatBox);
    uh[0].destroy();
    uh[0] = daChatBox;
    add(uh[1]);
}

function getFrames(image:FlxSprite, names:Array<String>, looping:Array<Bool>) { // me when LJ (Myself) steals his own code that was stolen :troll:
    availableAnims = [];
    var numbers = ["0","1","2","3","4","5","6","7","8","9"];
    if (image.frames != null) {
        for(e in image.frames.frames) {
            var animName = e.name;
            while (numbers.contains(animName.substr(-1))) {
                animName = animName.substr(0, animName.length - 1);
            }
            if (!availableAnims.contains(animName))
                availableAnims.push(animName);
        }
    }
    for (i in 0...availableAnims.length) image.animation.addByPrefix(names[i], availableAnims[i], 24, looping[i]);
    image.animation.play(names[0]);
    image.updateHitbox();
}

var controlsJustNUM = FlxControls.anyJustPressed;
function update(elapsed) {
    // if (FlxG.keys.pressed.H) pushRNGchat();
    if (controlsJustNUM([46])) {
        type.text = "";
        type.hasFocus = false;
    }
    if (type.text != "" || type.hasFocus) {
        messageInChannel.alpha = 0.001;
        isTyping.alpha = 1;
    }
    else {
        messageInChannel.alpha = 1;
        isTyping.alpha = 0.001;
    }
    if (FlxG.keys.justPressed.UP && save.data.prevMessage != null) type.text = save.data.prevMessage;
    if (missingShader) missingNo.data.binaryIntensity.value = [FlxG.random.float(5, 10)];
}

var replaceStuff:Array<String> = [
    "{r}",// random
    "{i}", "{n}", "{zc}", "{lj}", "{e}", "{1}", "{mrB}", "{}", "{m}"
];

function addSprite(sprPath:String, framed:Bool) {
    var sprite = new FlxSprite(); // i would but .loadGraphic() here but it can possibly an XML too so...
    if (!framed) sprite.loadGraphic(Paths.image("deathStuff/images/" + sprPath));
    else {
        sprite.frames = Paths.getSparrowAtlas("deathStuff/images/" + sprPath);
        getFrames(sprite, ["image"], [true]);
    }
    sprite.scale.set(0.5,0.5);
    sprite.updateHitbox();
    return sprite;
}

function beatHit() {
    if (FlxG.random.bool(60) && !state.isEnding) pushRNGchat();
}
function onEnd() {
    trace(state.isEnding);
    save.data.prevMessage = type.text;
    FlxG.camera.follow(camFollow, "lockon", 0.1);
    camFollow.setPosition(embed.getGraphicMidpoint().x, embed.getGraphicMidpoint().y);
    camZoom = FlxTween.tween(FlxG.camera, {zoom: 1}, 1.5, {ease: FlxEase.quadOut});
    switch(type.text.toLowerCase()) {
        case "mrwhite", "walter", "waldah":
            FlxG.sound.music.fadeOut(0.1, 0.2);
            FlxG.sound.play(Paths.sound('deathStuff/sayMyName'), 0.8);
        case "popcorners":
            FlxG.sound.music.fadeOut(0.1, 0.2);
            FlxG.sound.play(Paths.sound('deathStuff/PopCorners'), 0.8);
        case "ttsbotdead":
            var ttsDead:FlxSprite = new FlxSprite().loadGraphic(Paths.image("raaa"));
            ttsDead.scale.set(1.5,1.5);
            ttsDead.updateHitbox();
            ttsDead.scrollFactor.set();
            ttsDead.screenCenter();
            add(ttsDead);
            FlxG.sound.play(Paths.sound('spooky'), 0.8);
            new FlxTimer().start(0.75, function() {
                ttsDead.destroy();
            });
        case "xandah", "xander":
            FlxG.sound.music.fadeOut(0.1, 0.2);
            FlxG.sound.play(Paths.sound('deathStuff/ZanderTheBUNNY'), 0.8);
        case "xanderdead":
            FlxG.sound.music.fadeOut(0.1, 0.2);
            FlxG.sound.play(Paths.sound('deathStuff/gmodDeath'), 0.8);
            FlxG.sound.play(Paths.sound('deathStuff/ragdoll'), 0.8);
            var zanderDead:FlxSprite = new FlxSprite().loadGraphic(Paths.image("deathStuff/images/Dead_Zander"));
            zanderDead.scrollFactor.set();
            zanderDead.screenCenter();
            if (FlxG.random.bool(1)) zanderDead.blend = 14;
            add(zanderDead);
            shakeDatMan(zanderDead, FlxG.random.int(15,50));
        case "brandon", "[504]brandon":
            FlxG.sound.music.fadeOut(0.1, 0.2);
            // FlxG.sound.play(Paths.sound('deathStuff/brandonSinking'), 1);
        case "alink":
            FlxG.sound.music.fadeOut(0.1, 0.2);
            FlxG.sound.play(Paths.sound('deathStuff/alink'), 0.8);
        case "mrbeast":
            FlxG.sound.music.fadeOut(0.1, 0.2);
            FlxG.sound.play(Paths.sound('MR BEAST'), 0.8);
            var mrBeast:FlxSprite = new FlxSprite();
            mrBeast.frames = Paths.getSparrowAtlas("MRBEATS");
            getFrames(mrBeast, ["play"], [false]);
            mrBeast.scrollFactor.set();
            mrBeast.scale.set(2,2);
            mrBeast.updateHitbox();
            mrBeast.screenCenter();
            add(mrBeast);
        case "/ban", "/kill":
            for (item in chats) {
                trace(item);
                deleteUserMessage(item);
            }
            FlxG.camera.follow(camFollow, "lockon", 0.0035);
        case ":-:", "ljhuh":
            camZoom.cancel();
            FlxG.sound.music.fadeOut(0.1, 0.2);
            FlxG.sound.play(Paths.sound('deathStuff/MOAI'), 0.8);
            var ljHuh:FlxSprite = new FlxSprite().loadGraphic(Paths.image("deathStuff/icons/ITSLJCOOL"));
            ljHuh.scrollFactor.set();
            ljHuh.scale.set(2,2);
            ljHuh.updateHitbox();
            ljHuh.screenCenter();
            ljHuh.x = (FlxG.width/2-FlxG.width/2) - ljHuh.width*2-100;
            add(ljHuh);
            FlxTween.tween(ljHuh, {x: FlxG.width/2 - ljHuh.width},6);
        case "discordping":
            loopForeverRNG(function () {
                FlxG.sound.play(Paths.sound('scrollMenu'), 0.5);
            }, FlxG.random.float(0.015, 0.1));
        case "myears":
            loopForeverRNG(function () {
                var rngSFX = FileSystem.readDirectory(Paths.get_modsPath()+"/"+mod+"/sounds");
                var rng = FlxG.random.int(0,rngSFX.length-1);
                if (Path.extension(rngSFX[rng]) == "") return;
                FlxG.sound.play(Paths.sound(rngSFX[rng].split(".")[0]), 0.5);
            }, FlxG.random.float(0.015, 0.1));
        case "missingno":
            missingNo = new CustomShader(mod + ":MISSINGNO!!");
            missingNo.data.binaryIntensity.value = [1000];
            FlxG.camera.setFilters([new ShaderFilter(missingNo)]);
            FlxG.camera.filtersEnabled = true;
            missingShader = true;
        case "huh", "hur", "formeandyou":
            FlxG.sound.music.fadeOut(0.1, 0.2);
            FlxG.sound.play(Paths.sound('deathStuff/huh'), 0.8);
        case "gus", "pollos", "lospollos","gustavo":
            FlxG.sound.music.fadeOut(0.1, 0.2);
            FlxG.sound.play(Paths.sound('deathStuff/losPollosHermanos'), 0.8);
        case "whoimpostor?", "whoimpostor", "who":
            FlxG.sound.music.fadeOut(0.1, 0.2);
            FlxG.sound.play(Paths.sound('deathStuff/whoimpostor'), 0.8);
        case "wixard":
            camZoom.cancel();
            FlxG.sound.music.fadeOut(0.1, 0.2);
            FlxG.sound.play(Paths.sound('deathStuff/wozard'), 0.8);
            var wizHat:FlxSprite = new FlxSprite().loadGraphic(Paths.image("deathStuff/images/wizHat"));
            // wizHat.scrollFactor.set();
            wizHat.scale.set(0.5,0.5);
            wizHat.updateHitbox();
            wizHat.screenCenter();
            wizHat.y = character.y - 1000;
            wizHat.x = character.x + 50;
            add(wizHat);
            FlxTween.tween(wizHat, {y: character.y - character.height + 50}, 1.5, {ease: FlxEase.quadOut});
            camFollow.setPosition(embed.getGraphicMidpoint().x, embed.getGraphicMidpoint().y - 100);
        case "omgxander":
            //a
    }
}

var missingNo:ShaderFilter;
var missingShader:Bool = false;
function loopForeverRNG(func:Void->Void, time:Float) {
    new FlxTimer().start(time, function () {
        func();
        loopForeverRNG(func,time);
    });
}

function shakeDatMan(spr, values) {
    var funny = FlxG.random.bool(15);
    if (funny) remove(spr);
    spr.x += FlxG.random.float(-values, values);
    spr.y += FlxG.random.float(-values, values);
    new FlxTimer().start(0.015, function() {
        shakeDatMan(spr,values);
    });
    if (funny) insert(FlxG.random.int(2,14), spr);
    if (!spr.isOnScreen(FlxG.camera)) spr.screenCenter();
}
var specificCoolText:Array<Array<String>> = [ // {} is the image to be placed, inside the {r} is a specific image but if its just {r}, random
    ["Im Going2killevery1startingwithU", "LJ Has too many songs in the mod. You Agree?", "Hey where is my cover?",
    "I am squidward, I am suicidal", "uwu", "wwwww", "Why do you persist?"], // alexg
    ["Got Ban'd", "Skill Issue", "Go play Osu!", "Haha, Perdio", "Jaja que puto"], // Diamontitos
    ["Drowning Drowning Sinking Sinking", "IM NOT UNDER 13!!", "Psych Engine !!", "I love indie cocks- wait what"], // ew Brandon
    ["Hi, Im ItsLJcool", "Indie Crocs {i}", "LJ Dependency!! {lj}"], // ITSLJCOOL
    ["lollololollol", "no"], // MasterArt
    ["Now Playing: Death State by Diamantitos"], // Tempo
    ["Lebron James?!?!"], // Tiky
    ["A-LINK", "Have You Bought TTS Premium Yet?"], // TTS
    ["lmao u prolly use arrow keys", "damn that was, actually no that wasn't even that close lmao",
    "ima hop in vc just to laugh at you", "embed fail LLLL"], // wizard
    ["Idk what im doing here ima be honest", "uh am I appart of the mod?"], // YAGPDB
    ["lollololollol", "normal {n}"], // YahyaPoooper
    ["I Lost my Account because idk", "This icon is from Rocket Morgage Co-Founder: Yahya", "lollololollol", "normal {n}"], // YahyaREAL
    ["'L'J", "ZanChad!! {zc}", "Uhh cheesed to meet you", "IM    DEAD"], // ZanChad !!
];

var pingedText:Array<String> = [
    "@{} You Lost!?!?", "Apparently @{} is terrable at FNF.", "@{1} Is too good at FNF.", "@{e} :troll:", "@{} have you found all the secrets in the death state?",
    "you know, there is secrets here @{}..."
];

var rngText:Array<String> = [
    "Wow you lost? Loser", "I beat this song my first try!", "L + Ratio", "Why you still here? Nothing else is here",
    "How many viewers are watching the stream bro?", "haha im the only viewer in your stream", "Sneeky Sneeky", "You are sure taking your time...",
    "Yea we know this death state is cool, now Leave.", "A-LINK", "{r}", "@{e} where the fuck are we?", "hahah look at this random image: {r}",
    "From: #LJ Meme Rant {m}", "If you type some random message, something might happen !!", "hint: Z isn't a hidden word you can type",
    "MR BEAST!! {mrB}"
]