__DEBUG__ = false;

-- Class ids
CSC_WARRIOR_CLASS_ID 		= 1;
CSC_PALADIN_CLASS_ID 		= 2;
CSC_HUNTER_CLASS_ID 		= 3;
CSC_ROGUE_CLASS_ID 			= 4;
CSC_PRIEST_CLASS_ID 		= 5;
CSC_DEATHKNIGHT_CLASS_ID 	= 6;
CSC_SHAMAN_CLASS_ID 		= 7;
CSC_MAGE_CLASS_ID 			= 8;
CSC_WARLOCK_CLASS_ID 		= 9;
CSC_MONK_CLASS_ID 			= 10;
CSC_DRUID_CLASS_ID 			= 11;
CSC_DEMONHUNTER_CLASS_ID 	= 12;

-- Combat ratings
CSC_COMBAT_RATING_EXPERTISE     = 1;
CSC_COMBAT_RATING_HASTE         = 2;
CSC_COMBAT_RATING_SPELL_HASTE   = 3;
CSC_COMBAT_RATING_HIT           = 4;
CSC_COMBAT_RATING_SPELL_HIT     = 5;
CSC_COMBAT_RATING_CRIT          = 6;
CSC_COMBAT_RATING_SPELL_CRIT    = 7;
CSC_COMBAT_RATING_DEFENSE       = 8;
CSC_COMBAT_RATING_DODGE         = 9;
CSC_COMBAT_RATING_PARRY         = 10;
CSC_COMBAT_RATING_BLOCK         = 11;
CSC_COMBAT_RATING_ARPEN         = 12;
CSC_COMBAT_RATING_RESILENCE     = 13;

-- Weapon IDs
CSC_LE_ITEM_WEAPON_AXE1H    = 0;
CSC_LE_ITEM_WEAPON_AXE2H    = 1;
CSC_LE_ITEM_WEAPON_MACE1H   = 4;
CSC_LE_ITEM_WEAPON_MACE2H   = 5;
CSC_LE_ITEM_WEAPON_POLEARM  = 6;
CSC_LE_ITEM_WEAPON_SWORD1H  = 7;
CSC_LE_ITEM_WEAPON_SWORD2H  = 8;
CSC_LE_ITEM_WEAPON_STAFF    = 10;
CSC_LE_ITEM_WEAPON_UNARMED  = 13;
CSC_LE_ITEM_WEAPON_DAGGER   = 15;
CSC_LE_ITEM_WEAPON_BOWS     = 2;
CSC_LE_ITEM_WEAPON_CROSSBOW = 18;
CSC_LE_ITEM_WEAPON_GUNS     = 3;

g_WeaponStringByWeaponId = {
	[CSC_LE_ITEM_WEAPON_AXE1H] 		= CSC_WEAPON_AXE1H_TXT,
	[CSC_LE_ITEM_WEAPON_AXE2H] 		= CSC_WEAPON_AXE2H_TXT,
	[CSC_LE_ITEM_WEAPON_MACE1H] 	= CSC_WEAPON_MACE1H_TXT,
	[CSC_LE_ITEM_WEAPON_MACE2H] 	= CSC_WEAPON_MACE2H_TXT,
	[CSC_LE_ITEM_WEAPON_POLEARM] 	= CSC_WEAPON_POLEARM_TXT,
	[CSC_LE_ITEM_WEAPON_SWORD1H] 	= CSC_WEAPON_SWORD1H_TXT,
	[CSC_LE_ITEM_WEAPON_SWORD2H] 	= CSC_WEAPON_SWORD2H_TXT,
	[CSC_LE_ITEM_WEAPON_STAFF] 		= CSC_WEAPON_STAFF_TXT,
	[CSC_LE_ITEM_WEAPON_UNARMED] 	= CSC_WEAPON_UNARMED_TXT,
    [CSC_LE_ITEM_WEAPON_DAGGER] 	= CSC_WEAPON_DAGGER_TXT,
    [CSC_LE_ITEM_WEAPON_BOWS]       = CSC_WEAPON_BOW_TXT,
    [CSC_LE_ITEM_WEAPON_CROSSBOW]   = CSC_WEAPON_CROSSBOW_TXT,
    [CSC_LE_ITEM_WEAPON_GUNS]       = CSC_WEAPON_GUN_TXT
};

