//a
import openfl.filters.ShaderFilter;
import ScoreText;
import flixel.math.FlxMath;
import haxe.ds.StringMap;

var stage:Stage = null;

var backdrop:CustomShader;
var gameSplitscreen:CustomShader;
var hudSplitscreen:CustomShader;
var trippyshader:CustomShader;
function create() {
	autoCamZooming = false;
	PlayState.isWidescreen = false;
	stage = loadStage('A LINK');
	// EngineSettings.botplay = true;
}

var cpuNotes:Array<Note> = [];
function createPost() {

	for (i in 0...PlayState.SONG.keyNumber) {
		var playerStrum = PlayState.playerStrums.members[i];
		var cpuStrum = PlayState.cpuStrums.members[i];
		cpuStrum.cameras = [PlayState.camGame];
		cpuStrum.x -= 50;
		cpuStrum.x += 125*i;
		if (i > 1) cpuStrum.x += 450;
		cpuStrum.y -= 550;
		cpuStrum.visible = false;

		playerStrum.x = Std.int(PlayState.current.guiSize.x / 2) + ((i - (PlayState.SONG.keyNumber / 2)) * Note.swagWidth);
		
	}
    backdrop = new CustomShader(Paths.shader("BackdropShader"));
    backdrop.data.iTime.value = [0.0];
    backdrop.data.offset.value = [0, -1.5];
	var bgLinks = stage.getSprite("A LINKS");
    backdrop.data.scaling.value = [bgLinks.scale.x, bgLinks.scale.y];
	bgLinks.shader = backdrop;


    // trippyshader = new CustomShader(Paths.shader("old"));
	// trippyshader.data.iTime.value = [0.0];
    stolenDXshader = new CustomShader(Paths.shader("dx but stolon"));
	stolenDXshader.data.enable.value = [false];
	
    gameSplitscreen = new CustomShader(Paths.shader("SplitScreen"));
    hudSplitscreen = new CustomShader(Paths.shader("SplitScreen"));

	gameSplitscreen.data.renderOffset.value = [0, 0];
    gameSplitscreen.data.renderScale.value = [1,1];
    gameSplitscreen.data.renderRot.value = [0];

	hudSplitscreen.data.renderOffset.value = [0, 0];
    hudSplitscreen.data.renderScale.value = [1,1];
    hudSplitscreen.data.renderRot.value = [0];

	PlayState.camGame.setFilters([new ShaderFilter(gameSplitscreen), new ShaderFilter(stolenDXshader)]);
	PlayState.camHUD.setFilters([new ShaderFilter(hudSplitscreen)]);

	for (note in PlayState.unspawnNotes) {
		if (note.mustPress) continue;
		note.cameras = [PlayState.camGame];
		note.scale.set(note.scale.x + 0.1, note.scale.y + 0.1);
	}

}

