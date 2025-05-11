class ClueEventHandler : EventHandler {
	override void WorldLoaded(WorldEvent e)
	{
		if(players[consoleplayer].mo is "PaulaPlayer") {
			players[consoleplayer].mo.giveInventory("Notebook",1);
			
			PaulaPlayer(players[consoleplayer].mo).LevelLoaded();
			
			Menu.SetMenu("Dummy");
		}
	}
}


