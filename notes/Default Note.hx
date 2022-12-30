//a
var song = PlayState.song.song.toLowerCase();
function create() {
    super.create();
    if (song == "poker-night" && save.data.playLordX != null)
        note.mustPress = save.data.playLordX;
}

function onDadHit() {
    switch(note.noteData % PlayState.song.keyNumber) {
        case 0:
            if (song == "poker-night") PlayState.dads[1].playAnim("singLEFT", true);
            else playDadsAnim("singLEFT", true);
        case 1:
            if (song == "poker-night") PlayState.dads[1].playAnim("singDOWN", true);
            else playDadsAnim("singDOWN", true);
        case 2:
            if (song == "poker-night") PlayState.dads[1].playAnim("singUP", true);
            else playDadsAnim("singUP", true);
        case 3:
            if (song == "poker-night") PlayState.dads[1].playAnim("singRIGHT", true);
            else playDadsAnim("singRIGHT", true);
    }
}

function onPlayerHit() {
    super.onPlayerHit();
    if (song == "poker-night")
        onDadHit();
    else {
        switch(note.noteData % PlayState.song.keyNumber) {
            case 0:
                playBFsAnim("singLEFT", true);
            case 1:
                playBFsAnim("singDOWN", true);
            case 2:
                playBFsAnim("singUP", true);
            case 3:
                playBFsAnim("singRIGHT", true);
        }
    }
}

function update() {
    super.update();
    if (song != 'poker-night')
        return;
    if (save.data.playLordX != null)
        note.mustPress = save.data.playLordX;
}