-- Namespaces
-- core - table (namespace) shared between every lua file
local addonName, core = ...;
core.UIConfig = {};

-- Defaults
UISettingsGlobal = {
    useBlizzardBlockValue = false;
    useTransparentStatsBackground = true;
}

UISettingsCharacter = {
    selectedLeftStatsCategory = 1;
    selectedRightStatsCategory = 2;
    showStatsFromArgentDawnItems = true;
}

-- for easier referencing the core config
local UIConfig = core.UIConfig;
local CSC_UIFrame = core.UIConfig;
local CSC_ConfigFrame = { };

local statsDropdownList = {
    PLAYERSTAT_BASE_STATS,
    PLAYERSTAT_MELEE_COMBAT,
    PLAYERSTAT_RANGED_COMBAT,
    PLAYERSTAT_SPELL_COMBAT,
    PLAYERSTAT_DEFENSES
}

local NUM_STATS_TO_SHOW = 6;
local LeftStatsTable = { }
local RightStatsTable = { }

local function CSC_ResetStatFrames(statFrames)
    
    local statFrameDefaultAlpha = 0.3;
    if UISettingsGlobal.useTransparentStatsBackground then
        statFrameDefaultAlpha = 0;
    end

    for i=1, NUM_STATS_TO_SHOW, 1 do
        statFrames[i]:Hide();
        statFrames[i]:SetScript("OnEnter", statFrames[i].OnEnterCallback);
        statFrames[i].tooltip = nil;
        statFrames[i].tooltip2 = nil;
        statFrames[i].tooltip3 = nil;
        statFrames[i].Background:SetVertexColor(0, 0, 0, 1);
    end
end

local function CSC_ShowStatFrames(statFrames, category)
    local statsToShow = NUM_STATS_TO_SHOW;

    if (category == PLAYERSTAT_RANGED_COMBAT) then
        statsToShow = statsToShow - 1;
    end

    for i=1, statsToShow, 1 do
        statFrames[i]:Show();
    end
end

function UIConfig:InitializeStatsFrames(leftParentFrame, rightParentFrame)
    local offsetStepY = 15;
    local accumulatedOffsetY = 0;
    
    for i = 1, NUM_STATS_TO_SHOW do
        accumulatedOffsetY = accumulatedOffsetY + offsetStepY;
        local actualOffset = accumulatedOffsetY;
        
        if i == 1 then 
            actualOffset = 32;
            accumulatedOffsetY = 32;
        end

        LeftStatsTable[i] = CreateFrame("Frame", nil, leftParentFrame, "CharacterStatFrameTemplate");
        LeftStatsTable[i]:SetPoint("LEFT", leftParentFrame, "TOPLEFT", 10, -actualOffset);
        LeftStatsTable[i]:SetWidth(130);
        LeftStatsTable[i].OnEnterCallback = LeftStatsTable[i]:GetScript("OnEnter");

        RightStatsTable[i] = CreateFrame("Frame", nil, rightParentFrame, "CharacterStatFrameTemplate");
        RightStatsTable[i]:SetPoint("LEFT", rightParentFrame, "TOPLEFT", 10, -actualOffset);
        RightStatsTable[i]:SetWidth(130);
        RightStatsTable[i].OnEnterCallback = RightStatsTable[i]:GetScript("OnEnter");
    end
end

