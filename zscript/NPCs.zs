class Archibald : Actor {

	Default {
		+SOLID;
		+USESPECIAL;
		Radius 20;
		Height 56;
	}

	States {
	Spawn:
		VILE AB 10;
		Loop;
	}
}

class Barry : Actor {

	Default {
		+SOLID;
		+USESPECIAL;
		Radius 24;
		Height 64;
	}
	
	States {
	Spawn:
		BOSS AB 10;
		Loop;
	}
}

class SgtChekov : Actor {
	Default {
		Radius 20;
		Height 56;
		+SOLID;
		+USESPECIAL;
	}
	
	States {
	Spawn:
		SPOS AB 10;
		Loop;
	}
}

class SpingBonny : Actor {
	Default {
		Radius 20;
		Height 56;
		+SOLID;
		+USESPECIAL;
	}
	
	States {
	Spawn:
		BONY A -1;
		Stop;
	}
}

class BabySoul : Actor {
	Default {
		Radius 8;
		Height 56;
		Scale 0.75;
		+NOGRAVITY;
		+SOLID;
		+USESPECIAL;
	}
	
	States {
	Spawn:
		SKUL AB 10 BRIGHT;
		Loop;
	}
}