var tweens:StringMap<FlxTween> = new StringMap();
function setSplitscreenShaderData(
	?gameSplitMultScale:Array<Dynamic>, ?gameSplitOff:Array<Dynamic>, ?gameSplitRotation:Array<Dynamic>,
	?hudSplitMultScale:Array<Dynamic>, ?hudSplitOff:Array<Dynamic>, ?hudSplitRotation:Array<Dynamic>) {
		
		if (gameSplitMultScale != null) {
			if (gameSplitMultScale[1] == null) gameSplitMultScale[1] = gameSplitMultScale[0];
			if (gameSplitMultScale[2] == null) gameSplitMultScale[2] = 1;
			if (gameSplitMultScale[3] == null) gameSplitMultScale[2] = FlxEase.linear;
			if (gameSplitMultScale[4] == null) gameSplitMultScale[4] = gameSplitMultScale[3];
			
			if (tweens.exists("gameSplitScale_1")) tweens.get("gameSplitScale_1").cancel();
			var twn = FlxTween.num(gameSplitscreen.data.renderScale.value[0], gameSplitMultScale[0], gameSplitMultScale[2], {ease: gameSplitMultScale[3]}, function(v:Float) {
				gameSplitscreen.data.renderScale.value[0] = v;
			});
			tweens.set("gameSplitScale_1", twn);

			if (tweens.exists("gameSplitScale_2")) tweens.get("gameSplitScale_2").cancel();
			var twn = FlxTween.num(gameSplitscreen.data.renderScale.value[1], gameSplitMultScale[1], gameSplitMultScale[2], {ease: gameSplitMultScale[4]}, function(v:Float) {
				gameSplitscreen.data.renderScale.value[1] = v;
			});
			tweens.set("gameSplitScale_2", twn);
		}


		if (gameSplitOff != null) {
			if (gameSplitOff[2] == null) gameSplitOff[2] = 1;
			if (gameSplitOff[3] == null) gameSplitOff[3] = FlxEase.linear;
			if (gameSplitOff[4] == null) gameSplitOff[4] = gameSplitOff[3];
			
			if (tweens.exists("gameSplitOffset_1")) tweens.get("gameSplitOffset_1").cancel();
			var twn = FlxTween.num(gameSplitscreen.data.renderOffset.value[0], gameSplitOff[0], gameSplitOff[2], {ease: gameSplitOff[3]}, function(v:Float) {
				gameSplitscreen.data.renderOffset.value[0] = v;
			});
			tweens.set("gameSplitOffset_1", twn);
			
			if (tweens.exists("gameSplitOffset_2")) tweens.get("gameSplitOffset_2").cancel();
			var twn = FlxTween.num(gameSplitscreen.data.renderOffset.value[1], gameSplitOff[1], gameSplitOff[2], {ease: gameSplitOff[4]}, function(v:Float) {
				gameSplitscreen.data.renderOffset.value[1] = v;
			});
			tweens.set("gameSplitOffset_2", twn);
		}
		if (gameSplitRotation != null) {
			if (gameSplitRotation[1] == null) gameSplitRotation[1] = 1;
			if (gameSplitRotation[2] == null) gameSplitRotation[2] = FlxEase.linear;
			if (tweens.exists("gameSplitRotation")) tweens.get("gameSplitRotation").cancel();
			var twn = FlxTween.num(gameSplitscreen.data.renderRot.value[0], gameSplitRotation[0], gameSplitRotation[1], {ease: gameSplitRotation[2]}, function(v:Float) {
				gameSplitscreen.data.renderRot.value[0] = v;
			});
			tweens.set("gameSplitRotation", twn);
		}
		
		
		if (hudSplitMultScale != null) {
			if (hudSplitMultScale[1] == null) hudSplitMultScale[1] = hudSplitMultScale[0];
			if (hudSplitMultScale[2] == null) hudSplitMultScale[2] = 1;
			if (hudSplitMultScale[3] == null) hudSplitMultScale[2] = FlxEase.linear;
			if (hudSplitMultScale[4] == null) hudSplitMultScale[4] = hudSplitMultScale[3];
			
			if (tweens.exists("camSplitScale_1")) tweens.get("camSplitScale_1").cancel();
			var twn = FlxTween.num(hudSplitscreen.data.renderScale.value[0], hudSplitMultScale[0], hudSplitMultScale[2], {ease: hudSplitMultScale[3]}, function(v:Float) {
				hudSplitscreen.data.renderScale.value[0] = v;
			});
			tweens.set("camSplitScale_1", twn);

			if (tweens.exists("camSplitScale_2")) tweens.get("camSplitScale_2").cancel();
			var twn = FlxTween.num(hudSplitscreen.data.renderScale.value[1], hudSplitMultScale[1], hudSplitMultScale[2], {ease: hudSplitMultScale[4]}, function(v:Float) {
				hudSplitscreen.data.renderScale.value[1] = v;
			});
			tweens.set("camSplitScale_2", twn);
		}

		if (hudSplitOff != null) {
			if (hudSplitOff[2] == null) hudSplitOff[2] = 1;
			if (hudSplitOff[3] == null) hudSplitOff[3] = FlxEase.linear;
			if (hudSplitOff[4] == null) hudSplitOff[4] = hudSplitOff[3];
			
			if (tweens.exists("camSplitOffset_1")) tweens.get("camSplitOffset_1").cancel();
			var twn = FlxTween.num(hudSplitscreen.data.renderOffset.value[0], hudSplitOff[0], hudSplitOff[2], {ease: hudSplitOff[3]}, function(v:Float) {
				hudSplitscreen.data.renderOffset.value[0] = v;
			});
			tweens.set("camSplitOffset_1", twn);
			
			if (tweens.exists("camSplitOffset_2")) tweens.get("camSplitOffset_2").cancel();
			var twn = FlxTween.num(hudSplitscreen.data.renderOffset.value[1], hudSplitOff[1], hudSplitOff[2], {ease: hudSplitOff[4]}, function(v:Float) {
				hudSplitscreen.data.renderOffset.value[1] = v;
			});
			tweens.set("camSplitOffset_2", twn);
		}
		if (hudSplitRotation != null) {
			if (hudSplitRotation[1] == null) hudSplitRotation[1] = 1;
			if (hudSplitRotation[2] == null) hudSplitRotation[2] = FlxEase.linear;
			if (tweens.exists("hudSplitRotation")) tweens.get("hudSplitRotation").cancel();
			var twn = FlxTween.num(hudSplitscreen.data.renderRot.value[0], hudSplitRotation[0], hudSplitRotation[1], {ease: hudSplitRotation[2]}, function(v:Float) {
				hudSplitscreen.data.renderRot.value[0] = v;
			});
			tweens.set("hudSplitRotation", twn);
		}

}