function UIConfig:SetCharacterStats(statsTable, category)

    CSC_ResetStatFrames(statsTable);

    local unit = "player";

    if category == PLAYERSTAT_BASE_STATS then
        CSC_PaperDollFrame_SetPrimaryStats(statsTable, unit);
        CSC_PaperDollFrame_SetArmor(statsTable[6], unit);
    elseif category == PLAYERSTAT_DEFENSES then
        CSC_PaperDollFrame_SetArmor(statsTable[1], unit);
        CSC_PaperDollFrame_SetDefense(statsTable[2], unit);
        CSC_PaperDollFrame_SetDodge(statsTable[3]);
        CSC_PaperDollFrame_SetParry(statsTable[4]);
        CSC_PaperDollFrame_SetBlock(statsTable[5], unit);
        CSC_PaperDollFrame_SetResilience(statsTable[6]);
    elseif category == PLAYERSTAT_MELEE_COMBAT then
        if (UISettingsCharacter.showStatsFromArgentDawnItems) then
            CSC_CacheAPFromADItems(unit);
        end
        
        CSC_PaperDollFrame_SetDamage(statsTable[1], unit, category);
        CSC_PaperDollFrame_SetMeleeAttackPower(statsTable[2], unit);
        CSC_PaperDollFrame_SetAttackSpeed(statsTable[3], unit);
        CSC_PaperDollFrame_SetCritChance(statsTable[4], unit);
        CSC_PaperDollFrame_SetHitRating(statsTable[5], unit, CR_HIT_MELEE);
        CSC_PaperDollFrame_SetExpertise(statsTable[6], unit);
    elseif category == PLAYERSTAT_RANGED_COMBAT then
        if (UISettingsCharacter.showStatsFromArgentDawnItems) then
            CSC_CacheAPFromADItems(unit);
        end
        CSC_PaperDollFrame_SetDamage(statsTable[1], unit, category);
        CSC_PaperDollFrame_SetRangedAttackPower(statsTable[2], unit);
        CSC_PaperDollFrame_SetRangedAttackSpeed(statsTable[3], unit);
        CSC_PaperDollFrame_SetRangedCritChance(statsTable[4], unit);
        CSC_PaperDollFrame_SetHitRating(statsTable[5], unit, CR_HIT_RANGED);
    elseif category == PLAYERSTAT_SPELL_COMBAT then
        -- TODO Spell Crit and Spell Hit from talents
        CSC_PaperDollFrame_SetSpellPower(statsTable[1], unit);
        CSC_PaperDollFrame_SetHealing(statsTable[2], unit);
        CSC_PaperDollFrame_SetManaRegen(statsTable[3], unit);
        CSC_PaperDollFrame_SetSpellCritChance(statsTable[4], unit);
        CSC_PaperDollFrame_SetHitRating(statsTable[5], unit, CR_HIT_SPELL);
        CSC_PaperDollFrame_SetSpellHaste(statsTable[6]);
    end

    CSC_ShowStatFrames(statsTable, category);
end

function UIConfig:CreateMenu()
    if not __DEBUG__ then
        -- Hide the default stats
        CharacterAttributesFrame:Hide();
    end

    local offsetX = 50;
    local offsetY = 85;

    if __DEBUG__ then
        offsetY = -120;
    end

    CSC_UIFrame.CharacterStatsPanel = CreateFrame("Frame", nil, CharacterFrame); --CharacterFrameInsetRight
	CSC_UIFrame.CharacterStatsPanel:SetPoint("LEFT", CharacterFrame, "BOTTOMLEFT", offsetX, offsetY);
	CSC_UIFrame.CharacterStatsPanel:SetHeight(320);
    CSC_UIFrame.CharacterStatsPanel:SetWidth(200);

    UIConfig:SetupDropdown();
    UIConfig:SetupConfigInterface();

    UIConfig:InitializeStatsFrames(CSC_UIFrame.CharacterStatsPanel.leftStatsDropDown, CSC_UIFrame.CharacterStatsPanel.rightStatsDropDown);
    UIConfig:UpdateStats();
end

function UIConfig:UpdateStats()
    UIConfig:SetCharacterStats(LeftStatsTable, statsDropdownList[UISettingsCharacter.selectedLeftStatsCategory]);
    UIConfig:SetCharacterStats(RightStatsTable, statsDropdownList[UISettingsCharacter.selectedRightStatsCategory]);
end

local function OnClickLeftStatsDropdown(self)
    UISettingsCharacter.selectedLeftStatsCategory = self:GetID();
    UIDropDownMenu_SetSelectedID(CSC_UIFrame.CharacterStatsPanel.leftStatsDropDown, UISettingsCharacter.selectedLeftStatsCategory);
    UIConfig:SetCharacterStats(LeftStatsTable, statsDropdownList[UISettingsCharacter.selectedLeftStatsCategory]);
end

local function OnClickRightStatsDropdown(self)
    UISettingsCharacter.selectedRightStatsCategory = self:GetID();
    UIDropDownMenu_SetSelectedID(CSC_UIFrame.CharacterStatsPanel.rightStatsDropDown, UISettingsCharacter.selectedRightStatsCategory);
    UIConfig:SetCharacterStats(RightStatsTable, statsDropdownList[UISettingsCharacter.selectedRightStatsCategory]);
end

function UIConfig:InitializeLeftStatsDropdown(self, level)
    local info = UIDropDownMenu_CreateInfo();
    for k,v in pairs(statsDropdownList) do
        info.text = v;
        info.func = OnClickLeftStatsDropdown;
        info.checked = false;
        UIDropDownMenu_AddButton(info, level);
     end
end

function UIConfig:InitializeRightStatsDropdown(self, level)
    local info = UIDropDownMenu_CreateInfo();
    for k,v in pairs(statsDropdownList) do
        info.text = v;
        info.func = OnClickRightStatsDropdown;
        info.checked = false;
        UIDropDownMenu_AddButton(info, level);
     end
end

