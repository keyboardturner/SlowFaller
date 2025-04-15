local addonName, L = ...;

SlowFaller = {};

local QUESTION_MARK_ICON = 134400;

local PLAYER_CLASS_NAME, PLAYER_CLASS = UnitClassBase("player");
SlowFaller.PLAYER_CLASS = PLAYER_CLASS;

-- these spells already override double jump, so if they're present, do nothing
local BAD_SPELLS = {
	302677, -- Anti-Gravity Pack
	303841, -- Anti-Gravity Pack
	313053, -- Faerie's Blessing
	323695, -- Faerie Dust
	356280, -- Dragon Companion's Vigilance
	383363, -- Lift Off
	448876, -- Fungal Footpads (delve double jump)
	--1459, -- Arcane Intellect test
};
SlowFaller.BAD_SPELLS = BAD_SPELLS;

local CLASSES = {
    WARRIOR = 1,
    PALADIN = 2,
    HUNTER = 3,
    ROGUE = 4,
    PRIEST = 5,
    DEATHKNIGHT = 6,
    SHAMAN = 7,
    MAGE = 8,
    WARLOCK = 9,
    MONK = 10,
    DRUID = 11,
    DEMONHUNTER = 12,
    EVOKER = 13
};
SlowFaller.CLASSES = CLASSES;

local DefaultSettingsPerClass = {
    [CLASSES.WARRIOR] = {
        SpellID = nil,
        Enable = true,
    },
    [CLASSES.PALADIN] = {
        SpellID = nil,
        Enable = true,
    },
    [CLASSES.HUNTER] = {
        SpellID = nil,
        Enable = true,
    },
    [CLASSES.ROGUE] = {
        SpellID = nil,
        Enable = true,
    },
    [CLASSES.PRIEST] = {
        SpellID = 1706, -- levitate spell
        Enable = true,
    },
    [CLASSES.DEATHKNIGHT] = {
        SpellID = nil,
        Enable = true,
    },
    [CLASSES.SHAMAN] = {
        SpellID = nil,
        Enable = true,
    },
    [CLASSES.MAGE] = {
        SpellID = 130, -- slow fall spell
        Enable = true,
    },
    [CLASSES.WARLOCK] = {
        SpellID = nil,
        Enable = true,
    },
    [CLASSES.MONK] = {
        SpellID = nil,
        Enable = true,
    },
    [CLASSES.DRUID] = {
        SpellID = 164862, -- flap spell
        Enable = true,
    },
    [CLASSES.DEMONHUNTER] = {
        SpellID = 131347,
        Enable = true,
    },
    [CLASSES.EVOKER] = {
        SpellID = nil,
        Enable = true,
    },
};

if not SlowFaller_DB then
    SlowFaller_DB = CopyTable(DefaultSettingsPerClass);
elseif SlowFaller_DB.Levitate ~= nil then
    -- migrate settings from the old version
    local newSettings = CopyTable(DefaultSettingsPerClass);
    newSettings[CLASSES.PRIEST].Enable = SlowFaller_DB.Levitate;
    newSettings[CLASSES.MAGE].Enable = SlowFaller_DB.Slowfall;
    newSettings[CLASSES.DRUID].Enable = SlowFaller_DB.Flap;
    SlowFaller_DB = newSettings;
end

local function GetColoredClassName()
    local color = C_ClassColor.GetClassColor(PLAYER_CLASS_NAME);
    local localizedClassName = LOCALIZED_CLASS_NAMES_FEMALE[PLAYER_CLASS_NAME];
    return color:WrapTextInColorCode(localizedClassName);
end

local function GetSettingsForCurrentClass()
    local settings = SlowFaller_DB[PLAYER_CLASS];
    return settings;
end

local function GetEnabledForCurrentClass()
    local settings = GetSettingsForCurrentClass();
    return settings.Enable;
end

local function SetEnabledForCurrentClass(enabled)
    SlowFaller_DB[PLAYER_CLASS].Enabled = enabled;
end

local function GetOverrideSpellIDForCurrentClass()
    local settings = GetSettingsForCurrentClass();
    return settings.SpellID;
end

local function SetOverrideSpellIDForCurrentClass(spellID)
    SlowFaller_DB[PLAYER_CLASS].SpellID = spellID;
end

local function GetDefaultOverrideSpellIDForCurrentClass()
    return DefaultSettingsPerClass[PLAYER_CLASS].SpellID;
end

------------
--- settings api

local Settings = {};

function Settings.GetOverrideSpellID()
    return GetOverrideSpellIDForCurrentClass();
end

function Settings.GetOverrideCommand()
    local spellID = GetOverrideSpellIDForCurrentClass();
    if spellID then
        return format("SPELL %s", C_Spell.GetSpellName(spellID));
    end
end

function Settings.ShouldHandleJumpCommand()
    if not GetEnabledForCurrentClass() then
        return;
    end

    if InCombatLockdown() or IsMounted() or UnitIsDeadOrGhost("player") then
        return false;
    end

    for spellID, _ in pairs(BAD_SPELLS) do
        if C_UnitAuras.GetPlayerAuraBySpellID(spellID) then
            return false;
        end
    end

    return true;
