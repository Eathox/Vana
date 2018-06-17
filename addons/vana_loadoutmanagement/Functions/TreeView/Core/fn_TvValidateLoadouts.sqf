disableserialization;

#include "\vana_LoadoutManagement\UI\defineDIKCodes.inc"
#include "\vana_LoadoutManagement\UI\defineResinclDesign.inc"

#define CONDITION(LIST)	(_FullVersion || {"%ALL" in LIST} || {{_Item == _x} count LIST > 0})

#define GETVIRTUALCARGO\
	private ["_virtualItemCargo","_virtualWeaponCargo","_virtualMagazineCargo","_virtualBackpackCargo"];\
	_virtualItemCargo =\
		(missionnamespace call bis_fnc_getVirtualItemCargo) +\
		(_Cargo call bis_fnc_getVirtualItemCargo) +\
		items _Center +\
		assigneditems _Center +\
		primaryweaponitems _Center +\
		secondaryweaponitems _Center +\
		handgunitems _Center +\
		[uniform _Center,vest _Center,headgear _Center,goggles _Center];\
	_virtualWeaponCargo = [];\
	{\
		private ["_weapon"];\
		_weapon = _x call bis_fnc_baseWeapon;\
		_virtualWeaponCargo set [count _virtualWeaponCargo,_weapon];\
		{\
			private ["_Item"];\
			_Item = gettext (_x >> "item");\
			if !(_Item in _virtualItemCargo) then {_virtualItemCargo set [count _virtualItemCargo,_Item];};\
		} foreach ((configfile >> "cfgweapons" >> _x >> "linkeditems") call bis_fnc_returnchildren);\
	} foreach ((missionnamespace call bis_fnc_getVirtualWeaponCargo) + (_Cargo call bis_fnc_getVirtualWeaponCargo) + weapons _Center + [binocular _Center]);\
	_virtualMagazineCargo = (missionnamespace call bis_fnc_getVirtualMagazineCargo) + (_Cargo call bis_fnc_getVirtualMagazineCargo) + magazines _Center;\
	_virtualBackpackCargo = (missionnamespace call bis_fnc_getVirtualBackpackCargo) + (_Cargo call bis_fnc_getVirtualBackpackCargo) + [backpack _Center];

#define MarkTv(BOOL)\
	private _LoadoutPosistion = _x select 1;\
	_CtrlTreeView tvSetColor [_LoadoutPosistion, ([[1,1,1,0.25], [0.95,0.95,0.95,1]] select BOOL)];\
	_CtrlTreeView tvSetValue [_LoadoutPosistion, ([-1, 0] select BOOL)];\
	True

params
[
	["_ArsenalDisplay", displaynull, [displaynull]],
	["_TargetLoadouts", [], [[]]],
	"_CtrlTreeView",
	"_FullVersion",
	"_LoadoutData",
	"_Center",
	"_Cargo"
];

_CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
_FullVersion = missionnamespace getvariable ["BIS_fnc_arsenal_fullArsenal", false];
_LoadoutData = profilenamespace getvariable ["bis_fnc_saveInventory_Data", []];
_Center = (missionnamespace getvariable ["BIS_fnc_arsenal_Center", player]);
_Cargo = (missionnamespace getvariable ["BIS_fnc_arsenal_Cargo", objnull]);

GETVIRTUALCARGO
{
	Params ["_LoadoutName","_InventoryData","_InventoryDataWeapons","_InventoryDataMagazines","_InventoryDataItems","_InventoryDataBackpacks"];
	_LoadoutName = _x select 0;

	if (_LoadoutName in _LoadoutData) then
	{
		//First Phase Validation
		_InventoryData = _LoadoutData select ((_LoadoutData find _LoadoutName) + 1);
		_InventoryDataWeapons =
		[
			(_InventoryData select 5), //Binocular
			(_InventoryData select 6 select 0), //Primary weapon
			(_InventoryData select 7 select 0), //Secondary weapon
			(_InventoryData select 8 select 0) //Handgun
		] - [""];

		if ({_Item = _x; !CONDITION(_VirtualWeaponCargo) || !isclass(configfile >> "cfgweapons" >> _Item)} count _InventoryDataWeapons > 0) exitwith {MarkTv(False)};

		//Second Phase Validation
		_InventoryDataMagazines =
		(
			(_InventoryData select 0 select 1) + //Uniform
			(_InventoryData select 1 select 1) + //Vest
			(_InventoryData select 2 select 1) //Backpack items
		) - [""];

		if ({_Item = _x; !CONDITION(_VirtualItemCargo + _VirtualMagazineCargo) || {isclass(configfile >> _x >> _Item)} count ["cfgweapons","cfgglasses","cfgmagazines"] == 0} count _InventoryDataMagazines > 0) exitwith {MarkTv(False)};

		//Third Phase Validation
		_InventoryDataItems =
		(
			[_InventoryData select 0 select 0] + (_InventoryData select 0 select 1) + //Uniform
			[_InventoryData select 1 select 0] + (_InventoryData select 1 select 1) + //Vest
			(_InventoryData select 2 select 1) + //Backpack items
			[_InventoryData select 3] + //Headgear
			[_InventoryData select 4] + //Goggles
			(_InventoryData select 6 select 1) + //Primary weapon items
			(_InventoryData select 7 select 1) + //Secondary weapon items
			(_InventoryData select 8 select 1) + //Handgun items
			(_InventoryData select 9) //Assigned items
		) - [""];

		if ({_Item = _x; !CONDITION(_VirtualItemCargo + _VirtualMagazineCargo) || {isclass(configfile >> _x >> _Item)} count ["cfgweapons","cfgglasses","cfgmagazines"] == 0} count _InventoryDataItems > 0) exitwith {MarkTv(False)};

		//Forth Phase Validation
		_InventoryDataBackpacks = [_InventoryData select 2 select 0] - [""];

		if ({_Item = _x; !CONDITION(_VirtualBackpackCargo) || !isclass(configfile >> "cfgvehicles" >> _Item)} count _InventoryDataBackpacks > 0) exitwith {MarkTv(False)};

		MarkTv(True)
	};

	false
} count _TargetLoadouts;

[False, True] select !(_TargetLoadouts isequalto []);
