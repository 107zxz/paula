// TODO: Maybe program the notebook visuals here

class CustomHUD : BaseStatusBar {
	HUDFont mHudFont;

	override void Init() {
		Super.Init();
		SetSize(32, 320, 200);
	
		Font fnt = "SMALLFONT";
		mHUDFont = HUDFont.Create(fnt, fnt.GetCharWidth("0"), Mono_CellLeft, 1, 1);
	}

	override void Draw(int state, double ticFrac) {
		Super.Draw(state, ticFrac);
		
		if (GetAmount("Notebook") != 0) {
			DrawImage("NOTEA0", (0,168), DI_ITEM_OFFSETS);
			DrawString(mHUDFont, "N", (0, 148), DI_TEXT_ALIGN_CENTER);
		}
	}
}