end

SlowFaller.Settings = Settings;

------------
--- utils

local function SetupSimpleTooltipForFrame(frame, tooltipText, anchor, instructionLine)
    frame:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, anchor or "ANCHOR_TOP");
        GameTooltip_SetTitle(GameTooltip, tooltipText, nil, true);
        if instructionLine then
            GameTooltip_AddInstructionLine(GameTooltip, instructionLine, true);
        end
        GameTooltip:Show();
    end);
    frame:SetScript("OnLeave", function()
        GameTooltip:Hide();
    end);
end

------------
--- settings UI setup

local UI = CreateFrame("Frame", "SlowFallerSettingsFrame", UIParent, "PortraitFrameFlatTemplate, ResizeLayoutFrame");
UI:SetPoint("CENTER");
UI:SetSize(300, 300);
UI:SetMovable(true);
UI:SetDontSavePosition(true);
UI:Hide();
ButtonFrameTemplate_HidePortrait(UI);
UI.fixedWidth = 300;
UI.minimumHeight = 300;
UI.heightPadding = 20;

tinsert(UISpecialFrames, UI:GetName());

local dragBar = CreateFrame("Frame", nil, UI, "PanelDragBarTemplate");
dragBar:SetHeight(28);
dragBar:SetPoint("TOPLEFT");
dragBar:SetPoint("TOPRIGHT");

local elements = {};

local classText = UI:CreateFontString(nil, "ARTWORK", "GameFontWhite");
classText:SetWidth(UI:GetWidth());
classText:SetJustifyH("CENTER");
classText:SetJustifyV("MIDDLE");
classText:SetTextScale(1.2);

tinsert(elements, classText);

local enableContainer = CreateFrame("Frame", nil, UI);
enableContainer:SetSize(300, 20);

local enableLabel = enableContainer:CreateFontString(nil, "ARTWORK", "GameFontWhite");
enableLabel:SetJustifyH("CENTER");
enableLabel:SetText(L.SettingsEnableCheckboxLabel);
enableLabel:SetPoint("TOPLEFT", 25, 0);
enableLabel:SetPoint("BOTTOM");

local enableCheckbox = CreateFrame("CheckButton", nil, enableContainer, "UICheckButtonTemplate");
enableCheckbox:SetPoint("LEFT", enableContainer, "CENTER", enableContainer:GetWidth() / 4, 0);

tinsert(elements, enableContainer);

local overrideContainer = CreateFrame("Frame", nil, UI);
overrideContainer:SetSize(300, 20);

local overrideLabel = overrideContainer:CreateFontString(nil, "ARTWORK", "GameFontWhite");
overrideLabel:SetJustifyH("CENTER");
overrideLabel:SetText(L.SettingsOverrideLabel);
overrideLabel:SetPoint("TOPLEFT", 25, 0);
overrideLabel:SetPoint("BOTTOM");

local overrideEditBox = CreateFrame("EditBox", nil, overrideContainer, "InputBoxTemplate");
overrideEditBox:SetAutoFocus(false);
overrideEditBox:SetFontObject("GameFontWhite");
overrideEditBox:SetPoint("TOPLEFT", overrideContainer, "TOP", 10, 0);
overrideEditBox:SetPoint("BOTTOMRIGHT", -20, 0);

SetupSimpleTooltipForFrame(overrideContainer, L.SettingsOverrideTooltip, nil, L.SettingsOverrideTooltipInstruction);

tinsert(elements, overrideContainer);

local spellInfoContainer = CreateFrame("Frame", nil, UI, "ResizeLayoutFrame");
spellInfoContainer:SetSize(300, 100);
spellInfoContainer.fixedWidth = 300;
spellInfoContainer.minimumHeight = 100;

local spellInfoIcon = CreateFrame("Button", nil, spellInfoContainer, "UIPanelBorderedButtonTemplate");
spellInfoIcon:SetPoint("TOPLEFT", 70, 0);
spellInfoIcon:Disable();

local spellInfoLabel = spellInfoContainer:CreateFontString(nil, "ARTWORK", "GameFontWhite");
spellInfoLabel:SetPoint("LEFT", spellInfoIcon, "RIGHT", 40, 0);
spellInfoLabel:SetJustifyH("CENTER");

local spellInfoDesc = spellInfoContainer:CreateFontString(nil, "ARTWORK", "GameFontNormal");
spellInfoDesc:SetPoint("TOPLEFT", 20, -45);
spellInfoDesc:SetPoint("TOPRIGHT", -20, -45);

tinsert(elements, spellInfoContainer);

local saveButton = CreateFrame("Button", nil, UI, "SharedGoldRedButtonLargeTemplate");
saveButton:SetText(L.SettingsSaveButtonLabel);

