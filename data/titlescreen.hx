var crafterEngineLogo:FlxSprite = null;
var gfDancing:FlxSprite = null;
import('flixel.addons.display.FlxBackdrop');
import('flixel.group.FlxSpriteGroup');

function create() {

    bg = new FlxSprite().makeGraphic(Window.width, Window.height, 0xFF36393F);
    bg.updateHitbox();
    bg.antialiasing = true;
    bg.screenCenter();
    add(bg);

    wtf = new FlxSprite(66, 43).loadGraphic(Paths.image('title/wtf'));
    wtf.updateHitbox();
    wtf.antialiasing = true;
    add(wtf);

    td = new FlxSprite(506.25, 69.35).loadGraphic(Paths.image('title/td'));
    td.updateHitbox();
    td.antialiasing = true;
    add(td);

    sas = new FlxSprite(858.35, 526).loadGraphic(Paths.image('title/ladern'));
    sas.scale.set(0.4, 0.4);
    sas.updateHitbox();
    sas.antialiasing = true;
    add(sas);

    omg = new FlxSprite(476.05, 19.2).loadGraphic(Paths.image('title/omg'));
    omg.updateHitbox();
    omg.antialiasing = true;
    add(omg);

    dx = new FlxSprite(100, -200).loadGraphic(Paths.image('title/speeching'));
    dx.screenCenter();
    dx.updateHitbox();
    dx.antialiasing = true;
    add(dx);

}

var weewoo:Float = 0;

function update(elapsed:Float) {

  weewoo += 0.03;

  dx.y += Math.sin(weewoo) * 0.8;
  dx.angle += Math.cos(weewoo) * 0.1;

}

function beatHit() {

    FlxG.camera.zoom = 1.03;
    FlxTween.tween(FlxG.camera, {zoom: 1}, 0.4, {ease: FlxEase.quadOut});

    omg.scale.set(1.1, 1.1);
    FlxTween.tween(omg.scale, {x: 1, y: 1}, 0.4, {ease: FlxEase.quadOut});
    FlxTween.tween(dx.scale, {x: 1, y: 1}, 0.4, {ease: FlxEase.quadOut});
}
