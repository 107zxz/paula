class ExtendedConversationMenuBase : ConversationMenu
{
	DialogueDescriptor dialogue;

	override int Init(StrifeDialogueNode CurNode, PlayerInfo player, int activereply)
	{
		mCurNode = CurNode;
		mPlayer = player;
		ConversationPauseTic = gametic + 20;
		DontDim = true;
		
// 		SendConversationReply(0, activereply);

		return 100;
	}
	

	//=============================================================================
	//
	// On menu close...
	//
	//=============================================================================

	override void OnDestroy()
	{
// 		SendConversationReply(0, 0);
	
		SetMusicVolume(1);
		dialogue.Destroy();
		Menu.OnDestroy();
	}

	//=============================================================================
	//
	// Handle input events
	//
	//=============================================================================

	override bool OnUIEvent(UIEvent ev)
	{
		// No interaction during demo playback
		if (demoplayback) { return false; }

		if (ev.type == UIEvent.Type_KeyDown && ev.KeyChar == 0x09)
		{	//Tab through elements (Shift+Tab to reverse)...
			dialogue.focus = dialogue.NextControl(ev.IsShift);
			return true;
		}

		for (int c = 0; c < dialogue.controls.Size(); c++)
		{
			if (dialogue.controls[c] && dialogue.controls[c].classname == "DialogueResponses" && dialogue.responseblockcount < 2)
			{
				dialogue.controls[c].OnUIEvent(ev);
			}

			if (dialogue.controls[c] && dialogue.controls[c].refname == dialogue.focus)
			{
				dialogue.controls[c].OnUIEvent(ev);
			}
		}

		return Super.OnUIEvent(ev);
	}

	//=============================================================================
	//
	// Handle key presses
	//
	//=============================================================================

	int GetReplyNumber()
	{
		let reply = mCurNode.Children;
		int replynum = dialogue.selection;
		for (int i = 0; i <= dialogue.selection && reply != null; reply = reply.Next)
		{
			if (reply.ShouldSkipReply(mPlayer))
				replynum++;
			else
				i++;
		}
		return replynum;
	}

	override bool MenuEvent(int mkey, bool fromcontroller)
	{
		// During demo playback, don't let the user do anything besides close this menu.
		if (demoplayback) 
		{ 
			if (mkey == MKEY_Back)
			{
				CloseMenu();
				return true;
			}
			return false;
		}

		if (mkey == MKEY_Back)
		{
			if (mCurNode.UserData != "") {
				SendConversationReply(mCurNode.ThisNodeNum, mCurNode.UserData.ToInt());
			} else {
				if (dialogue.selection > -1) {
					SendConversationReply(-1, 0);
				}
				CloseMenu();
			}
			return true;
		}

		for (int c = 0; c < dialogue.controls.Size(); c++)
		{
			if (!dialogue.controls[c]) { return false; }
			if (dialogue.controls[c].refname == dialogue.focus)
			{
				return dialogue.controls[c].MenuEvent(mkey, fromcontroller);
			}
		}

		return false;
	}

	//=============================================================================
	//
	// Handle mouse clicks
	//
	//=============================================================================

	override bool MouseEvent(int type, int x, int y)
	{
		// Custom equivalent to Clean(X/Y)Fac that more closely matches scaling of other screen elements (fixes a bug at odd screen sizes in the standard mouse handling)
		double widthRatio = screen.GetWidth() / double(dialogue.targetscreenx);
		double heightRatio = screen.GetHeight() / double(dialogue.targetscreeny);
		double screenRatio = widthRatio / heightRatio;

		if (screenRatio > 1.275) { widthRatio = 4 + (widthRatio - 4) / 2; } 

		double xOffset = (screen.GetWidth() - dialogue.targetscreenx * heightRatio) / 2;
		double yOffset = (screen.GetHeight() - dialogue.targetscreeny * widthRatio) / 2;

		if (xOffset < 0) { xOffset = 0; heightRatio = widthRatio; }
		else if (yOffset < 0) { yOffset = 0; widthRatio = heightRatio; }

		x = int((x - xOffset) / widthRatio);
		y = int((y - yOffset) / heightRatio);

		for (int c = 0; c < dialogue.controls.Size(); c++)
		{
			String focusval;
			if (x > dialogue.controls[c].pos.x - dialogue.controls[c].margin.left && x < dialogue.controls[c].pos.x + dialogue.controls[c].w + dialogue.controls[c].margin.right + (2 * dialogue.controls[c].scale) && y > dialogue.controls[c].pos.y - dialogue.controls[c].margin.top && y < dialogue.controls[c].pos.y + dialogue.controls[c].h + dialogue.controls[c].margin.bottom)
			{
				if (type == MOUSE_Release)
				{
					focusval = dialogue.controls[c].Click(x, y);
					if (focusval != "") { dialogue.focus = focusval; }
					return false;
				}
				else if (type == MOUSE_Move)
				{
					focusval = dialogue.controls[c].Drag(x, y);
					if (focusval != "") { dialogue.focus = focusval; }
					return false;
				}
			}
			else if (dialogue.controls[c].dragging)
			{
				if (type == MOUSE_Move)
				{
					focusval = dialogue.controls[c].Drag(x, y);
					if (focusval != "") { dialogue.focus = focusval; }
					return false;
				}
				return false;
			}
		}
		if (type == MOUSE_Release) { dialogue.focus = "_NOFOCUS_"; }
		return true;
	}

	//============================================================================
	//
	// Draw Conversation Menu
	//
	//============================================================================

	override void Drawer()
	{
		if (mCurNode == NULL)
		{
			Close ();
			return;
		}

		mSelection = dialogue.Draw();
	}

	//=============================================================================
	//
	// Format text for speaker message
	//
	//=============================================================================

	String ParseSpeakerMessage()
	{
		// Format the speaker's message.
		String toSay = mCurNode.Dialogue;
		if (toSay.Left(7) == "RANDOM_")
		{
			let dlgtext = String.Format("$TXT_%s_%02d", toSay, random[RandomSpeech](1, NUM_RANDOM_LINES));
			toSay = Stringtable.Localize(dlgtext);
			if (toSay.CharAt(0) == "$") toSay = Stringtable.Localize("$TXT_GOAWAY");
		}
		else
		{
			// handle string table replacement
			toSay = Stringtable.Localize(toSay);
		}
		if (toSay.Length() == 0)
		{
			toSay = ".";
		}
		return toSay;
	}

	String ParseSpeakerName()
	{
		if (mCurNode.SpeakerName.Length() > 0)
		{
			return Stringtable.Localize(mCurNode.SpeakerName);
		}
		else
		{
			return players[consoleplayer].ConversationNPC.GetTag("Person");
		}
		return "";
	}

	//=============================================================================
	//
	// Sets up array of lines for reply values with given width.  Returns height in lines.
	//  Still basically the same as the old code...  
	//
	//=============================================================================

	int ParseReplies(int w, String replyfont = "SmallFont")
	{
		StrifeDialogueReply reply;

		int i = 1;

		Font thisfont = Font.GetFont(replyfont);

		for (reply = mCurNode.Children; reply != NULL; reply = reply.Next)
		{
			if (reply.ShouldSkipReply(mPlayer))
			{
				continue;
			}

			mShowGold |= reply.NeedsGold;

			let ReplyText = Stringtable.Localize(reply.Reply);
			if (reply.NeedsGold) ReplyText.AppendFormat(" for %u", reply.PrintAmount);

			let ReplyLines = thisfont.BreakLines (ReplyText, w);

			mResponses.Push(mResponseLines.Size());
			for (int j = 0; j < ReplyLines.Count(); ++j)
			{
				mResponseLines.Push(ReplyLines.StringAt(j));
			}

			++i;
			ReplyLines.Destroy();
		}

		let goodbyestr = mCurNode.Goodbye;
		if (goodbyestr.Length() == 0)
		{
			goodbyestr = String.Format("$TXT_RANDOMGOODBYE_%d", Random[RandomSpeech](1, NUM_RANDOM_GOODBYES));
		}
		else if (goodbyestr.Left(7) == "RANDOM_")
		{
			goodbyestr = String.Format("$TXT_%s_%02d", goodbyestr, Random[RandomSpeech](1, NUM_RANDOM_LINES));
		}
		goodbyestr = Stringtable.Localize(goodbyestr);
		if (goodbyestr.Length() == 0 || goodbyestr.CharAt(0) == "$") goodbyestr = "Bye.";

// 		mResponses.Push(mResponseLines.Size());
// 		mResponseLines.Push(goodbyestr);

		return mResponseLines.Size();
	}

	virtual void CloseMenu()
	{
// 		SendConversationReply(1, 1);
		Close();
	}
}