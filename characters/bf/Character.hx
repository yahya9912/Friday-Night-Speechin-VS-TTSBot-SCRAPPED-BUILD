function create() {
	character.frames = Paths.getCharacter(character.curCharacter);
	var tex = Paths.getCharacter('Friday Night Funkin\':bf');
   character.frames = tex;
	character.loadJSON(true); // Setting to true will override getColors() and dance().
}