//a
import Conductor;
import openfl.filters.ShaderFilter;
import Section;
import flixel.math.FlxRect;

var stage:Stage = null;
var filmGrain:ShaderFilter;

var curSinger:Int = 2;
var cameraPoints:Array<Dynamic> = [
	[200, 400],
	[564.5, 450],
	[900, 400]
];

function update(elapsed) {
	
	var swagRect = FlxRect.weak(0, 0, saled.width, saled.height - 16);
	saled.clipRect = swagRect;

	if (gb != null) {
		gb.x -= elapsed / (0.25 / 60);
	}

	if (gold != null) {
		gold.x -= elapsed / (0.25 / 60);
	}
	stage.update(elapsed);
	filmGrain.data.iTime.value = [Conductor.songPosition / 1000];
	PlayState.camFollow.x = (cameraPoints[curSinger][0] != null) ? cameraPoints[curSinger][0] : 600;
	PlayState.camFollow.y = (cameraPoints[curSinger][1] != null) ? cameraPoints[curSinger][1] : 425;

	PlayState.camFollow.x = cameraX;
	PlayState.camFollow.y = 450;

	// if (doReverse)
	// 	powYES();
	// for (e in PlayState.playerStrums.members) {
	// 	e.scrollSpeed = FlxMath.lerp(speed, -speed, perc);
	// }
}

// var startReverse = 0;
// var doReverse = false;
// function powYES() {
// var realbeats = (Conductor.songPosition / 1000) * (Conductor.bpm / 60);
// var speed = PlayState.SONG.speed;
// var perc = easeOutBounce(((realbeats - startReverse) / 2.5));
// if (startReverse == 0) {
// 	startReverse = realbeats;
// 	frog.downscroll = !frog.downscroll;
// 	// do this as a way to fix downscroll dying after the first pow
// 	EngineSettings.downscroll = false;
// }
// var perc = easeOutBounce(((realbeats - startReverse) / 2.5));
// if (perc < 1)
// {
// 	for (e in PlayState.playerStrums.members) {
// 		var speed = PlayState.SONG.speed;
// 		if (EngineSettings.downscroll)
// 				e.scrollSpeed = FlxMath.lerp(speed, -speed, perc);
// 		else
// 				e.scrollSpeed = FlxMath.lerp(speed, -speed, perc);
// 	}
	
// 	var multi = 1;
// 	for (i in 0...PlayState.playerStrums.members) {
		
// 		var localPerc = perc * multi;
// 		if (localPerc > 1)
// 			localPerc = 1;
		
// 		if (EngineSettings.downscroll)
// 			PlayState.playerStrums.members[i].y = lerp(25, 26 + FlxG.height - 200, localPerc);
// 		else
// 			PlayState.playerStrums.members[i].y = lerp(26 + FlxG.height - 200, 25, localPerc);
// 		multi += 0.05;
// 	}
// 	PlayState.playerStrums.members.forEachAlive(function(daNote:Note) {
// 		daNote.endHoldOffset = Math.NEGATIVE_INFINITY;
// 	});
// 	}
// }

// function easeOutBounce(x:Int):Int {
// 	var n1 = 7.5625;
// 	var d1 = 2.75;
	
// 	if (x < 1 / d1) {
// 		return n1 * x * x;
// 	} else if (x < 2 / d1) {
// 		return n1 * (x -= 1.5 / d1) * x + 0.75;
// 	} else if (x < 2.5 / d1) {
// 		return n1 * (x -= 2.25 / d1) * x + 0.9375;
// 	} else {
// 		return n1 * (x -= 2.625 / d1) * x + 0.984375;
// 	}
// }

var cameraX:Int = 564.5;
function onPsychEvent(event:String, ?value1:String, ?value2:String) {
	switch(event) {
		case "Pasta Camera":
			switch (Std.parseInt(value1)) {
				case -1:
					cameraX = 364.5;
				case 1:
					cameraX = 764.5;
				default:
					cameraX = 564.5;
			}
		case "Pow":
			// startReverse = 0;
			// doReverse = false;
			// for (e in PlayState.playerStrums.members) {
			// 	e.y = FlxG.height / 2;
			// }
	}
}

function beatHit(curBeat) {
	stage.onBeat();
    if (curBeat % 2 == 0) {
		for (i in pastaBoppers)
			i.animation.play('bop'); 
	}
	if (curBeat >= 84)
		ben.animation.play("look");
}

var pastaBoppers:Array<FlxSprite> = [];
var saled:FlxSprite;
var ben:FlxSprite;

