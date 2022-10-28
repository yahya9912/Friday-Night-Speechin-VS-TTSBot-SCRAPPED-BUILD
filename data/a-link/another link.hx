function onDadHit(note:Note){
    if(PlayState.health <= (4 / 100 * PlayState.maxHealth)){
        return;
    }
    else{
        if (note.isSustainNote) {
            PlayState.currentSustains.push({time: Conductor.songPosition, healthVal: -note.sustainHealth * (global["lampChange"] == true ? 2 : 1)});
        } else {
            PlayState.health -= (1 / 100 * PlayState.maxHealth) * (global["lampChange"] == true ? 2 : 1);
	 }
   
    }
}