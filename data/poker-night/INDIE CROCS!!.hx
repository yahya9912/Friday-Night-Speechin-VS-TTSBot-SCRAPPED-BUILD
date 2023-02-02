//a
EngineSettings.middleScroll = false;

var strums = [];
var strumLocations:Array<Dynamic> = [
    [[437.4,538.2,639,739.8], [16.4,117.2,218,318.8], [861.4,962.2,1063,1163.8]],
    [[861.4,962.2,1063,1163.8], [437.4,538.2,639,739.8], [16.4,117.2,218,318.8]],
    [[16.4,117.2,218,318.8], [861.4,962.2,1063,1163.8],  [437.4,538.2,639,739.8]]
];

var curPlayer:Int = 1;
var index:Int = 0;
function onGenerateStaticArrows() {
    if (save.data.playLordX && save.data.playLordX != null) curPlayer = 0;
    if (save.data.playHypno && save.data.playHypno != null) curPlayer = 1;
    if (save.data.playMX && save.data.playMX != null) curPlayer = 2;

    for(e in PlayState.playerStrums.members) {
        e.x *= 0.9;
        e.x = strumLocations[curPlayer][0][index];
        index++;
    }

    index = 0;
    for(e in PlayState.cpuStrums.members) {
        e.x *= 0.9;
        e.x = strumLocations[curPlayer][1][index];
        e.alpha = 0.5;
        index++;
    }

    PlayState.generateStaticArrows();

    index = 0;
    for(i in 0...PlayState.song.keyNumber) {
        var strum = PlayState.cpuStrums.members[i + PlayState.song.keyNumber];
        strum.x *= 0.9;
        strum.x = strumLocations[curPlayer][2][index];
        strum.alpha = 0.5;
        strums.push(strum);
        index++;
    }
}

var noteType_Pasta:Int = 1; // 0 = Default Note, 1 is Dad Notes ONE, and 2 is Dad Notes 2
if (save.data.playLordX) noteType_Pasta = 1;
if (save.data.playHypno) noteType_Pasta = 2;
if (save.data.playMX) noteType_Pasta = 0;

function updatePost(elapsed:Float) {
    EngineSettings.glowCPUStrums = true;
    PlayState.notes.forEach(function(n) {
        if (n.noteType == noteType_Pasta) {
            var strum = PlayState.cpuStrums.members[n.noteData % PlayState.song.keyNumber];
            var nStrum = strums[n.noteData % PlayState.SONG.keyNumber];
            n.x = n.x - strum.x + nStrum.x;
            n.y = n.y - strum.y + nStrum.y;
        }
    });
}

function onDadHit(note:Note) {
    if (!(EngineSettings.glowCPUStrums = !(note.noteType == noteType_Pasta))) {
        var nStrum = strums[note.noteData % PlayState.song.keyNumber % PlayState.song.keyNumber];
        nStrum.cpuRemainingGlowTime = Conductor.stepCrochet * 1.5 / 1000;
        nStrum.animation.play("confirm", true);
        nStrum.centerOffsets();
        nStrum.centerOrigin();
        nStrum.toggleColor(nStrum.colored);
    }
}