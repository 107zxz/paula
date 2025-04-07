class Notebook : Inventory {
	Default {
		Inventory.MaxAmount 1;
	}
	
	override bool Use(bool pickup) {
// 		StartConversation(owner, false, false);

		Menu.SetMenu("Notebook");

		return false;
	}
	
	States {
	Spawn:
		NOTE A -1;
		stop;
	}
}

class PaulaPuzzleItem : PuzzleItem {
	Default
	{
// 		PuzzleItem.Number 17;
		Inventory.PickupMessage "A dummy puzzle item"; // This is an example. It's recommended to use LANGUAGE for player-facing strings.
		Inventory.DefMaxAmount;
		Inventory.Icon "PLAYA0";
	}
	States
	{
	Spawn: 
		PLAY A -1;
		stop;
	}
	
	override void Touch(Actor toucher) {
		PrintPickupMessage(true, self.PickupMessage ());
		super.Touch(toucher);
	}
}