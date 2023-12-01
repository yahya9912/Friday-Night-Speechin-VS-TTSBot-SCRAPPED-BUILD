function create() {
    PlayState.boyfriend.visible = false;
    PlayState.gf.visible = false;
    if (!EngineSettings.middleScroll) {
        EngineSettings.middleScroll = true;
    }
}

function onGuiPopup() {
    PlayState.healthBar.visible = false;
    PlayState.healthBarBG.visible = false;
    PlayState.iconP1.visible = false;
    PlayState.iconP2.visible = false;
    PlayState.scoreTxt.visible = false;
    if (EngineSettings.botplay == true) {
        PlayState_.destroy;
    }
}

