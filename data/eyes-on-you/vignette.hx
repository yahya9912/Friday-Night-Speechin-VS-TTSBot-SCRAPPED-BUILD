var vignette:FlxSprite = null;
function createPost() {
    vignette = new FlxSprite(-640, -360).loadGraphic(Paths.image('monster/mask'));
    vignette.cameras = [PlayState.camHUD];
    vignette.alpha = 1;
    PlayState.add(vignette);

    PlayState.isWidescreen = false;
}

//function musicstart() {

//}