var bumpALINKS:Bool = false;
function update(elapsed) {
	stage.update(elapsed);
	doShaderUpdates(elapsed);


	if (bumpALINKS) {
		var decBeat = curDecBeat;
		if (decBeat < 0) decBeat = 1 + (decBeat % 1);
		var iconlerp = FlxMath.lerp(1.35, 1.3, FlxEase.cubeOut(decBeat % 1));
		stage.getSprite("A LINKS").scale.set(iconlerp, iconlerp);
	}
}

function beatHit(curBeat) {
	stage.onBeat();
	switch(curBeat) {
		case 68:
			setSplitscreenShaderData([5, 5, 2, FlxEase.quadInOut]);
		case 71:
			setSplitscreenShaderData(null, [-10, 0, 6, FlxEase.quadInOut]);
		case 81:
			setSplitscreenShaderData([1, 1, 2, FlxEase.backInOut]);
		case 100:
			setSplitscreenShaderData(
				[15, 15, 1.5, FlxEase.quadInOut], [-9.5, 0.5, 0.5 FlxEase.quadOut], [3.14, 3, FlxEase.quadInOut],
				null, null, [0.4, 3, FlxEase.circInOut]);
			// FlxTween.tween(PlayState.camHUD, {angle: 180}, 3, {ease: FlxEase.circInOut}); // DO NOT
		case 104:
			setSplitscreenShaderData([1, 1, 1.5, FlxEase.quadInOut], [-10, 0, 1 FlxEase.quadOut]);
		case 136:
			setSplitscreenShaderData(null, null, [0, 2, FlxEase.quadInOut], null, null, [0, 2, FlxEase.quadInOut]);
			
		case 168:
			setSplitscreenShaderData([5, 5, 2, FlxEase.circOut]);
			gameSplitscreen.data.renderOffset.value[0] = 0;
			gameSplitscreen.data.renderOffset.value[1] = 0;
			stolenDXshader.data.enable.value = [true];
		case 180:
			setSplitscreenShaderData([8, 8, 5, FlxEase.backInOut]);
		case 190:
			setSplitscreenShaderData([6, 6, 5, FlxEase.backInOut]);
		case 200:
			setSplitscreenShaderData([1, 1, 3, FlxEase.backInOut]);
		case 204:
			setSplitscreenShaderData(
				null, [Math.floor(gameSplitscreen.data.renderOffset.value[0]), Math.floor(gameSplitscreen.data.renderOffset.value[1]), 1, FlxEase.quadOut]);
		case 208:
			setSplitscreenShaderData(
				null, null, null,
				[1.5, 1.5, 3, FlxEase.quadInOut], [0.25,-0.25, 1, FlxEase.quadIn]);
		case 215:
			setSplitscreenShaderData(
				null, null, null,
				[4, 4, 3.5, FlxEase.backInOut]);
		case 220:
			setSplitscreenShaderData(
				null, null, null,
				[5, 3, 2, FlxEase.backInOut]);
		case 226:
			setSplitscreenShaderData(
				null, null, null,
				[3, 5, 2, FlxEase.backInOut]);
		case 232:
			setSplitscreenShaderData(
				null, null, null,
				[2, 2, 1.5, FlxEase.quadInOut]);
		case 236:
			stolenDXshader.data.enable.value = [false];
			setSplitscreenShaderData(
				null, null, null,
				[1, 1, 1, FlxEase.quadOut], [Math.floor(hudSplitscreen.data.renderOffset.value[0])+1, Math.floor(hudSplitscreen.data.renderOffset.value[1]), 1, FlxEase.quadInOut]);
		case 240, 256:
			setSplitscreenShaderData(
				[4, 4, 3, FlxEase.quadInOut], null, [0.35, 3, FlxEase.quadInOut],
				[4, 4, 3, FlxEase.quadInOut], null, [0.35, 3, FlxEase.quadInOut]);
		case 248:
			setSplitscreenShaderData(
				[2, 2, 3, FlxEase.quadInOut], null, [-0.35, 3, FlxEase.quadInOut],
				[2, 2, 3, FlxEase.quadInOut], null, [-0.35, 3, FlxEase.quadInOut]);
		case 268:
			setSplitscreenShaderData(
				[5, 5, 3, FlxEase.quadInOut], [Math.floor(gameSplitscreen.data.renderOffset.value[0]), Math.floor(gameSplitscreen.data.renderOffset.value[1]), 1, FlxEase.quadOut], [0.5, 2, FlxEase.quadInOut],
				[1, 1, 3, FlxEase.quadInOut], [Math.floor(hudSplitscreen.data.renderOffset.value[0]), Math.floor(hudSplitscreen.data.renderOffset.value[1]), 1, FlxEase.quadInOut], [0, 2, FlxEase.quadInOut]);
		case 272:
			setSplitscreenShaderData([1, 1, 2, FlxEase.quadInOut], null, [0, 2, FlxEase.quadInOut]);

	}
}

