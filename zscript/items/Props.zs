class ChekovsGun : Actor {
	Default {
		+SOLID;
		+USESPECIAL;
		Radius 24;
		Height 64;
	}

	States {
	Spawn:
		SHOT A -1;
		Stop;
	}
}