g_CombatRatingBaseValues = {
    [CSC_COMBAT_RATING_EXPERTISE]     = 2.5,
    [CSC_COMBAT_RATING_HASTE]         = 10,
    [CSC_COMBAT_RATING_SPELL_HASTE]   = 10,
    [CSC_COMBAT_RATING_HIT]           = 10,
    [CSC_COMBAT_RATING_SPELL_HIT]     = 8,
    [CSC_COMBAT_RATING_CRIT]          = 14,
    [CSC_COMBAT_RATING_SPELL_CRIT]    = 14,
    [CSC_COMBAT_RATING_DEFENSE]       = 1.5,
    [CSC_COMBAT_RATING_DODGE]         = 12,
    [CSC_COMBAT_RATING_PARRY]         = 15,
    [CSC_COMBAT_RATING_BLOCK]         = 5,
    [CSC_COMBAT_RATING_ARPEN]         = 3.75,
    [CSC_COMBAT_RATING_RESILENCE]     = 11.36
};

-- Class set items IDs
g_BattlegearOfMightIds = { 
    [16861] = 16861, 
    [16862] = 16862, 
    [16863] = 16863, 
    [16864] = 16864, 
    [16865] = 16865, 
    [16866] = 16866, 
    [16867] = 16867, 
    [16868] = 16868
};

g_VestmentsOfTranscendenceIds = {
    [16925] = 16925, 
    [16926] = 16926, 
    [16919] = 16919, 
    [16921] = 16921, 
    [16920] = 16920, 
    [16922] = 16922, 
    [16924] = 16924, 
    [16923] = 16923,
};

g_StormrageRaimentIds = {
    [16897] = 16897, 
    [16898] = 16898, 
    [16899] = 16899, 
    [16900] = 16900, 
    [16901] = 16901, 
    [16902] = 16902, 
    [16903] = 16903, 
    [16904] = 16904,
};

g_PrimalMooncloth = {
    [21875] = 21875, 
    [21874] = 21874, 
    [21873] = 21873
};

g_AuraIdToMp5 = {
	-- BOW
	[19742] = 10,
	[19850] = 15,
	[19852] = 20,
	[19853] = 25,
	[19854] = 30,
    [25290] = 33,
    [27142] = 41,
	-- GBOW
	[25894] = 30,
    [25918] = 33,
    [27143] = 41,
	-- Mana Spring Totem
	[5675] = 10,
	[10495] = 15,
	[10496] = 20,
	[10497] = 25,
	-- Mageblood potion
	[24363] = 12,
	--Nightfin Soup
	[18194] = 8
};
  
g_CombatManaRegenSpellIdToModifier = {
    -- Mage Armor
    [6117] = 0.3,
    [22782] = 0.3,
    [22783] = 0.3
};

g_ArgentDawnAPItems = {
    -- Chests
    [23087] = 81, -- Plate
    [23088] = 81, -- Mail
    [23089] = 81, -- Leather
    -- Gloves
    [23078] = 60, -- Plate
    [23082] = 60, -- Mail
    [23081] = 60, -- Leather
    -- Bracers
    [23090] = 45, -- Plate
    [23092] = 45, -- Mail
    [23093] = 45, -- Leather
    -- Trinkets
    [13209] = 81, -- Seal of the Dawn
    [23206] = 150 -- Mark of the Champion AP
}

g_ArgentDawnSPItems = {
    -- SP cloth set
    [23085] = 48, -- Chest
    [23091] = 26, -- Bracers
    [23084] = 35, -- Gloves
    -- Trinkets
    [19812] = 48, -- Rune of the Dawn 
    [23207] = 85 -- Mark of the Champion SP
}

CSC_SYMBOL_TAB   = "    "; -- for some reason "\t" doesn't work
CSC_SYMBOL_SPACE = " ";
                                