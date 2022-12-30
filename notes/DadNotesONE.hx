// HYPNO LOL
enableRating = true;
var song = PlayState.song.song.toLowerCase();

function create() {
    super.create();
    if (song == "poker-night" && save.data.playHypno != null)
        note.mustPress = save.data.playHypno;
}

function onDadHit() {
    switch(note.noteData % PlayState.song.keyNumber) {
        case 0:
            PlayState.dads[2].playAnim("singLEFT", true);
        case 1:
            PlayState.dads[2].playAnim("singDOWN", true);
        case 2:
            PlayState.dads[2].playAnim("singUP", true);
        case 3:
            PlayState.dads[2].playAnim("singRIGHT", true);
    }
}

function onPlayerHit() {
    if (song == "poker-night")
        onDadHit(); // bc lazy
    else
        super.onPlayerHit();
}

function update() {
    super.update();
    if (song == "poker-night" && save.data.playHypno != null)
        note.mustPress = save.data.playHypno;
}
