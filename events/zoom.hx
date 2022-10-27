function addCameraZoom(camZoom:String, hudZoom:String) {
    FlxG.camera.zoom += Std.parseFloat(camZoom);
    PlayState.camHUD.zoom += Std.parseFloat(hudZoom);
}