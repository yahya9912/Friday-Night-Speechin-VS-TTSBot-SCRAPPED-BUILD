
var bar:FlxSprite = new FlxSprite().loadGraphic(Paths.image('psvita/bar'));
var ball:FlxSprite = new FlxSprite().loadGraphic(Paths.image('psvita/notif'));

PlayState.isWidescreen = false;
function create(){
 bar.cameras = [PlayState.camHUD];
 bar.y = 50;
 bar.alpha = 1;
 bar.scrollFactor.set(1, 1);
 bar.scale.set(1, 1);
 //bar.updateHitbox();
 PlayState.add(bar);

 ball.cameras = [PlayState.camHUD];
 ball.x = 1192;
 ball.y = 15;
 ball.antialiasing = false;
 bar.scale.set(1, 1);
 //bar.updateHitbox();
 PlayState.add(ball);
}
