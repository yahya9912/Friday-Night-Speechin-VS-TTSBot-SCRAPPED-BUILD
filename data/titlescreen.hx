//a
var crafterEngineLogo:FlxSprite = null;
var gfDancing:FlxSprite = null;

var BENDY:FlxSprite;
var BF:FlxSprite;
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

    landon = new FlxSprite(858.35, 526).loadGraphic(Paths.image('title/ladern'));
    landon.scale.set(0.4, 0.4);
    landon.updateHitbox();
    landon.antialiasing = true;
    add(landon);

    omg = new FlxSprite(476.05, 19.2).loadGraphic(Paths.image('title/omg'));
    omg.updateHitbox();
    omg.antialiasing = true;
    add(omg);

    logo = new FlxSprite(100, -200).loadGraphic(Paths.image('title/speeching'));
    logo.screenCenter();
    logo.updateHitbox();
    logo.antialiasing = true;
    add(logo);
      
    BF = new FlxSprite();
    BF.frames = Paths.getSparrowAtlas('title/bf');
    BF.animation.addByPrefix('RUN', 'Run_cycle instance 1', 24, true);
    BF.animation.play('RUN');
    BF.flipX = true;
    BF.scale.set(0.5,0.5);
    BF.updateHitbox();
    BF.x = FlxG.width + BF.width;
    BF.y = FlxG.height - BF.height;
    add(BF);
    
    BENDY = new FlxSprite();
    BENDY.frames = Paths.getSparrowAtlas('title/bendy');
    BENDY.animation.addByPrefix('RUN', 'Bendy Run instance 1', 24, true);
    BENDY.animation.play('RUN');
    BENDY.flipX = true;
    BENDY.scale.set(0.5,0.5);
    BENDY.updateHitbox();
    BENDY.x = FlxG.width + BENDY.width + BF.width;
    BENDY.y = FlxG.height - BENDY.height;
    add(BENDY);

    itsLJ = new FlxSprite();
    itsLJ.frames = Paths.getSparrowAtlas('title/lj');
    itsLJ.animation.addByPrefix('fly', 'LJ Up', 24, false);
    itsLJ.animation.play('fly');
    itsLJ.flipX = true;
    itsLJ.scale.set(0.5,0.5);
    itsLJ.updateHitbox();
    itsLJ.screenCenter();
    itsLJ.x = FlxG.width + itsLJ.width/1.5;
    itsLJ.y = FlxG.height - itsLJ.height - 100;
    add(itsLJ);

    mrBeastSFX = new FlxSound().loadEmbedded(Paths.sound('MR BEAST'));
    mrBeastSFX.stop();
    mrBeastSFX.volume = 0.8;

    mrBeast = new FlxSprite();
    mrBeast.frames = Paths.getSparrowAtlas('MRBEATS');
    mrBeast.animation.addByPrefix('mrBeat', 'mrbeast', 24, false);
    mrBeast.animation.play('mrBeat');
    mrBeast.screenCenter();
    add(mrBeast);
    mrBeast.alpha = 0.0001;
    mrBeast.animation.finishCallback = function() {
      mrBeast.alpha = 0.0001;
      mrBeastSFX.stop();
      rngAgain = true;
    }

    explosionDead = new FlxSound().loadEmbedded(Paths.sound('shart'));
    explosionDead.stop();
    explosionDead.volume = 0.8;

    explosion = new FlxSprite();
    explosion.frames = Paths.getSparrowAtlas('splashes');
    explosion.scale.set(3.5,3.5);
    explosion.updateHitbox();
    explosion.animation.addByPrefix('bruh', 'note splash blue 1', 24, false);
    explosion.animation.play('bruh');
    explosion.screenCenter();
    explosion.alpha = 0.0001;
    explosion.x += 200;
    add(explosion);
    explosion.animation.finishCallback = function() {
      explosion.alpha = 0.0001;
      explosionDead.stop();
      rngAgain = true;
    }
    spookyAH = new FlxSprite().loadGraphic(Paths.image('raaa'));
    spookyAH.updateHitbox();
    spookyAH.screenCenter();
    add(spookyAH);
    spookyAH.alpha = 0.0001;

    monochromeAA = new FlxSound().loadEmbedded(Paths.sound('spooky'));
    monochromeAA.stop();
    monochromeAA.volume = 0.6;
}

