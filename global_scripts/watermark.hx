//a
function createPost(){
    var watermark = new FlxText(PlayState.scoreTxt.x + 468, PlayState.scoreTxt.y + -120, 0, "!!DEV BUILD DO NOT SHARE!!");
    watermark.setFormat(Paths.font("vcr.ttf"), 24);
  //  watermark.alignment = 'CENTER';
    watermark.scrollFactor.set();
    watermark.cameras = [camHUD];
    PlayState.add(watermark);
    watermark.setGraphicSize(Width = -512, Height = -512);
  if (PlayState.engineSettings.downscroll)watermark.y = PlayState.scoreTxt.y + 20;

}
