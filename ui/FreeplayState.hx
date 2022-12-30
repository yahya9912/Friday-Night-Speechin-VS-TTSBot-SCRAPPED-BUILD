//a
import LoadingState;
import CoolUtil;
import Settings;
function onSelect(song:SongMetadata) {
    trace(song.songName);
    switch(song.songName) {
        case 'poker-night':
            Settings.engineSettings.data.lastSelectedSong = _songs[curSelected].mod + ":" +_songs[curSelected].songName.toLowerCase();
            Settings.engineSettings.data.lastSelectedSongDifficulty = curDifficulty;
            CoolUtil.loadSong(_songs[curSelected].mod, _songs[curSelected].songName.toLowerCase(), _songs[curSelected].difficulties[curDifficulty], _songs[curSelected].difficulties);
            openSubState(new ModSubState("PickACharacter", mod));
            return false;
    }
}