//a
import openfl.utils.Assets;
var coolShader = new CustomShader(Paths.shader("hotlineVHS"));
function create() {
    coolShader.data.donkey.input = Assets.getBitmapData(Paths.image("donke"));
  //Replace 'donke' with any png image file if you don't want to use it.
    FlxG.camera.addShader(coolShader);
}

function update(elapsed:Float) {
    coolShader.data.time.value = [curDecBeat / 8];
}
