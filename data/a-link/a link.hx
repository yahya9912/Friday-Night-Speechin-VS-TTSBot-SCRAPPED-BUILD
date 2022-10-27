// vhs.frag -- vhs/glitch shader -- 
	var vhs = new CustomShader(Paths.shader('vhs'));
	function create() {
		// use PlayState.camHUD.addShader(vhs); to add it on the HUD
		FlxG.camera.addShader(vhs);

		// these have to be here in order to work (the values can be adjusted)
		vhs.data.range.value = [0.1];
		vhs.data.noiseQuality.value = [500.0];
		vhs.data.noiseIntensity.value = [0.0176];
		vhs.data.offsetIntensity.value = [0.04];
		vhs.data.colorOffsetIntensity.value = [2.6];	
	}

	// this code is optional if you want the dynamic effect
	var time:Float = 0;
	function update(elapsed) {
		time += elapsed;
		vhs.data.iTime.value = [time];
	}

//grain.frag
	var grain = new CustomShader(Paths.shader('grain'));
	function create() {
		// use PlayState.camHUD.addShader(grain); to add it on the HUD
		PlayState.camHUD.addShader(grain);

		// this has to be here in order to work (the value can be adjusted)
		grain.data.strength.value = [35];
	}

	// this code is optional if you want the dynamic effect
	var time:Float = 0;
	function update(elapsed) {
		time += elapsed;
		grain.data.iTime.value = [time];
	}