function doShaderUpdates(elapsed) {
	if (curBeat > 175 && curBeat < 204) {
		gameSplitscreen.data.renderOffset.value[0] = FlxMath.lerp(gameSplitscreen.data.renderOffset.value[0], gameSplitscreen.data.renderOffset.value[0] - 0.75, elapsed);
		gameSplitscreen.data.renderOffset.value[1] = FlxMath.lerp(gameSplitscreen.data.renderOffset.value[1], gameSplitscreen.data.renderOffset.value[0] + 0.75, elapsed);
	}
	if (curBeat > 209 && curBeat < 236) {
		hudSplitscreen.data.renderOffset.value[0] = FlxMath.lerp(hudSplitscreen.data.renderOffset.value[0], hudSplitscreen.data.renderOffset.value[0] + 0.25, elapsed);
		hudSplitscreen.data.renderOffset.value[1] = FlxMath.lerp(hudSplitscreen.data.renderOffset.value[1], hudSplitscreen.data.renderOffset.value[1] - 0.25, elapsed);
	}
	if (curBeat > 241 && curBeat < 268) {
		hudSplitscreen.data.renderOffset.value[0] = FlxMath.lerp(hudSplitscreen.data.renderOffset.value[0], hudSplitscreen.data.renderOffset.value[0] - 0.25, elapsed);
		hudSplitscreen.data.renderOffset.value[1] = FlxMath.lerp(hudSplitscreen.data.renderOffset.value[1], hudSplitscreen.data.renderOffset.value[1] - 0.25, elapsed);
		
		gameSplitscreen.data.renderOffset.value[0] = FlxMath.lerp(gameSplitscreen.data.renderOffset.value[0], gameSplitscreen.data.renderOffset.value[0] - 0.25, elapsed);
		gameSplitscreen.data.renderOffset.value[1] = FlxMath.lerp(gameSplitscreen.data.renderOffset.value[1], gameSplitscreen.data.renderOffset.value[1] - 0.25, elapsed);
	}
	
	// trippyshader.data.iTime.value = [trippyshader.data.iTime.value[0] + elapsed];
    backdrop.data.iTime.value = [backdrop.data.iTime.value[0] + elapsed];

}