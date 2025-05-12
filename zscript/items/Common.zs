class Evidence : Inventory {
	void EvidencePickup() {
	
		string pickupMsg = self.PickupMessage();
		
		if (players[consoleplayer].mo.FindInventory("Notebook") && !(self is "Notebook"))
			pickupMsg = pickupMsg .. "\n\cj[added to notebook]";
	
		// Evidence pickup message
		if (self.PickupMessage().Left(1) != "$")
			A_PrintBold("\ca" .. pickupMsg);
		
		// Open the notebook to the new piece of evidence
		int firstPage = Wads.FindLump("page0000", 0, Wads.AnyNamespace);
		int lastPage = Wads.FindLump("page4000", 0, Wads.AnyNamespace) - firstPage - 1;
		for (int i = 0; i < lastPage; i++) {
			string lumpName = Wads.GetLumpFullName(firstPage+i+1);
			string inventoryName = lumpName.Mid(17);
			
			inventoryName.StripRight(".txt");
			
			if (self is inventoryName) {
				CVar.FindCVar("cl_notebookpage").SetInt(i);
			}
		}
	}

	override bool TryPickup(in out Actor toucher) {
		if (super.TryPickup(toucher)) {
			EvidencePickup();
			return true;
		}
	
		return false;
	}
	
	override bool Use(bool pickup) {
		EvidencePickup();
		return false;
	}
}
