class VentPlayer : DoomPlayer {
	Default {
		Speed 0.5;
		Height 32;
		Player.ViewHeight 24;
		
		Player.JumpZ 0;
	}

	override void Tick() {
		super.Tick();

		if (player.camera != player.mo) {
			player.camera.Destroy();
			player.camera = player.mo;
		}
	}
}