var randomCharacter:Bool = false;
if (save.data.playLordX == null)
	save.data.playLordX = false;
if (save.data.playHypno == null)
	save.data.playHypno = false;
if (save.data.playMX == null)
	save.data.playMX = false;

if (!save.data.playMX && !save.data.playLordX && !save.data.playHypno) {
	trace("you somehow are playing this song without choosing a player so your now being forced to play as Lord X, have fun :)");
	if (!randomCharacter) save.data.playLordX = true;
	else {
		switch(FlxG.random.int(0,2)) {
			case 0:
				save.data.playLordX = true;
			case 1:
				save.data.playHypno = true;
			case 2:
				save.data.playMX = true;
		}
	}
}
save.flush(); // only have to use it once yay
function create() {
	stage = loadStage('poker');
    pastaBoppers = [];
    // PlayState.defaultCamZoom = 0.7;
	var consistentPosition:Array<Float> = [-625, -100];
	var consistentSize:Float = 1.25;
	var sky:FlxSprite = new FlxSprite(consistentPosition[0] + 914 * consistentSize,
		consistentPosition[1] + 263 * consistentSize).loadGraphic(Paths.image('stages/poker/sky'));
	sky.antialiasing = true;
	sky.scrollFactor.set(0.9, 0.9);
	sky.setGraphicSize(Std.int(sky.width * (consistentSize + 0.1)));
	sky.updateHitbox();
	add(sky);

	var shine:FlxSprite = new FlxSprite(consistentPosition[0] + 916 * consistentSize,
		consistentPosition[1] + 265 * consistentSize).loadGraphic(Paths.image('stages/poker/shine'));
	shine.antialiasing = true;
	shine.scrollFactor.set(0.9, 0.9);
	shine.setGraphicSize(Std.int(shine.width * consistentSize));
	shine.updateHitbox();
	add(shine);

	var bg:FlxSprite = new FlxSprite(consistentPosition[0], consistentPosition[1]).loadGraphic(Paths.image('stages/poker/bar'));
	bg.antialiasing = true;
	bg.setGraphicSize(Std.int(bg.width * consistentSize));
	bg.updateHitbox();
	bg.scrollFactor.set(0.9, 0.9);
	add(bg);

	var holder:FlxSprite = new FlxSprite(consistentPosition[0] + 1180 * consistentSize,
		consistentPosition[1] + 228 * consistentSize).loadGraphic(Paths.image('stages/poker/holder'));
	holder.antialiasing = true;
	holder.setGraphicSize(Std.int(holder.width * consistentSize));
	holder.scrollFactor.set(0.9, 0.9);
	add(holder);

	saled = new FlxSprite(consistentPosition[0] + 1050 * consistentSize, Math.floor(consistentPosition[1] + 390 * consistentSize) - 1);
	saled.frames = Paths.getSparrowAtlas('stages/poker/SFingers');
	saled.animation.addByPrefix('bop', 'SFingers', 24, false);
	saled.animation.play('bop');
	saled.antialiasing = true;
	saled.setGraphicSize(Std.int(saled.width * consistentSize));
	saled.scrollFactor.set(0.9, 0.9);
	saled.x -= saled.width / 2;
	saled.y -= saled.height - 10;
	add(saled);
	pastaBoppers.push(saled);

	var widemouth:FlxSprite = new FlxSprite(consistentPosition[0] + 1150 * consistentSize, consistentPosition[1] + 390 * consistentSize);
	widemouth.frames = Paths.getSparrowAtlas('stages/poker/MrWidemouth');
	widemouth.animation.addByPrefix('bop', 'MrWidemouth instance 1', 24, false);
	widemouth.animation.play('bop');
	widemouth.antialiasing = true;
	widemouth.setGraphicSize(Std.int(widemouth.width * consistentSize));
	widemouth.scrollFactor.set(0.9, 0.9);
	widemouth.x -= widemouth.width / 2;
	widemouth.y -= widemouth.height - 8;
	add(widemouth);
	pastaBoppers.push(widemouth);

	var machine:FlxSprite = new FlxSprite(200, 70).loadGraphic(Paths.image('stages/poker/Machine'));
	machine.antialiasing = true;
	machine.setGraphicSize(Std.int(machine.width * (consistentSize * .35)));
	machine.scrollFactor.set(0.9, 0.9);
		

	add(machine);

	var herobrine:FlxSprite = new FlxSprite(315,308);
	herobrine.frames = Paths.getSparrowAtlas('stages/poker/brian_idle');
	herobrine.animation.addByPrefix('bop', 'brian idle ', 24, false);
	herobrine.animation.play('bop');
	herobrine.antialiasing = true;
	herobrine.setGraphicSize(Std.int(herobrine.width * consistentSize));
	herobrine.scrollFactor.set(0.9, 0.9);

	add(herobrine);


		// HER NAME IS FUCKING "THE" GET IT RIGHT
	var peach:FlxSprite = new FlxSprite(490, 279);
	peach.frames = Paths.getSparrowAtlas('stages/poker/CoronationPeach');
	peach.animation.addByPrefix('bop', 'CoronationPeach', 24, false);
	peach.animation.play('bop');
	peach.antialiasing = true;
	peach.setGraphicSize(Std.int(peach.width * (consistentSize * 0.5)));
	peach.scrollFactor.set(0.9, 0.9);

	var shitno:FlxSprite = new FlxSprite(610, 312);
	shitno.frames = Paths.getSparrowAtlas('stages/poker/ShintoPastaNight');
	shitno.animation.addByPrefix('bop', 'Shitno', 24, false);
	shitno.animation.play('bop');
	shitno.antialiasing = true;
	shitno.setGraphicSize(Std.int(shitno.width * (consistentSize * 0.5)));
	shitno.scrollFactor.set(0.9, 0.9);
	add(shitno);

	add(peach);


	var jack:FlxSprite = new FlxSprite(100, 180); // sorry shubs I don't know what the fuck a consistent position is
	jack.frames = Paths.getSparrowAtlas('stages/poker/Jack');
	jack.animation.addByPrefix('bop', 'Body with tar instance 1', 24, false);
	jack.animation.play('bop');
	jack.antialiasing = true;
	jack.setGraphicSize(Std.int(jack.width * (consistentSize * .64)));
	jack.scrollFactor.set(0.9, 0.9);

	add(jack);
	
	var otherTable:FlxSprite = new FlxSprite(595,355).loadGraphic(Paths.image('stages/poker/TableMisc'));
	otherTable.antialiasing = true;
	otherTable.setGraphicSize(Std.int(otherTable.width * (consistentSize * 0.5)));
	otherTable.scrollFactor.set(0.9, 0.9);

	var slenderBitch:FlxSprite = new FlxSprite(735,35);
	slenderBitch.frames = Paths.getSparrowAtlas('stages/poker/Buds_Slender_Effects');
	slenderBitch.animation.addByPrefix('bop', 'Slenderman Full', 24, true);
	slenderBitch.animation.play('bop');
	slenderBitch.antialiasing = true;
	slenderBitch.setGraphicSize(Std.int(slenderBitch.width * (consistentSize * 0.55)));
	slenderBitch.scrollFactor.set(0.9, 0.9);
	add(slenderBitch);
	
	ben = new FlxSprite(1145,175);
	ben.frames = Paths.getSparrowAtlas('stages/poker/Ben_Drowned_BG');
	ben.animation.addByPrefix('idle', 'ben drowned0', 24, false);
	ben.animation.addByPrefix('look', 'ben drowned looking', 24, false);
	ben.animation.play('idle');
	ben.antialiasing = true;
	ben.setGraphicSize(Std.int(ben.width * (consistentSize * 0.55)));
	ben.scrollFactor.set(0.9, 0.9);

	add(ben);

	var squid:FlxSprite = new FlxSprite(750,210);
	squid.frames = Paths.getSparrowAtlas('stages/poker/Squirtward');
	squid.animation.addByPrefix('bop', 'Squidward_idleBody', 24, false);
	squid.animation.play('bop');
	squid.antialiasing = true;
	squid.setGraphicSize(Std.int(squid.width * (consistentSize * 0.6)));
	squid.scrollFactor.set(0.9, 0.9);
	add(squid);
	
	
	var squidHead:FlxSprite = new FlxSprite(750,210);
	squidHead.frames = Paths.getSparrowAtlas('stages/poker/Squirtward');
	squidHead.animation.addByPrefix('bop', 'Squidward_idleHead', 24, false);
	squidHead.animation.play('bop');
	squidHead.antialiasing = true;
	squidHead.setGraphicSize(Std.int(squid.width * (consistentSize * 0.6)));
	squidHead.scrollFactor.set(0.9, 0.9);
	add(squidHead);

	add(otherTable);

	var jeff:FlxSprite = new FlxSprite(472, 305); // sorry shubs I don't know what the fuck a consistent position is
	jeff.frames = Paths.getSparrowAtlas('stages/poker/Jeff');
	jeff.animation.addByPrefix('bop', 'mynamejeff instance 1', 24, false);
	jeff.animation.play('bop');
	jeff.antialiasing = true;
	jeff.setGraphicSize(Std.int(jeff.width * (consistentSize * .78)));
	jeff.scrollFactor.set(0.9, 0.9);

	add(jeff);

	var tableboppers:FlxSprite = new FlxSprite(consistentPosition[0] + 900 * consistentSize, consistentPosition[1] + 750 * consistentSize);
	tableboppers.frames = Paths.getSparrowAtlas('stages/poker/Mousetable');
	tableboppers.animation.addByPrefix('bop', 'Mousetable', 24, false);
	tableboppers.animation.play('bop');
	tableboppers.antialiasing = true;
	tableboppers.setGraphicSize(Std.int(tableboppers.width * (consistentSize * 0.5)));
	tableboppers.scrollFactor.set(0.9, 0.9);
	tableboppers.x -= tableboppers.width / 2;
	tableboppers.y -= tableboppers.height;

	var jeffArm:FlxSprite = new FlxSprite(500, 445); // sorry shubs I don't know what the fuck a consistent position is
	jeffArm.frames = Paths.getSparrowAtlas('stages/poker/JeffArm');
	jeffArm.animation.addByPrefix('bop', 'Only the arm shit instance 1', 24, false);
	jeffArm.animation.play('bop');
	jeffArm.antialiasing = true;
	jeffArm.setGraphicSize(Std.int(jeffArm.width * (consistentSize * .78)));
	jeffArm.scrollFactor.set(0.9, 0.9);

	add(tableboppers);
	add(jeffArm);

	pastaBoppers.push(tableboppers);			
	pastaBoppers.push(jack);		
	pastaBoppers.push(jeff);		
	pastaBoppers.push(jeffArm);
	pastaBoppers.push(squid);
	pastaBoppers.push(herobrine);
	pastaBoppers.push(squid);
	pastaBoppers.push(squidHead);
	pastaBoppers.push(slenderBitch);
	pastaBoppers.push(peach);
	pastaBoppers.push(shitno);
	
	gb = new FlxSprite(25000, 350); //lazy since im not motivated to really work on this project anymore
	gb.frames = Paths.getSparrowAtlas('stages/poker/GB_PastaNight_Assets');
	gb.animation.addByPrefix('idle', 'GBWalkPioladepana', 24, true);
	gb.animation.play('idle');
	gb.antialiasing = true;
	gb.setGraphicSize(Std.int(gb.width * 1.65));
	gb.scrollFactor.set(0.9, 0.9);
	add(gb);

	gold = new FlxSprite(10000, 50); //lazy since im not motivated to really work on this project anymore
	gold.frames = Paths.getSparrowAtlas('stages/poker/GOLD_PASTA_NIGHT');
	gold.animation.addByPrefix('idle', 'GOLD PASTA NIGHT instance 1', 24, true);
	gold.animation.play('idle');
	gold.antialiasing = true;
	gold.setGraphicSize(Std.int(gold.width * 1.65));
	gold.scrollFactor.set(0.9, 0.9);
	add(gold);

    lordX = new Character(550, -10, mod + ":" + "MonoTits");
    lordX.visible = true;
	PlayState.dads[1] = lordX;
	lordX.x -= 600;
	lordX.y += 150;

    hypno = new Character(900, 135, mod + ":" + "sansIndie");
    hypno.visible = true;
	PlayState.dads[2] = hypno;
	hypno.flipX = true;

    mx = new Character(-110, 20, mod + ":" + "LJ");
    mx.visible = true;
	PlayState.dads[3] = mx; // because
	
	table = new FlxSprite().loadGraphic(Paths.image('stages/poker/TABLE'));
	table.setGraphicSize(Std.int(table.width * 0.75));
	table.updateHitbox();
	table.antialiasing = true;
	table.screenCenter();
	table.x -= 60;
	table.y += 670;
    PlayState.add(hypno);
    PlayState.add(mx);
    PlayState.add(lordX);
	PlayState.add(table);
}

function createInFront() {
}

function createPost() {
	PlayState.iconP1.visible = false;
	PlayState.iconP2.visible = false;
		
	PlayState.health += 0.0001;
	PlayState.health -= 0.0001;

    // shader = new CustomShader(mod + ":filmgrain");
	// PlayState.camGame.setFilters([new ShaderFilter(shader)]);

    filmGrain = new CustomShader(mod + ":old");
	PlayState.camGame.setFilters([new ShaderFilter(filmGrain)]);
	filmGrain.data.iTime.value = [0.0];
    PlayState.camGame.filtersEnabled = true;
}