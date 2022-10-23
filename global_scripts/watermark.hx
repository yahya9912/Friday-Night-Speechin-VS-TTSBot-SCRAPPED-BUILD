import flixel.text.FlxText;
function createPost(){
    var watermark = new FlxText(PlayState.scoreTxt.x + 500, PlayState.scoreTxt.y + -120, 0, "DEV BUILD DO NOT SHARE");
    watermark.setFormat(Paths.font("vcr.ttf"), 24);
  //  watermark.alignment = 'CENTER';
    watermark.scrollFactor.set();
    watermark.cameras = [camHUD];
    PlayState.add(watermark);
    watermark.setGraphicSize(Width = -512, Height = -512);
    
}