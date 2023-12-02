import("openfl.filters.ShaderFilter");

//var bg:FlxSprite = null;

var camShader:CustomShader;
var camShader2:CustomShader;



function create() {
    camShader = new CustomShader(Paths.shader("fart"));
    camShader2 = new CustomShader(Paths.shader("bloom"));

    PlayState.camHUD.setFilters([new ShaderFilter(camShader2)]);
    PlayState.camHUD.filtersEnabled = false;

    FlxG.camera.setFilters([new ShaderFilter(camShader)]);
    FlxG.camera.filtersEnabled = false;

 //saving these for later teehee -yahya   
    
/*    transitionTrain = new FlxSprite(3000, 150);

    bgParticlesBF.angle = 270;
    bgParticlesPico.angle = 90;
    transitionTrain.loadGraphic(Paths.image("philly/train"));
    transitionTrain.scrollFactor.set(1.5, 1);
    transitionTrain.scale.set(2.25, 2.25);
    transitionTrain.updateHitbox();
    transitionTrain.antialiasing = true;
    */


    //PlayState.insert(PlayState.members.indexOf(streetBehind), bgParticlesBF);
    //PlayState.insert(PlayState.members.indexOf(streetBehind), bgParticlesPico);

    // if (CoolUtil.isDevMode()) PlayState.defaultCamZoom = 0.5; // debug shit
}

        PlayState.camFollowLerp = 0.06;
       // bg.visible = false;