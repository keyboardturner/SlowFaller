local _, L = ...

local defaultsTable = {
	Levitate = true,
	Slowfall = true,
	Flap = true,
	Flightform = true,
	Zenflight = true,
	Gliders = false,
	Custom = false,
};

local SlowFallerPanel = CreateFrame("Frame")
SlowFallerPanel:RegisterEvent("ADDON_LOADED")

function SlowFallerPanel:InitializeOptions(event, arg1)
	if event == "ADDON_LOADED" and arg1 == "SlowFaller" then
		if not SlowFaller_DB then
			SlowFaller_DB = defaultsTable
		end

		SlowFallerPanel.name = L["Name"]
		local category, layout = Settings.RegisterCanvasLayoutCategory(SlowFallerPanel, SlowFallerPanel.name, SlowFallerPanel.name);
		category.ID = SlowFallerPanel.name;
		Settings.RegisterAddOnCategory(category)

		-- Create the scrolling parent frame and size it to fit inside the texture
		SlowFallerPanel.scrollFrame = CreateFrame("ScrollFrame", nil, SlowFallerPanel, "UIPanelScrollFrameTemplate")
		SlowFallerPanel.scrollFrame:SetPoint("TOPLEFT", 3, -4)
		SlowFallerPanel.scrollFrame:SetPoint("BOTTOMRIGHT", -27, 4)

		-- Create the scrolling child frame, set its width to fit, and give it an arbitrary minimum height (such as 1)
		SlowFallerPanel.scrollChild = CreateFrame("Frame")
		SlowFallerPanel.scrollFrame:SetScrollChild(SlowFallerPanel.scrollChild)
		SlowFallerPanel.scrollChild:SetWidth(SettingsPanel.Container:GetWidth()-18)
		SlowFallerPanel.scrollChild:SetHeight(1) 

		-- Add widgets to the scrolling child frame as desired
		SlowFallerPanel.title = SlowFallerPanel.scrollChild:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
		SlowFallerPanel.title:SetPoint("TOPLEFT", 10, -15)
		SlowFallerPanel.title:SetText(L["Name"])

		SlowFallerPanel.CheckBox_Priest = CreateFrame("CheckButton", "SF_PriestLeviOptionsCheckbox", SlowFallerPanel.scrollChild, "UICheckButtonTemplate");
		SlowFallerPanel.CheckBox_Priest:ClearAllPoints();
		SlowFallerPanel.CheckBox_Priest:SetPoint("TOPLEFT", 50, -53);
		getglobal(SlowFallerPanel.CheckBox_Priest:GetName().."Text"):SetText(L["Levitate"]);

		SlowFallerPanel.CheckBox_Priest:SetScript("OnClick", function(self)
			if SlowFallerPanel.CheckBox_Priest:GetChecked() then
				SlowFaller_DB.Levitate = true;
			else
				SlowFaller_DB.Levitate = false;
			end
		end);

		SlowFallerPanel.CheckBox_Mage = CreateFrame("CheckButton", "SF_MageSlowfallOptionsCheckbox", SlowFallerPanel.scrollChild, "UICheckButtonTemplate");
		SlowFallerPanel.CheckBox_Mage:ClearAllPoints();
		SlowFallerPanel.CheckBox_Mage:SetPoint("TOPLEFT", 50, -53*1.5);
		getglobal(SlowFallerPanel.CheckBox_Mage:GetName().."Text"):SetText(L["Slow Fall"]);

		SlowFallerPanel.CheckBox_Mage:SetScript("OnClick", function(self)
			if SlowFallerPanel.CheckBox_Mage:GetChecked() then
				SlowFaller_DB.Slowfall = true;
			else
				SlowFaller_DB.Slowfall = false;
			end
		end);

		SlowFallerPanel.CheckBox_Druid = CreateFrame("CheckButton", "SF_DruidFlapOptionsCheckbox", SlowFallerPanel.scrollChild, "UICheckButtonTemplate");
		SlowFallerPanel.CheckBox_Druid:ClearAllPoints();
		SlowFallerPanel.CheckBox_Druid:SetPoint("TOPLEFT", 50, -53*2);
		getglobal(SlowFallerPanel.CheckBox_Druid:GetName().."Text"):SetText(L["Flap"]);

		SlowFallerPanel.CheckBox_Druid:SetScript("OnClick", function(self)
			if SlowFallerPanel.CheckBox_Druid:GetChecked() then
				SlowFaller_DB.Flap = true;
			else
				SlowFaller_DB.Flap = false;
			end
		end);

		SlowFallerPanel.CheckBox_Priest:SetChecked(SlowFaller_DB.Levitate)
		SlowFallerPanel.CheckBox_Mage:SetChecked(SlowFaller_DB.Slowfall)
		SlowFallerPanel.CheckBox_Druid:SetChecked(SlowFaller_DB.Flap)

		--[[
		SlowFallerPanel.footer = SlowFallerPanel.scrollChild:CreateFontString("ARTWORK", nil, "GameFontNormal")
		SlowFallerPanel.footer:SetPoint("TOP", 0, -5000)
		SlowFallerPanel.footer:SetText("This is 5000 below the top, so the scrollChild automatically expanded.")
		]]

	end
end


