// MX
var song = PlayState.song.song.toLowerCase();

function create() {
    super.create();
    if (song == "poker-night" && save.data.playMX != null)
        note.mustPress = save.data.playMX;
}

function onDadHit() {
    if (song == "poker-night") {
    switch(note.noteData % PlayState.song.keyNumber) {
        case 0:
            PlayState.dads[3].playAnim("singLEFT", true);
        case 1:
            PlayState.dads[3].playAnim("singDOWN", true);
        case 2:
            PlayState.dads[3].playAnim("singUP", true);
        case 3:
            PlayState.dads[3].playAnim("singRIGHT", true);
    }
    } else
        super.onDadHit();
}

function onPlayerHit() {
    if (song == "poker-night")
        onDadHit(); // bc lazy
    else
        super.onPlayerHit();
}

function update() {
    super.update();
    if (song == "poker-night" && save.data.playMX != null)
        note.mustPress = save.data.playMX;
}
