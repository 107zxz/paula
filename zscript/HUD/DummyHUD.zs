class DummyHUD : OptionMenu {

	override bool MenuEvent(int mkey, bool fromcontroller) {
	
		if (mkey == MKEY_Back)
			return false;
		
		return super.MenuEvent(mkey, fromcontroller);
	}
}