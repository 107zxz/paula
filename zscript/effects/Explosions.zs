class FuseBoxBoom : Rocket {
	States
	{
	Spawn:
	Death:
		MISL B 8 Bright A_Explode;
		MISL C 6 Bright;
		MISL D 4 Bright;
		Stop;
	}
}