function updatePost(elapsed:Float) {
//    if (Conductor.songPosition < 0) return;
    var ease:Float = FlxEase.circIn((Conductor.songPosition / Conductor.crochet) % 1);
    PlayState.iconP1.centerOrigin();
    PlayState.iconP1.angle = FlxMath.lerp(PlayState.curBeat % 2 == 0 ? 10 : -10, 0, ease);
    PlayState.iconP1.scale.set(1, FlxMath.lerp(PlayState.curBeat % 2 == 0 ? 0.815 : 1.175, 1, ease));
    PlayState.iconP2.centerOrigin();
    PlayState.iconP2.angle = FlxMath.lerp(PlayState.curBeat % 2 == 0 ? -10 : 10, 0, ease);
    PlayState.iconP2.scale.set(1, FlxMath.lerp(PlayState.curBeat % 2 == 0 ? 1.175 : 0.815, 1, ease));
}