function UIConfig:SetupDropdown()

    CSC_UIFrame.CharacterStatsPanel.leftStatsDropDown = CreateFrame("Frame", nil, CSC_UIFrame.CharacterStatsPanel, "UIDropDownMenuTemplate");
    CSC_UIFrame.CharacterStatsPanel.leftStatsDropDown:SetPoint("TOPLEFT", CSC_UIFrame.CharacterStatsPanel, "TOPLEFT", 0, 0);

    CSC_UIFrame.CharacterStatsPanel.rightStatsDropDown = CreateFrame("Frame", nil, CSC_UIFrame.CharacterStatsPanel, "UIDropDownMenuTemplate");
    CSC_UIFrame.CharacterStatsPanel.rightStatsDropDown:SetPoint("TOPLEFT", CSC_UIFrame.CharacterStatsPanel, "TOPLEFT", 115, 0);

    UIDropDownMenu_Initialize(CSC_UIFrame.CharacterStatsPanel.leftStatsDropDown, UIConfig.InitializeLeftStatsDropdown);
    UIDropDownMenu_SetSelectedID(CSC_UIFrame.CharacterStatsPanel.leftStatsDropDown, UISettingsCharacter.selectedLeftStatsCategory);
    UIDropDownMenu_SetWidth(CSC_UIFrame.CharacterStatsPanel.leftStatsDropDown, 99);
    UIDropDownMenu_JustifyText(CSC_UIFrame.CharacterStatsPanel.leftStatsDropDown, "LEFT");

    UIDropDownMenu_Initialize(CSC_UIFrame.CharacterStatsPanel.rightStatsDropDown, UIConfig.InitializeRightStatsDropdown);
    UIDropDownMenu_SetSelectedID(CSC_UIFrame.CharacterStatsPanel.rightStatsDropDown, UISettingsCharacter.selectedRightStatsCategory);
    UIDropDownMenu_SetWidth(CSC_UIFrame.CharacterStatsPanel.rightStatsDropDown, 99);
    UIDropDownMenu_JustifyText(CSC_UIFrame.CharacterStatsPanel.rightStatsDropDown, "LEFT");
end

function UIConfig:SetupConfigInterface()

    CSC_ConfigFrame = CreateFrame("Frame", "CSC_InterfaceOptionsPanel", UIParent);
    CSC_ConfigFrame.name = "CharacterStatsClassic";
    InterfaceOptions_AddCategory(CSC_ConfigFrame);

    -- Title and font
    CSC_ConfigFrame.title = CreateFrame("Frame", "CharacterStatsClassic", CSC_ConfigFrame);
    CSC_ConfigFrame.title:SetPoint("TOPLEFT", CSC_ConfigFrame, "TOPLEFT", 10, -10);
    CSC_ConfigFrame.title:SetWidth(300);
    CSC_ConfigFrame.titleString = CSC_ConfigFrame.title:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    CSC_ConfigFrame.titleString:SetPoint("TOPLEFT", CSC_ConfigFrame, "TOPLEFT", 10, -10);
    CSC_ConfigFrame.titleString:SetText('|cff00c0ffCharacterStatsClassic|r');
    CSC_ConfigFrame.titleString:SetFont("Fonts\\FRIZQT__.tff", 20, "OUTLINE");

    -- Checkboxes
    CSC_ConfigFrame.chkBtnUseBlizzardBlockValue = CreateFrame("CheckButton", "default", CSC_ConfigFrame, "UICheckButtonTemplate");
    CSC_ConfigFrame.chkBtnUseBlizzardBlockValue:SetPoint("TOPLEFT", 20, -30);
    CSC_ConfigFrame.chkBtnUseBlizzardBlockValue.text:SetText("Use alternative Block Value calculation (Blizzard function)");
    CSC_ConfigFrame.chkBtnUseBlizzardBlockValue:SetChecked(UISettingsGlobal.useBlizzardBlockValue);
    CSC_ConfigFrame.chkBtnUseBlizzardBlockValue:SetScript("OnClick", 
    function()
        UISettingsGlobal.useBlizzardBlockValue = not UISettingsGlobal.useBlizzardBlockValue;
    end);

    CSC_ConfigFrame.chkBtnShowADStats = CreateFrame("CheckButton", "default", CSC_ConfigFrame, "UICheckButtonTemplate");
    CSC_ConfigFrame.chkBtnShowADStats:SetPoint("TOPLEFT", 20, -55);
    CSC_ConfigFrame.chkBtnShowADStats.text:SetText("Show AP and SP stats from Argent Dawn items.");
    CSC_ConfigFrame.chkBtnShowADStats:SetChecked(UISettingsCharacter.showStatsFromArgentDawnItems);
    CSC_ConfigFrame.chkBtnShowADStats:SetScript("OnClick", 
    function()
        UISettingsCharacter.showStatsFromArgentDawnItems = not UISettingsCharacter.showStatsFromArgentDawnItems;
    end);

    -- Stats frames alpha checkbox
    CSC_ConfigFrame.chkBtnStatsFramesAlpha = CreateFrame("CheckButton", "default", CSC_ConfigFrame, "UICheckButtonTemplate");
    CSC_ConfigFrame.chkBtnStatsFramesAlpha:SetPoint("TOPLEFT", 20, -80);
    CSC_ConfigFrame.chkBtnStatsFramesAlpha.text:SetText("Use a transparent background for the stats frames.");
    CSC_ConfigFrame.chkBtnStatsFramesAlpha:SetChecked(UISettingsGlobal.useTransparentStatsBackground);
    CSC_ConfigFrame.chkBtnStatsFramesAlpha:SetScript("OnClick", 
    function()
        UISettingsGlobal.useTransparentStatsBackground = not UISettingsGlobal.useTransparentStatsBackground;
    end);
    