local lastElement = elements[#elements];
saveButton:SetPoint("TOP", lastElement, "BOTTOM", 0, -10);

local defaultsButton = CreateFrame("Button", nil, UI, "SharedButtonSmallTemplate");
defaultsButton:SetWidth(160);
defaultsButton:SetText(L.SettingsDefaultsButtonLabel);
defaultsButton:SetPoint("TOP", saveButton, "BOTTOM", 0, -5);
defaultsButton:Disable();
defaultsButton:SetScript("OnEnter", function(self)
    local tooltipText = self:IsEnabled() and L.SettingsDefaultsButtonTooltipEnabled or L.SettingsDefaultsButtonTooltipDisabled;
    GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT");
    GameTooltip_SetTitle(GameTooltip, tooltipText, nil, true);
    GameTooltip_AddNormalLine(GameTooltip, L.ThisCannotBeUndone, true, 40);
    GameTooltip:Show();
end);
defaultsButton:SetScript("OnLeave", function()
    GameTooltip:Hide();
end);
defaultsButton:SetScript("OnEvent", function(self, event)
    if event == "MODIFIER_STATE_CHANGED" then
        self:SetEnabled(IsShiftKeyDown());
        if defaultsButton:IsMouseOver() then
            defaultsButton:GetScript("OnEnter")(defaultsButton);
        end
    end
end);
defaultsButton:RegisterEvent("MODIFIER_STATE_CHANGED");

------------
--- data

local isDirty = false;

local function UpdateTitle()
    local title = addonName;
    if isDirty then
        title = title .. "*";
    end
    UI:SetTitle(title);
end

local function UpdateSpellInfo(spellID)
    local iconID, name, desc;
    if spellID then
        iconID = C_Spell.GetSpellTexture(spellID);
        name = C_Spell.GetSpellName(spellID);
        desc = C_Spell.GetSpellDescription(spellID);
    else
        iconID = QUESTION_MARK_ICON;
        name = L.SettingsSpellInfoNoSpellName;
        desc = L.SettingsSpellInfoNoSpellDesc;
    end

    spellInfoIcon.Icon:SetTexture(iconID);
    spellInfoLabel:SetTextToFit(name);

    -- trickery to make the description size change dynamically with the length of the description
    -- (without wrapping) see https://warcraft.wiki.gg/wiki/API_FontString_GetStringHeight
    spellInfoDesc:SetHeight(1000);
    spellInfoDesc:SetTextToFit(desc);
    spellInfoDesc:SetHeight(spellInfoDesc:GetStringHeight());

    spellInfoContainer:MarkDirty();
end

local function PopulateUI(previewSpellID)
    isDirty = previewSpellID ~= nil;

    -- set the class text first
    classText:SetFormattedText(L.SettingsClassText, GetColoredClassName());

    if not previewSpellID then
        previewSpellID = GetOverrideSpellIDForCurrentClass();
    end

    -- populate the editbox
    local spellName = previewSpellID and C_Spell.GetSpellName(previewSpellID) or "";
    overrideEditBox:SetText(spellName);
    UpdateSpellInfo(previewSpellID);
    UpdateTitle();
    UI:MarkDirty();
end

local function GetOverrideEditBoxSpellID()
    local newSpellName = overrideEditBox:GetText();
    local spellID = tonumber(newSpellName);
    if not spellID then
        spellID = C_Spell.GetSpellIDForSpellIdentifier(newSpellName);
    end

    return spellID;
end

local function OnEnableCheckboxClicked()
    isDirty = true;
    UpdateTitle();
end
enableCheckbox:SetScript("OnClick", OnEnableCheckboxClicked);

--- for our overrideEditBox
local function OnEditBoxEnterPressed()
    local spellID = GetOverrideEditBoxSpellID();
    PopulateUI(spellID);
end
overrideEditBox:SetScript("OnEnterPressed", OnEditBoxEnterPressed);

local function OnSaveButtonClicked()
    local enable = enableCheckbox:GetChecked();
    SetEnabledForCurrentClass(enable);

    local spellID = GetOverrideEditBoxSpellID();
    SetOverrideSpellIDForCurrentClass(spellID);
    isDirty = false;
    UpdateTitle();
end
saveButton:SetScript("OnClick", OnSaveButtonClicked);

local function OnDefaultsButtonClicked(self)
    local defaultSpellID = GetDefaultOverrideSpellIDForCurrentClass();
    SetOverrideSpellIDForCurrentClass(defaultSpellID);
    PopulateUI(defaultSpellID);
    self:Disable();
end
defaultsButton:SetScript("OnClick", OnDefaultsButtonClicked);

local function OnSettingsFrameShow()
    PopulateUI();
end
UI:SetScript("OnShow", OnSettingsFrameShow);

------------
--- layout stuff

local initialAnchor = CreateAnchor("TOPLEFT", UI, "TOPLEFT", 8, -38);

local padding = 10;
AnchorUtil.VerticalLayout(elements, initialAnchor, padding);

------------

local function ToggleSettingsPanel()
    UI:SetShown(not UI:IsShown());
end

SLASH_SLOWFALLER1, SLASH_SLOWFALLER2 = "/slowfaller", "/slowfall";
SlashCmdList.SLOWFALLER = function(msg)
    ToggleSettingsPanel();
end