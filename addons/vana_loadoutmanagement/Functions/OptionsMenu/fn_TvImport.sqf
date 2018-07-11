disableserialization;

//WIP Rework (So it acctuly imports data instead overwrite)

#include "\vana_LoadoutManagement\UI\defineDIKCodes.inc"
#include "\vana_LoadoutManagement\UI\defineResinclDesign.inc"

params [
	["_ArsenalDisplay", displaynull, [displaynull]],
	["_ImportData", [], [[]]],
	["_ImportTypes", "", [""]],
	"_CtrlTreeView",
	"_LayoutData",
	"_LoadoutData",
	"_SavedLoadoutData",
	"_DuplicateLoadouts",
	"_TypeNameArray",
	"_Message",
	"_Index"
];

_CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
_LayoutData = _ImportData select 0;
_LoadoutData = _ImportData select 1;
_SavedLoadoutData = (profilenamespace Getvariable ["bis_fnc_saveInventory_Data", []]);
_DuplicateLoadouts = (_LoadoutData select {_x isequaltype ""}) select {_x in (_SavedLoadoutData select {_x isequaltype ""})};

_TypeNameArray = ["layout","loadout","both", "Layout","Loadout","Both Layout and Loadout"]; //LOCALIZE
_Message = format ["%1 Data Imported", _TypeNameArray select (_TypeNameArray find _ImportTypes)+3];

["VANA_fnc_TvImport"] call bis_fnc_startloadingscreen;
Tvclear _CtrlTreeView;

//Remove duplicate Loadouts
reverse _LoadoutData;
{
	_Index = _LoadoutData find _x;
	_LoadoutData deleterange [_Index-1, 2];
} foreach _DuplicateLoadouts;
reverse _LoadoutData;
_DuplicateLoadouts call VANA_Fnc_Log;
_LoadoutData call VANA_Fnc_Log;

if !(_ImportTypes in ["layout","both"]) then {_LayoutData = profilenamespace getvariable ["VANA_fnc_TreeViewSave_Data",[]]};
if (_ImportTypes in ["loadout","both"]) then {if !(_LoadoutData isequalto []) then {_SavedLoadoutData append _LoadoutData; profilenamespace Setvariable ["bis_fnc_saveInventory_Data", _SavedLoadoutData]}};

[_ArsenalDisplay, _LayoutData] call VANA_fnc_TvLoadData;
"VANA_fnc_TvImport" call bis_fnc_endloadingscreen;

_ArsenalDisplay Spawn VANA_fnc_TvSaveData;

["showMessage",[_ArsenalDisplay, _Message]] spawn BIS_fnc_arsenal;

True

