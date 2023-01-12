//import AlphabetOptimized;
import sys.FileSystem;

var lyrics:Array<Dynamic> = null;
var lyricText:AlphabetOptimized = null;
function createPost() {
	
	if (CoolUtil.difficultyString().toLowerCase() == 'nitro') var path:String = PlayState.SONG.song + '/lyrics-nitro';
	else var path:String = PlayState.SONG.song + '/lyrics';
	lyricText = new AlphabetOptimized(0, 0, '', false, .5);
	lyricText.outline = true;
	lyricText.cameras = [PlayState.camHUD];
	PlayState.add(lyricText);
	if (Assets.exists(Paths.json(path))) {
		trace(path);
		lyrics = Paths.parseJson(path);
	}
	else {
		trace(path);
		trace("Lyrics for " + PlayState.SONG.song.toLowerCase() + " doesn't exist.");
		lyrics = [];
	}
	trace(lyrics);
}

function changeLyricsText(t:String) {
	lyricText.text = t;
	lyricText.screenCenter();
	lyricText.y = PlayState.healthBar.y - PlayState.healthBar.height - 30;
	if (EngineSettings.downscroll) {
		lyricText.y = PlayState.healthBar.y + PlayState.healthBar.height + 450;
		if (EngineSettings.botplay)
			lyricText.y -= 20;
	} else if (EngineSettings.botplay) {
		lyricText.y += 60;
	}
}

function isNull(s:String):Bool {
	var nulls:Array<String> = ['null', '', 'undefined', ' '];
	for (n in nulls) {
		if (s == n)
			return true;
	}
	return false;
}

var prevLyric:Int = -1;

function stepHit(step:Int) {
	// trace('step ' + step);
	var i:Int = 0;
	for (l in lyrics) {
		if (isNull(Std.string(l.color))) {
			l.color = 0xFFFFFFFF;
			l.colorWasNull = true;
		} else if (!l.colorWasNull) {
			l.color = Std.int(l.color);
		}
		if (l.step == step) {
			trace('lyric ' + l.lyrics);
			prevLyric = i;
			// addLyricText(l.lyrics);
			changeLyricsText(l.lyrics);
			lyricText.textColor = l.color;
		}
		i++;
	}
	var clearAt:Int = -1;
	if (prevLyric > -1)
		clearAt = lyrics[prevLyric].clearAt; // if the previous lyric is -1, then there's no lyrics to display yet
	if (clearAt == step) { // set clearAt to -1 if you don't want the lyric to be cleared
		clearLyrics();
	}
}

function addLyrics(lyric:String, color:String, clearAt:Int) { // for events, mayhaps?
	if (Assets.exists(Paths.json(path))) {
		trace('addLyrics() event at step ' + PlayState.curStep + ' | there\'s a lyrics.json file available, use that');
		return;
	}

	lyrics.push({
		step: PlayState.curStep,
		lyrics: lyric,
		color: color,
		clearAt: clearAt
	});
	stepHit(PlayState.curStep);
}

function clearLyrics() { // also for events (but also used internally)
	trace('cleared lyrics');
	changeLyricsText('');
}
