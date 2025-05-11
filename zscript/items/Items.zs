class Notebook : Evidence {
	Default {
		Inventory.PickupMessage "A notebook. I'll use this to keep track of my findings.";
		+Inventory.INVBAR
	}
	
	override bool Use(bool pickup) {

		Menu.SetMenu("Notebook");

		return false;
	}

	States {
	Spawn:
		NOTE A -1;
		stop;
	}
}

class Bottle : Evidence {
	Default {	
		Inventory.PickupMessage "A bottle of mysterious clear fluid";
		+Inventory.INVBAR
	}
	
	override bool Use(bool pickup) {
		owner.DamageMobj(owner, null, 40, 'Normal');
		
		owner.GiveInventory("Poison", 1);
		owner.TakeInventory("Bottle", 1);
		
		return false;
	}
	
	override bool TryPickup(in out Actor toucher) {
		return toucher.FindInventory("Poison") == null && super.TryPickup(toucher);
	}
	
	States {
	Spawn:
		BON1 A -1;
		stop;
	}
}

class Poison : Evidence {
	Default {	
		Inventory.PickupMessage "Yep, definitely poison";
		+Inventory.INVBAR
	}

	States {
	Spawn:
		BON1 A -1;
		stop;
	}
}