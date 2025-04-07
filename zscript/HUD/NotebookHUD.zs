class NotebookHUD : OptionMenu {

	int currentPage;

	override void Drawer() {
	
		string ownedPages = CVar.GetCVar("cl_notebookcollectedpages").GetString();
	
		string texName = String.Format("Z_NOTE%s", ownedPages.Mid(currentPage, 1));
		
		Screen.DrawText(smallfont, Font.CR_BRICK, 0, 0, currentPage.."\n"..texName);
	
		Screen.DrawTexture(
			TexMan.CheckForTexture(
				texName
			),
			false, 0, 0,
			DTA_Fullscreen, true,
			DTA_FullScreenScale, FSMode_ScaletoFit43
		);
	}
	
	override bool MenuEvent(int mkey, bool fromcontroller) {
		if (mkey == MKEY_Right) {
			currentPage = nextPage(currentPage);
			return true;
		}
		if (mkey == MKEY_Left) {
			currentPage = prevPage(currentPage);
			return true;
		}
		
		return false;
	}
	
// 	override bool MenuEvent(int mkey, bool fromcontroller) {
// 		CVar b = CVar.GetCVar("cl_notebookpage");
		
// 		if (mkey == MKEY_Right) {
// 			b.SetInt(
// 				nextPage(b.GetInt())
// 			);
// 			return true;
// 		}
// 		if (mkey == MKEY_Left) {
// 			b.SetInt(
// 				prevPage(b.GetInt())
// 			);
// 			return true;
// 		}
		
// 		return Super.MenuEvent(mkey, fromcontroller);
// 	}
	
	int nextPage(int currentPage) {
	
// 		int availablePages = CVar.GetCVar("cl_notebookcollectedpages").GetInt();
	
// 		for (int i = currentPage + 1; i < numPages; i++) {
// 			if (availablePages & (1 << i)) {return i;}
// 		}
// 		for (int i = 0; i < currentPage; i++) {
// 			if (availablePages & (1 << i)) {return i;}
// 		}
		
// 		return currentPage;

// 		string available = CVar.GetCVar("cl_notebookcollectedpages").GetString();

// 		for (

		return min(
			currentPage + 1,
			CVar.GetCVar("cl_notebookcollectedpages").GetString().Length() - 1
		);
	}
	
	int prevPage(int currentPage) {
		
		
		
// 		int availablePages = CVar.GetCVar("cl_notebookcollectedpages").GetInt();
	
// 		for (int i = currentPage - 1; i >= 0; i--) {
// 			if (availablePages & (1 << i)) {return i;}
// 		}
// 		for (int i = numPages - 1; i > currentPage; i--) {
// 			if (availablePages & (1 << i)) {return i;}
// 		}
		
		return max(0, currentPage - 1);
	}
}