var trippyshader = new CustomShader(Paths.shader('vhs'));
var time = 0;

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
function create()
{
     camGame.addShader(trippyshader);
     

}

function update(elapsed){
    time++;
    if (PlayState.health <= 0.2)
          FlxG.camera.shake(.005,.1);

      trippyshader.shaderData.iTime.value = time;
    }

