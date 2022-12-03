import Sys;

function create() {
    PlayState.boyfriend.visible = false;
    PlayState.gf.visible = false;
    if (EngineSettings.botplay == true) {
        Sys.exit(0);
    }
    if (EngineSettings.middleScroll == false) {
        EngineSettings.middleScroll = true;
    }
}

function onGuiPopup() {
    PlayState.healthBar.visible = false;
    PlayState.healthBarBG.visible = false;
    if (EngineSettings.botplay == true) {
        PlayState_.destroy;

    }
}

