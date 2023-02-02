function updatePost(elapsed:Float) {
//    if (Conductor.songPosition < 0) return;
    var ease:Float = FlxEase.circIn((Conductor.songPosition / Conductor.crochet) % 1);
    PlayState.iconP1.angle = FlxMath.lerp(PlayState.curBeat % 2 == 0 ? 10 : -10, 0, ease);
    PlayState.iconP2.angle = FlxMath.lerp(PlayState.curBeat % 2 == 0 ? -10 : 10, 0, ease);
}