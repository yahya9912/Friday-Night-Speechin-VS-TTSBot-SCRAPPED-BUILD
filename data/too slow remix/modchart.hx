function beatHit(curBeat){
    switch curBeat{
        case 60:
            dad.switchCharacter("alexgs cat", mod);
            boyfriend.switchCharacter("tts-player", mod);
        case 266:
            defaultCamZoom += 0.2;
        case 267:
            defaultCamZoom += 0.2;
        case 270:
            defaultCamZoom -= 0.4;
        case 282:
            defaultCamZoom += 0.2;
        case 283:
            defaultCamZoom += 0.2;
        case 286:
            defaultCamZoom -= 0.4;
        case 326:
            defaultCamZoom += 0.4;
        case 350:
            defaultCamZoom -= 0.1;
        case 352:
            defaultCamZoom -= 0.1;
        case 354:
            defaultCamZoom -= 0.1;
        case 356:
            defaultCamZoom -= 0.1;
        case 422:
             defaultCamZoom += 0.2;
        case 454:
            defaultCamZoom -= 0.2;
    }
}
