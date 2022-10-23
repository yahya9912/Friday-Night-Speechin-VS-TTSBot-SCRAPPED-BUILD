import flixel.text.FlxText;
function createPost(){
    var watermark = new FlxText(PlayState.scoreTxt.x + 500, PlayState.scoreTxt.y + -120, 0, "!!DEV BUILD DO NOT SHARE!!");
    watermark.setFormat(Paths.font("vcr.ttf"), 24);
  //  watermark.alignment = 'CENTER';
    watermark.scrollFactor.set();
    watermark.cameras = [camHUD];
    PlayState.add(watermark);
    watermark.setGraphicSize(Width = -512, Height = -512);
        if (PlayState.engineSettings.downscroll)
        {
            watermark.y = PlayState.scoreTxt.y + 20;
        }
    
}

var weewoo:Float = 0;

function update(elapsed:Float) {

  weewoo += 0.03;

  watermark.y += Math.sin(weewoo) * 0.8;
  watermark.angle += Math.cos(weewoo) * 0.1;

}