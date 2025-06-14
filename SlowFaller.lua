local addonName, L = ...;

local SETTINGS = SlowFaller.Settings;
local CLASSES = SlowFaller.CLASSES;
local PLAYER_CLASS = SlowFaller.PLAYER_CLASS;
local DracthyrA = select(3, UnitRace("player")) == 52
local DracthyrH = select(3, UnitRace("player")) == 70
local SKIPPED_DOUBLE_JUMP = false;
local IN_COMBAT = InCombatLockdown();
local JUMPKEY1, JUMPKEY2;

local function IsJumpKey(key)
	return key == JUMPKEY1 or key == JUMPKEY2;
end

local EventFrame = CreateFrame("Frame");

function EventFrame:OnEvent(event, ...)
	if self[event] then
		self[event](self, ...);
	end
end

function EventFrame:OnKeyDown(key)
	local isGliding, canGlide, forwardSpeed = C_PlayerInfo.GetGlidingInfo();
	if not IsJumpKey(key) or IN_COMBAT then
		if not IN_COMBAT then
			ClearOverrideBindings(self);
		end
		return;
	end

	if not SETTINGS.ShouldHandleJumpCommand() then
		ClearOverrideBindings(self);
		return;
	end

	if IsFalling() then
		if PLAYER_CLASS == CLASSES.DEMONHUNTER and not SKIPPED_DOUBLE_JUMP then
			-- skip the first 'falling' jump input to allow for double jumping on demon hunters
			SKIPPED_DOUBLE_JUMP = true;
			return;
		end

		if canGlide then
			return;
		end

		local spellID = SETTINGS.GetOverrideSpellID();
		if not spellID then
			return;
		end
		local spellName = C_Spell.GetSpellName(spellID);
		local spellAura = C_UnitAuras.GetAuraDataBySpellName("player", spellName);
		local shouldCancel = SETTINGS.ShouldCancelAura();
		local dracthyr = SETTINGS.ShouldDracthyrAura();

		if not dracthyr and (DracthyrA or DracthyrH) then
			return;
		end

		if spellAura and shouldCancel then
			local canCancel = C_UnitAuras.IsAuraFilteredOutByInstanceID("player", spellAura.auraInstanceID, "CANCELABLE");
			if canCancel then
				CancelSpellByName(spellName);
				ClearOverrideBindings(self);
				return;
			end
		end

		local override = SETTINGS.GetOverrideCommand();
		if override then
			local isPriority = true;
			SetOverrideBinding(self, isPriority, key, override);
		end
	else
		ClearOverrideBindings(self);
		SKIPPED_DOUBLE_JUMP = false;
	end
end

function EventFrame:UPDATE_BINDINGS()
	JUMPKEY1, JUMPKEY2 = GetBindingKey("JUMP");
end

function EventFrame:PLAYER_REGEN_ENABLED()
	IN_COMBAT = false;
end

function EventFrame:PLAYER_REGEN_DISABLED()
	IN_COMBAT = true;
	ClearOverrideBindings(self);
end

EventFrame:SetScript("OnEvent", EventFrame.OnEvent);
EventFrame:SetScript("OnKeyDown", EventFrame.OnKeyDown);
EventFrame:SetPropagateKeyboardInput(true);
EventFrame:RegisterEvent("UPDATE_BINDINGS");
EventFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
EventFrame:RegisterEvent("PLAYER_REGEN_DISABLED");