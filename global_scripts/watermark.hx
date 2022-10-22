function createPost(){
    var watermark = new FlxSprite(380,40).loadGraphic(Paths.image('Watermark'));
    watermark.scrollFactor.set(0.0,0.0);
    watermark.cameras = [camHUD];
    PlayState.add(watermark);
    setGraphicSize(Width = -512, Height = -512);
}