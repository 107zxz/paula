class CustomHUD : BaseStatusBar {

	HUDFont mKeybindFont;
	InventoryBarState ibs;
	
	override void init() {
		super.init();
		
		mKeybindFont = HUDFont.create(smallfont);
		ibs = InventoryBarState.create();
	}

	override void draw(int state, double ticfrac) {
		BeginHUD(1.0, true);
		
		if (isInventoryBarVisible()) {
			DrawInventoryBar(ibs, (0, 0), 7, DI_SCREEN_CENTER_BOTTOM, HX_SHADOW);
			DrawString(mKeybindFont, GetSelectedInventoryTag(), (0, -40), DI_SCREEN_CENTER_BOTTOM | DI_TEXT_ALIGN_CENTER);
		} else if (CPlayer.mo.InvSel != null)
			{
				DrawInventoryIcon(CPlayer.mo.InvSel, (0, -16), DI_SCREEN_CENTER_BOTTOM, boxsize:(28, 28));
				DrawString(mKeybindFont, GetSelectedInventoryTag(), (0, -12), DI_SCREEN_CENTER_BOTTOM | DI_TEXT_ALIGN_CENTER);
				if (CPlayer.mo.InvSel.Amount > 1)
				{
					DrawString(mKeybindFont, FormatNumber(CPlayer.mo.InvSel.Amount, 3), (0, -28), DI_SCREEN_CENTER_BOTTOM | DI_TEXT_ALIGN_CENTER);
				}
			}
	}
}