/*
[["Template",[0],"tvloadout",0],["Test",[1],"tvloadout",0],["Blufor",[2],"tvtab",0],["Blufor Template",[2,0],"tvloadout",0],["NATO",[2,1],"tvtab",0],["NATO Rifleman",[2,1,0],"tvloadout",0],["NATO Team Leader",[2,1,1],"tvloadout",0],["Special Forces",[2,1,2],"tvtab",0],["NATO Recon",[2,1,2,0],"tvloadout",0],["Greenfor",[3],"tvtab",0],["Greenfor Template",[3,0],"tvloadout",0],["AAF",[3,1],"tvtab",0],["AAF Rifleman",[3,1,0],"tvloadout",0],["AAF Team Leader",[3,1,1],"tvloadout",0],["Special Forces",[3,1,2],"tvtab",0],["AAF Recon",[3,1,2,0],"tvloadout",0],["Opfor",[4],"tvtab",0],["Opfor Template",[4,0],"tvloadout",0],["CSAT",[4,1],"tvtab",0],["CSAT Rifleman",[4,1,0],"tvloadout",0],["CSAT Team Leader",[4,1,1],"tvloadout",0],["Special Forces",[4,1,2],"tvtab",0],["CSAT Recon",[4,1,2,0],"tvloadout",0]]


["CSAT Recon",[["U_C_Man_casual_4_F",[]],["",[]],["",[]],"","","",["",["","","",""],""],["",["","","",""],""],["",["","","",""],""],["ItemMap","ItemCompass","ItemWatch"],["WhiteHead_11","male04gre",""]],"CSAT Rifleman",[["U_C_Man_casual_4_F",[]],["",[]],["",[]],"","","",["",["","","",""],""],["",["","","",""],""],["",["","","",""],""],["ItemMap","ItemCompass","ItemWatch"],["WhiteHead_11","male04gre",""]],"AAF Rifleman",[["U_O_T_Soldier_F",["FirstAidKit","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F"]],["V_TacChestrig_oli_F",["30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","HandGrenade","O_IR_Grenade","O_IR_Grenade","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red"]],["B_Carryall_ghex_OTAAA_F",["Titan_AA","Titan_AA","Titan_AA"]],"H_HelmetO_ghex_F","","Rangefinder",["arifle_CTAR_blk_F",["","acc_pointer_IR","optic_ACO_grn",""],"30Rnd_580x42_Mag_F"],["",["","","",""],""],["hgun_Rook40_F",["","","",""],"16Rnd_9x21_Mag"],["ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F"],["WhiteHead_11","male04gre",""]],"AAF Team Leader",[["U_O_T_Soldier_F",["FirstAidKit","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F"]],["V_TacChestrig_oli_F",["30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","HandGrenade","O_IR_Grenade","O_IR_Grenade","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red"]],["B_Carryall_ghex_OTAAA_F",["Titan_AA","Titan_AA","Titan_AA"]],"H_HelmetO_ghex_F","","Rangefinder",["arifle_CTAR_blk_F",["","acc_pointer_IR","optic_ACO_grn",""],"30Rnd_580x42_Mag_F"],["",["","","",""],""],["hgun_Rook40_F",["","","",""],"16Rnd_9x21_Mag"],["ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F"],["WhiteHead_11","male04gre",""]],"Blufor Template",[["U_I_GhillieSuit",["FirstAidKit","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","9Rnd_45ACP_Mag"]],["V_Chestrig_oli",["9Rnd_45ACP_Mag","ClaymoreDirectionalMine_Remote_Mag","APERSTripMine_Wire_Mag","MiniGrenade","MiniGrenade","I_IR_Grenade","I_IR_Grenade","SmokeShell","SmokeShellGreen","SmokeShellOrange","SmokeShellPurple","Chemlight_green","Chemlight_green"]],["",[]],"","","Laserdesignator_03",["arifle_Mk20_F",["","","optic_MRCO",""],"30Rnd_556x45_Stanag"],["",["","","",""],""],["hgun_ACPC2_F",["muzzle_snds_acp","","",""],"9Rnd_45ACP_Mag"],["ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","NVGoggles_INDEP"],["WhiteHead_11","male04gre",""]],"CSAT Team Leader",[["U_O_T_Soldier_F",["FirstAidKit","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F"]],["V_TacChestrig_oli_F",["30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","HandGrenade","O_IR_Grenade","O_IR_Grenade","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red"]],["B_Carryall_ghex_OTAAA_F",["Titan_AA","Titan_AA","Titan_AA"]],"H_HelmetO_ghex_F","","Rangefinder",["arifle_CTAR_blk_F",["","acc_pointer_IR","optic_ACO_grn",""],"30Rnd_580x42_Mag_F"],["",["","","",""],""],["hgun_Rook40_F",["","","",""],"16Rnd_9x21_Mag"],["ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F"],["WhiteHead_11","male04gre",""]],"Opfor Template",[["U_B_T_Soldier_SL_F",["FirstAidKit","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag"]],["V_Chestrig_rgr",["30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","HandGrenade","SmokeShell","SmokeShellGreen","SmokeShellBlue","SmokeShellOrange","Chemlight_green","Chemlight_green"]],["B_Kitbag_rgr_BTEng_F",["ToolKit","MineDetector","SatchelCharge_Remote_Mag","DemoCharge_Remote_Mag","DemoCharge_Remote_Mag"]],"H_HelmetB_tna_F","","",["arifle_MXC_khk_F",["","acc_pointer_IR","optic_Holosight_khk_F",""],"30Rnd_65x39_caseless_mag"],["",["","","",""],""],["hgun_P07_khk_F",["","","",""],"16Rnd_9x21_Mag"],["ItemMap","ItemCompass","ItemWatch","ItemRadio","NVGoggles_tna_F"],["WhiteHead_11","male04gre",""]],"AAF Recon",[["U_O_T_Soldier_F",["FirstAidKit","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F"]],["V_TacChestrig_oli_F",["30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","HandGrenade","O_IR_Grenade","O_IR_Grenade","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red"]],["B_Carryall_ghex_OTAAA_F",["Titan_AA","Titan_AA","Titan_AA"]],"H_HelmetO_ghex_F","","Rangefinder",["arifle_CTAR_blk_F",["","acc_pointer_IR","optic_ACO_grn",""],"30Rnd_580x42_Mag_F"],["",["","","",""],""],["hgun_Rook40_F",["","","",""],"16Rnd_9x21_Mag"],["ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F"],["WhiteHead_11","male04gre",""]],"Greenfor Template",[["U_O_T_Soldier_F",["FirstAidKit","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F"]],["V_TacChestrig_oli_F",["30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","30Rnd_580x42_Mag_F","16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","HandGrenade","O_IR_Grenade","O_IR_Grenade","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red"]],["B_Carryall_ghex_OTAAA_F",["Titan_AA","Titan_AA","Titan_AA"]],"H_HelmetO_ghex_F","","Rangefinder",["arifle_CTAR_blk_F",["","acc_pointer_IR","optic_ACO_grn",""],"30Rnd_580x42_Mag_F"],["",["","","",""],""],["hgun_Rook40_F",["","","",""],"16Rnd_9x21_Mag"],["ItemMap","ItemCompass","ItemWatch","ItemRadio","O_NVGoggles_ghex_F"],["WhiteHead_11","male04gre",""]],"NATO Recon",[["U_I_GhillieSuit",["FirstAidKit","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","9Rnd_45ACP_Mag"]],["V_Chestrig_oli",["9Rnd_45ACP_Mag","ClaymoreDirectionalMine_Remote_Mag","APERSTripMine_Wire_Mag","MiniGrenade","MiniGrenade","I_IR_Grenade","I_IR_Grenade","SmokeShell","SmokeShellGreen","SmokeShellOrange","SmokeShellPurple","Chemlight_green","Chemlight_green"]],["",[]],"","","Laserdesignator_03",["arifle_Mk20_F",["","","optic_MRCO",""],"30Rnd_556x45_Stanag"],["",["","","",""],""],["hgun_ACPC2_F",["muzzle_snds_acp","","",""],"9Rnd_45ACP_Mag"],["ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","NVGoggles_INDEP"],["WhiteHead_11","male04gre",""]],"NATO Rifleman",[["U_C_Commoner1_1",[]],["",[]],["",[]],"","","",["",["","","",""],""],["",["","","",""],""],["",["","","",""],""],["ItemMap","ItemCompass","ItemWatch"],["WhiteHead_11","male04gre",""]],"NATO Team Leader",[["U_I_GhillieSuit",["FirstAidKit","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","9Rnd_45ACP_Mag"]],["V_Chestrig_oli",["9Rnd_45ACP_Mag","ClaymoreDirectionalMine_Remote_Mag","APERSTripMine_Wire_Mag","MiniGrenade","MiniGrenade","I_IR_Grenade","I_IR_Grenade","SmokeShell","SmokeShellGreen","SmokeShellOrange","SmokeShellPurple","Chemlight_green","Chemlight_green"]],["",[]],"","","Laserdesignator_03",["arifle_Mk20_F",["","","optic_MRCO",""],"30Rnd_556x45_Stanag"],["",["","","",""],""],["hgun_ACPC2_F",["muzzle_snds_acp","","",""],"9Rnd_45ACP_Mag"],["ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","NVGoggles_INDEP"],["WhiteHead_11","male04gre",""]],"Test",[["U_C_Man_casual_3_F",[]],["",[]],["",[]],"","","",["",["","","",""],""],["",["","","",""],""],["",["","","",""],""],["ItemMap","ItemCompass","ItemWatch"],["WhiteHead_11","male04gre",""]],"Template",[["U_B_T_Soldier_F",["FirstAidKit","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag"]],["V_PlateCarrier1_tna_F",["30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","16Rnd_9x21_Mag","16Rnd_9x21_Mag","HandGrenade","HandGrenade","SmokeShell","SmokeShellGreen","Chemlight_green","Chemlight_green"]],["",[]],"H_HelmetB_tna_F","","",["arifle_MXM_khk_F",["","acc_pointer_IR","optic_SOS_khk_F","bipod_01_F_khk"],"30Rnd_65x39_caseless_mag"],["",["","","",""],""],["hgun_P07_khk_F",["","","",""],"16Rnd_9x21_Mag"],["ItemMap","ItemCompass","ItemWatch","ItemRadio","NVGoggles_tna_F"],["WhiteHead_11","male04gre",""]]]