end

-- Hook a custom function in order to extend the functionality of the default ToggleCharacter function
local function CSC_ToggleCharacterPostHook(tab, onlyShow)
    if (tab == "PaperDollFrame") then
        CSC_UIFrame.CharacterStatsPanel:Show();
        CSC_UIFrame:UpdateStats();
    else
        CSC_UIFrame.CharacterStatsPanel:Hide();
    end
end
hooksecurefunc("ToggleCharacter", CSC_ToggleCharacterPostHook);

-- Serializing the DB
local function SerializeGlobalDatabase()
    if (CharacterStatsTbcDB == nil) then
        CharacterStatsTbcDB = UISettingsGlobal;
    end

    if (CharacterStatsTbcDB.useBlizzardBlockValue == nil) then
        CharacterStatsTbcDB.useBlizzardBlockValue = UISettingsGlobal.useBlizzardBlockValue;
    else
        UISettingsGlobal.useBlizzardBlockValue = CharacterStatsTbcDB.useBlizzardBlockValue;
    end

    if (CharacterStatsTbcDB.useTransparentStatsBackground == nil) then
        CharacterStatsTbcDB.useTransparentStatsBackground = UISettingsGlobal.useTransparentStatsBackground;
    else
        UISettingsGlobal.useTransparentStatsBackground = CharacterStatsTbcDB.useTransparentStatsBackground;
    end
end

local function SerializeCharacterDatabase()
    if (CharacterStatsTbcCharacterDB == nil) then
        CharacterStatsTbcCharacterDB = UISettingsCharacter;
    end

    -- Left dropdown category
    if (CharacterStatsTbcCharacterDB.selectedLeftStatsCategory == nil) then
        CharacterStatsTbcCharacterDB.selectedLeftStatsCategory = UISettingsCharacter.selectedLeftStatsCategory;
    else
        UISettingsCharacter.selectedLeftStatsCategory = CharacterStatsTbcCharacterDB.selectedLeftStatsCategory;
    end

    -- Right dropdown category
    if (CharacterStatsTbcCharacterDB.selectedRightStatsCategory == nil) then
        CharacterStatsTbcCharacterDB.selectedRightStatsCategory = UISettingsCharacter.selectedRightStatsCategory;
    else
        UISettingsCharacter.selectedRightStatsCategory = CharacterStatsTbcCharacterDB.selectedRightStatsCategory;
    end

    -- Stats from AD items checkbox
    if (CharacterStatsTbcCharacterDB.showStatsFromArgentDawnItems == nil) then
        CharacterStatsTbcCharacterDB.showStatsFromArgentDawnItems = UISettingsCharacter.showStatsFromArgentDawnItems;
    else
        UISettingsCharacter.showStatsFromArgentDawnItems = CharacterStatsTbcCharacterDB.showStatsFromArgentDawnItems;
    end
end

local dbLoader = CreateFrame("Frame");
dbLoader:RegisterEvent("ADDON_LOADED");
dbLoader:RegisterEvent("PLAYER_LOGOUT");

-- ADDON_LOADED is called after the code of the addon is being executed
-- Therefore I have to call any setup-functions dependent on the DB after the event (UIConfig:SetupDropdown())
function dbLoader:OnEvent(event, arg1)
    if (event == "ADDON_LOADED" and arg1 == "CharacterStatsTBC") then
        SerializeGlobalDatabase();
        SerializeCharacterDatabase();
        UIConfig:CreateMenu();
    elseif (event == "PLAYER_LOGOUT") then
        CharacterStatsTbcDB = UISettingsGlobal;
        CharacterStatsTbcCharacterDB = UISettingsCharacter;
    end
end

dbLoader:SetScript("OnEvent", dbLoader.OnEvent);
-- Serializing the DB