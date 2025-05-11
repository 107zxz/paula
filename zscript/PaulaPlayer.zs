class PaulaPlayer : DoomPlayer {

	PointLight playerLight;

	Default {
		Player.DisplayName "ThirdPerson";
		Player.ViewBob 1;
		Player.ViewHeight 50;
		Player.JumpZ 0;
		
		Speed 4;
	}
	
	// Called by an EventHandler on level start, not sure if there's a way to
	// do this inside the class
	void LevelLoaded() {
	
		if (player.camera == player.mo) {
			player.camera = SpectatorCamera(Actor.Spawn("SpectatorCamera", Pos));
			player.camera.tracer = player.mo;
			player.camera.player = player;
			
			SpectatorCamera(player.camera).Init(128, 90, 10, VPSF_ABSOLUTEOFFSET);
		}
	}
	
	override void FireWeapon(State stat) {
	
	}
	
	override void MovePlayer() {
		let player = self.player;
		UserCmd cmd = player.cmd;
		
		vel.x *= 0.25;
		vel.y *= 0.25;

		player.onground = (pos.z <= floorz) || bOnMobj || bMBFBouncer || (player.cheats & CF_NOCLIP2);

		if (cmd.forwardmove | cmd.sidemove)
		{
			double forwardmove, sidemove;
			double friction, movefactor;
			double fm, sm;

			[friction, movefactor] = GetFriction();

			fm = cmd.forwardmove;
			sm = cmd.sidemove;
			[fm, sm] = TweakSpeeds (fm, sm);
			fm *= Speed / 256;
			sm *= Speed / 256;
			
			// When crouching, speed and bobbing have to be reduced
			if (CanCrouch() && player.crouchfactor != 1)
			{
				fm *= player.crouchfactor;
				sm *= player.crouchfactor;
			}
			
			forwardmove = fm * movefactor * (35 / TICRATE);
			sidemove = sm * movefactor * (35 / TICRATE);

			if (forwardmove)
			{
				if (sidemove) forwardmove /= 1.48;
				ForwardThrust(forwardmove, 90);
			}
			if (sidemove)
			{
				if (forwardmove) sidemove /= 1.48;
				Thrust(sidemove, 0);
			}
			
			if (!(player.cheats & CF_PREDICTING) && (forwardmove != 0 || sidemove != 0))
			{
				PlayRunning ();
			}
			
			A_FaceMovementDirection ();
		} else {
			PlayIdle ();
		}
	}
}