var weewoo:Float = 0;

var doingTween:Bool = false;
function update(elapsed:Float) {
  if (!doingTween) {
    weewoo += 0.03;
    logo.y += Math.sin(weewoo) * 0.8;
    logo.angle += Math.cos(weewoo) * 0.1;
    itsLJ.y += Math.sin(weewoo) * FlxG.random.float(0.5,1.5);
  }

  if (!monochromeAA.playing) {
    spookyAH.alpha = 0.0001;
  }

}
var rngAgain:Bool = false;
var mrBeastSFX:FlxSound;
var explosionDead:FlxSound;
var monochromeAA:FlxSound;
var ughKillMeBeat:Int = 0;
function beatHit(curBeat:Int) {

  if (ughKillMeBeat == 0) ughKillMeBeat = curBeat;

    FlxG.camera.zoom = 1.03;
    FlxTween.tween(FlxG.camera, {zoom: 1}, 0.4, {ease: FlxEase.quadOut});

    landon.scale.set(1.1, 1.1);
    FlxTween.tween(landon.scale, {x: 1, y: 1}, 0.4, {ease: FlxEase.quadOut});
    FlxTween.tween(logo.scale, {x: 1, y: 1}, 0.4, {ease: FlxEase.quadOut});

    if (FlxG.random.bool(10)) {
      doingTween = true;
      FlxTween.tween(logo, {angle: logo.angle + 360*3}, 1, {ease: FlxEase.quadOut, onComplete: function() {
        FlxTween.tween(logo, {angle: 0}, 0.0001, {ease: FlxEase.quadOut, onComplete: function() {
          doingTween = false;
        }});
      }});
    }

    if (((FlxG.random.bool(90) && rngAgain) && curBeat > ughKillMeBeat + 3) && skippedIntro) {
      trace("Do The FUNNY");
      rngAgain = false;
      switch(FlxG.random.int(1,6)) {
        case 1:
          FlxTween.tween(BF, {x: (BF.x - FlxG.width) - BF.width*2 - BENDY.width - 20}, 7, {ease: FlxEase.linear});
          FlxTween.tween(BENDY, {x: (BENDY.x - FlxG.width) - BENDY.width*2.5 - 20}, 7, {ease: FlxEase.linear, onComplete: function() {
            BF.x = FlxG.width + BF.width;
            BENDY.x = FlxG.width + BENDY.width + BF.width;
            rngAgain = true;
          }});
        case 2:
          mrBeastSFX.play(true, 0);
          mrBeast.alpha = 1;
          mrBeast.animation.play('mrBeat', true);
        case 3:
          FlxTween.tween(itsLJ, {x: (itsLJ.x - FlxG.width) - itsLJ.width*2 - 20}, 8.2, {ease: FlxEase.linear, onComplete: function() {
            itsLJ.x = FlxG.width + itsLJ.width/1.5;
            rngAgain = true;
          }});
        case 4:
          explosion.alpha = 1;
          explosionDead.play(true, 0);
          explosion.animation.play('bruh', true);
        case 5:
          monochromeAA.play(true, 0);
          spookyAH.alpha = 1;
          new FlxTimer().start(1, function(tmr:FlxTimer) {
            rngAgain = true;
          });
        case 6:
          var videoSprite:FlxSprite = null;
          FlxG.sound.music.fadeOut(1, 0.2);
          videoSprite = MP4Video.playMP4(Assets.getPath(Paths.video("wow")),
          function() {
              remove(videoSprite);
              FlxG.sound.music.fadeIn(1, FlxG.sound.music.volume, 0.8);
              rngAgain = true;
          }, // If midsong.
          false, 320,568);
          videoSprite.screenCenter();
          videoSprite.y -= 300;
          videoSprite.x -= 150;
          videoSprite.scrollFactor.set();
          add(videoSprite);
      }
    }
}
