class NPC : Actor {
	Default {
		+SOLID;
		+USESPECIAL;
	}
}

class Archibald : NPC {

	Default {
		Radius 20;
		Height 56;
	}

	States {
	Spawn:
		VILE AB 10;
		Loop;
	}
}

class Barry : NPC {

	Default {
		Radius 24;
		Height 64;
	}
	
	States {
	Spawn:
		BOSS AB 10;
		Loop;
	}
}

class SgtChekov : NPC {
	Default {
		Radius 20;
		Height 56;
	}
	
	States {
	Spawn:
		SPOS AB 10;
		Loop;
	}
}

class SpingBonny : NPC {
	Default {
		Radius 20;
		Height 56;
	}
	
	States {
	Spawn:
		BONY A -1;
		Stop;
	}
}

class BabySoul : NPC {
	Default {
		Radius 8;
		Height 56;
		Scale 0.75;
		+NOGRAVITY;
	}
	
	States {
	Spawn:
		SKUL AB 10 BRIGHT;
		Loop;
	}
}

class DetectiveBones : NPC {
	Default {
		Radius 16;
		Height 56;
	}
	
	States {
	Spawn:
		SKEL AB 10;
		Loop;
	}
}