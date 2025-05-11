class NotebookHUD : OptionMenu {

	int currentSection;
	
	CVar currentPage;
	
	string debug;

	override void Drawer() {
		if (!currentPage)
			currentPage = CVar.FindCVar("cl_notebookpage");

		int pageLump = Wads.FindLump("page0000", 0, Wads.AnyNamespace) + currentPage.GetInt()+1;
		string lumpName = Wads.GetLumpFullName(pageLump);

		string pageText = Wads.ReadLump(pageLump);
		string texName = String.Format("Z_NOTE%s", pageText.Left(1));
		pageText.Remove(0, 2);
		
		Screen.DrawTexture(
			TexMan.CheckForTexture(
				texName
			),
			false, 0, 0,
			DTA_Fullscreen, true,
			DTA_FullScreenScale, FSMode_ScaletoFit43
		);
		
		Screen.DrawText(
			smallfont, Font.CR_BRICK, 92, 12, pageText,
			DTA_320x200, true,
			DTA_Spacing, smallfont.GetCharWidth("0"),
			DTA_Monospace, Mono_CellCenter
		);
		
		Screen.DrawText(
			smallfont, Font.CR_BRICK, 10, 10, debug,
			DTA_320x200, true
		);
	}
	
	override bool MenuEvent(int mkey, bool fromcontroller) {
		if (mkey == MKEY_Right) {
			currentPage.SetInt(nextPage());
			return true;
		}
		if (mkey == MKEY_Left) {
			currentPage.SetInt(prevPage());
			return true;
		}
		
		if (mkey == MKEY_Up) {
			currentPage.SetInt(prevSection());
		}
		if (mkey == MKEY_Down) {
			currentPage.SetInt(nextSection());
		}
		
		return Super.MenuEvent(mkey, fromcontroller);
	}
	
	int nextPage() {
		int firstPage = Wads.FindLump("page0000", 0, Wads.AnyNamespace);
		int lastPage = Wads.FindLump("page4000", 0, Wads.AnyNamespace) - firstPage - 1;
	
		// Get the next valid page
		for (int i = currentPage.GetInt() + 1; i < lastPage; i++) {
			string lumpName = Wads.GetLumpFullName(firstPage+i+1);
			string inventoryName = lumpName.Mid(17);
			
			inventoryName.StripRight(".txt");
			
			if (lumpName.IndexOf("000") != -1 || players[consoleplayer].mo.FindInventory(inventoryName))
				return i;
		}
	
		return currentPage.GetInt();
	}
	
	int prevPage() {
		int firstPage = Wads.FindLump("page0000", 0, Wads.AnyNamespace);
		int lastPage = Wads.FindLump("page4000", 0, Wads.AnyNamespace) - firstPage - 1;
	
		// Get the next valid page
		for (int i = currentPage.GetInt() - 1; i >= 0; i--) {
			string lumpName = Wads.GetLumpFullName(firstPage+i+1);
			string inventoryName = lumpName.Mid(17);
			
			inventoryName.StripRight(".txt");
			
			if (lumpName.IndexOf("000") != -1 || players[consoleplayer].mo.FindInventory(inventoryName))
				return i;
		}
	
		return currentPage.GetInt();
	}
	
	int prevSection() {
		int page0Lump = Wads.FindLump("page0000", 0, Wads.AnyNamespace);
	
		int pageLump = page0Lump + currentPage.GetInt();
		string lumpName = "page" .. Wads.GetLumpName(pageLump).Mid(4, 1).ToInt() .. "000";

		return max(0, Wads.FindLump(lumpName, 0, Wads.AnyNamespace) - page0Lump - 1);
	}
	
	int nextSection() {
		int page0Lump = Wads.FindLump("page0000", 0, Wads.AnyNamespace);
	
		int pageLump = page0Lump + currentPage.GetInt() + 1;
		string lumpName = "page" .. (Wads.GetLumpName(pageLump).Mid(4, 1).ToInt() + 1) .. "000";

		return min(
			Wads.FindLump("page3000", 0, Wads.AnyNamespace) - Wads.FindLump("page0000", 0, Wads.AnyNamespace) - 1,
			Wads.FindLump(lumpName, 0, Wads.AnyNamespace) - page0Lump - 1
		);
	}
	
	int getCurrentSectionHeader() {
		int page0Lump = Wads.FindLump("page0000", 0, Wads.AnyNamespace);
	
		int pageLump = page0Lump + currentPage.GetInt() + 1;
		string lumpName = "page" .. Wads.GetLumpName(pageLump).Mid(4, 1).ToInt() .. "000";
		
		return Wads.FindLump(lumpName, 0, Wads.AnyNamespace);
	}
	
	int getNextSectionHeader() {
		int page0Lump = Wads.FindLump("page0000", 0, Wads.AnyNamespace);
	
		int pageLump = page0Lump + currentPage.GetInt() + 1;
		string lumpName = "page" .. (Wads.GetLumpName(pageLump).Mid(4, 1).ToInt() + 1) .. "000";
		
		return Wads.FindLump(lumpName, 0, Wads.AnyNamespace);
	}
	
	int getPreviousSectionHeader() {
		int page0Lump = Wads.FindLump("page0000", 0, Wads.AnyNamespace);
	
		int pageLump = page0Lump + currentPage.GetInt() + 1;
		string lumpName = "page" .. (Wads.GetLumpName(pageLump).Mid(4, 1).ToInt() - 1) .. "000";
		
		return Wads.FindLump(lumpName, 0, Wads.AnyNamespace);
	}
}