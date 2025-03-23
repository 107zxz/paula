

class ClueEventHandler : EventHandler {
	override void WorldLoaded(WorldEvent e)
	{
		if(players[consoleplayer].mo is "PaulaPlayer") {
// 			players[consoleplayer].mo.giveInventory("Notebook",1);
			
			PaulaPlayer(players[consoleplayer].mo).LevelLoaded();
		}
	}
	
	
}


class Notebook : Inventory {
	Default {
		Inventory.MaxAmount 1;
	}

	override bool HandlePickup(Inventory item) {
		A_Log("\cr"..StringTable.Localize(item.PickupMessage()));
		
		return Super.HandlePickup(item);
	}
	
	override bool Use(bool pickup) {
		StartConversation(owner, false, false);
		return false;
	}
	
	States {
	Spawn:
		NOTE A -1;
		stop;
	}
}