SlowFallerPanel:SetScript("OnEvent", SlowFallerPanel.InitializeOptions)


local f = CreateFrame("Frame");
f:RegisterEvent("PLAYER_ENTERING_WORLD");
f.havewemet = false

f.spellID = 130
f.buffID = 130
f.priest = select(2, UnitClassBase("player")) == 5
f.mage = select(2, UnitClassBase("player")) == 8
f.monk = select(2, UnitClassBase("player")) == 10
f.druid = select(2, UnitClassBase("player")) == 11

if f.priest then -- priest
	f.spellID = 1706 -- levitate spell
	f.buffID = 111759 -- levitate buff
elseif f.mage then -- mage
	f.spellID = 130 -- slow fall spell
	f.buffID = 130 -- slow fall buff
--[[
elseif f.monk then -- monk (needs more work for the cancel action, will look at it later)
	f.spellID = 125883 -- zen flight spell
	f.buffID = 125883 -- zen flight buff
	]]
elseif f.druid then -- druid
	f.spellID = 164862 -- flap spell
	f.buffID = 164862 -- flap buff
else
	f:SetScript("OnEvent", function()
		if f.havewemet == false then
			DEFAULT_CHAT_FRAME:AddMessage(L["Oh no!"])
			f.havewemet = true
		end
		--"Hello friend! This message is here to let you know that the SlowFaller addon is enabled on a class without a slow fall ability, and therefore will not be running any code.\nRequires: " .. SpellNames.spells
	end)
	return
end
f:SetScript("OnEvent", function()
	if f.havewemet == false then
		DEFAULT_CHAT_FRAME:AddMessage(L["Hello!"])
		f.havewemet = true
	end
	--"Hello friend! The SlowFaller addon is now enabled on a class with a slow fall ability.\nDouble-jump to activate: " .. SpellNames.spells .. "\nDoes not work in combat or while mounted."
end)

local INVALID_SPELL = {
	302677, -- Anti-Gravity Pack
	303841, -- Anti-Gravity Pack
	313053, -- Faerie's Blessing
	323695, -- Faerie Dust
	356280, -- Dragon Companion's Vigilance
	383363, -- Lift Off
	--1459, -- Arcane Intellect test
};

local SlowFallEvent = CreateFrame("Frame")

--SlowFallEvent:RegisterEvent("ADDON_LOADED");
SlowFallEvent:RegisterEvent("PLAYER_ENTERING_WORLD");
SlowFallEvent:RegisterEvent("PLAYER_REGEN_DISABLED");

function SlowFallEvent:OnEvent(event,arg1)

	if event ~= "PLAYER_ENTERING_WORLD" then
		if UnitAffectingCombat("player") == true then
			return
		else
			ClearOverrideBindings(SlowFallEvent);
		end
	end

	if event == "PLAYER_REGEN_DISABLED" then
		ClearOverrideBindings(SlowFallEvent);
	end

	if event == "PLAYER_ENTERING_WORLD" then
		SlowFallEvent:RegisterEvent("PLAYER_LOGOUT");
		SlowFallEvent:RegisterEvent("PLAYER_MOUNT_DISPLAY_CHANGED");

		local spell = Spell:CreateFromSpellID(f.spellID);
		local buff = Spell:CreateFromSpellID(f.buffID);
		local key1, key2 = GetBindingKey("JUMP");
		--local badBuff = C_UnitAuras.GetPlayerAuraBySpellID(INVALID_SPELL[f.spellID]);

		function SlowFallEvent.Jumpy(self, key)
			--print(key) -- debug to find what key is pressed
			if UnitAffectingCombat("player") == true then
				return
			elseif IsMounted() or select(1, C_Spell.IsSpellUsable(f.spellID)) == false  then --or (not badBuff) or (not C_UnitAuras.GetPlayerAuraBySpellID(INVALID_SPELL[k]))
				ClearOverrideBindings(SlowFallEvent);
				return
			else
				key1, key2 = GetBindingKey("JUMP");
				local aura = C_UnitAuras.GetPlayerAuraBySpellID(f.spellID) or C_UnitAuras.GetPlayerAuraBySpellID(f.buffID);
				if key == ( key1 or key2 ) then
					for k,v in pairs(INVALID_SPELL) do
						if C_UnitAuras.GetPlayerAuraBySpellID(INVALID_SPELL[k]) then
							return
						end
					end
					if IsFalling() == true then

						if f.priest and SlowFaller_DB.Levitate == false then
							return
						end
						if f.mage and SlowFaller_DB.Slowfall == false then
							return
						end
						if f.druid and SlowFaller_DB.Flap == false then
							return
						end

						if aura then
							CancelSpellByName(spell:GetSpellName());
							ClearOverrideBindings(SlowFallEvent);
							return
						else
							SetOverrideBinding(SlowFallEvent, true, key1, "SPELL " .. spell:GetSpellName());
						end
					end
					if IsFalling() == false then
						ClearOverrideBindings(SlowFallEvent);
					end
				end
			end
		end

		SlowFallEvent:SetScript("OnKeyDown", SlowFallEvent.Jumpy);
		SlowFallEvent:SetPropagateKeyboardInput(true);
	end
end
SlowFallEvent:SetScript("OnEvent",SlowFallEvent.OnEvent);
