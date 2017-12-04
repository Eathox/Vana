///////////////////////////////////////////////////////////////////////////////////////////
//Code directly taken from BIS_fnc_arsenal

disableserialization;

#define CONDITION(LIST)	(_FullVersion || {"%ALL" in LIST} || {{_Item == _x} count LIST > 0}) //Dirrectly taken from BIS_fnc_arsenal

#define GETVIRTUALCARGO\
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
		_weapon = _x call bis_fnc_baseWeapon;\
		_virtualWeaponCargo set [count _virtualWeaponCargo,_weapon];\
		{\
			private ["_Item"];\
			_Item = gettext (_x >> "item");\
			if !(_Item in _virtualItemCargo) then {_virtualItemCargo set [count _virtualItemCargo,_Item];};\
		} foreach ((configfile >> "cfgweapons" >> _x >> "linkeditems") call bis_fnc_returnchildren);\
	} foreach ((missionnamespace call bis_fnc_getVirtualWeaponCargo) + (_Cargo call bis_fnc_getVirtualWeaponCargo) + weapons _Center + [binocular _Center]);\
	_virtualMagazineCargo = (missionnamespace call bis_fnc_getVirtualMagazineCargo) + (_Cargo call bis_fnc_getVirtualMagazineCargo) + magazines _Center;\
	_virtualBackpackCargo = (missionnamespace call bis_fnc_getVirtualBackpackCargo) + (_Cargo call bis_fnc_getVirtualBackpackCargo) + [backpack _Center]; //Dirrectly taken from BIS_fnc_arsenal

_FullVersion = missionnamespace getvariable ["BIS_fnc_arsenal_fullArsenal",false];
_LoadoutData = profilenamespace getvariable ["bis_fnc_saveInventory_Data",[]];
_Center = (missionnamespace getvariable ["BIS_fnc_arsenal_Center",player]);
_Cargo = (missionnamespace getvariable ["BIS_fnc_arsenal_Cargo",objnull]);

///////////////////////////////////////////////////////////////////////////////////////////
//VANA Function (Half of it is still just BIS code)

params
[
	["_CtrlTreeView", controlnull, [controlnull]], //Gets Treeview control
	["_TargetTabOriginal", [], [[]]], //Optional TargetTab
	["_LoadoutName", []], //Name of loadout to be loaded (Required for TargetTab)
	//Makes more private varibales but does not define em
	"_TargetTab",
	"_Inventory",
	"_InventoryWeapons",
	"_InventoryMagazines",
	"_InventoryItems",
	"_InventoryBackpacks",
	"_LoadoutAdd"
];

if (isnull _CtrlTreeView) exitwith //Checks if Required value is empty
{
	diag_log text "[VANA_fnc_ShowVirtualLoadouts]: No TreeView Control Was Given, Aborting Function.";
	False; //Returns false meaning the function dint execute
};

if ((_TargetTabOriginal isequalto [])&&(_LoadoutName isequalto [])) exitwith //Checks if both Optional TargetTab and Name of loadout are empty (Meaning all loadouts have to be loaded)
{
	TvClear _CtrlTreeView; //Clears Treeview
	{
		[_CtrlTreeView, [], _x] call VANA_fnc_ShowVirtualLoadouts; //Calls this function with specific name
	} foreach (_LoadoutData select {_x isequaltype ""}); //Loops Code bassed size of Saved Data, so the code under it gets executed for every data Array
	"Cleared and Reloaded"; //Returns "Clear" meaning _CtrlTreeView was clearded and reloaded (With not tabs that is)
};

If !(_LoadoutName isEqualType "") exitwith //Checks if loadout name was not given
{
	diag_log text format ["[VANA_fnc_ShowVirtualLoadouts]: No prober LoadoutName (%1) Was Given, Aborting Function.",_LoadoutName];
	False; //Returns false meaning the function dint execute
};

if ((_LoadoutData find _LoadoutName) < 0) exitwith
{
	diag_log text format ["[VANA_fnc_ShowVirtualLoadouts]: Loadout: %1 doesnt exsit, Aborting Function.",_LoadoutName];
  False; //Returns false meaning the function dint execute
};

GETVIRTUALCARGO

_TargetTab = +_TargetTabOriginal; //Duplicates _TargetTabOriginal so it doesnt get redefined
_LoadoutName = _LoadoutData select (_LoadoutData find _LoadoutName); //Gets specific loadout location (In data)
_Inventory = _LoadoutData select ((_LoadoutData find _LoadoutName) + 1);

_InventoryWeapons = [
	(_Inventory select 5), //--- Binocular
	(_Inventory select 6 select 0), //--- Primary weapon
	(_Inventory select 7 select 0), //--- Secondary weapon
	(_Inventory select 8 select 0) //--- Handgun
] - [""];
_InventoryMagazines = (
	(_Inventory select 0 select 1) + //--- Uniform
	(_Inventory select 1 select 1) + //--- Vest
	(_Inventory select 2 select 1) //--- Backpack items
) - [""];
_InventoryItems = (
	[_Inventory select 0 select 0] + (_Inventory select 0 select 1) + //--- Uniform
	[_Inventory select 1 select 0] + (_Inventory select 1 select 1) + //--- Vest
	(_Inventory select 2 select 1) + //--- Backpack items
	[_Inventory select 3] + //--- Headgear
	[_Inventory select 4] + //--- Goggles
	(_Inventory select 6 select 1) + //--- Primary weapon items
	(_Inventory select 7 select 1) + //--- Secondary weapon items
	(_Inventory select 8 select 1) + //--- Handgun items
	(_Inventory select 9) //--- Assigned items
) - [""];
_InventoryBackpacks = [_Inventory select 2 select 0] - [""];

_LoadoutAdd = _CtrlTreeView tvAdd [_TargetTab,_LoadoutName]; //Creates New SubTv for Loadout
_TargetTab pushback _LoadoutAdd; //Adds Child to parent array

//_CtrlTreeView tvSetPicture [_TargetTab, getText (configfile >> "CfgDiary" >> "Icons" >> "taskFailed")];
//_CtrlTreeView tvSetPicture [_TargetTab, "\a3\ui_f\data\IGUI\Cfg\Actions\Obsolete\ui_action_gear_ca.paa"];

_CtrlTreeView tvSetData [_TargetTab, "tvloadout"]; //Set Data of new SubTv
_CtrlTreeView tvSetValue [_TargetTab, 0];

if (
	{_Item = _x; !CONDITION(_VirtualWeaponCargo) || !isclass(configfile >> "cfgweapons" >> _Item)} count _InventoryWeapons > 0
	||
	{_Item = _x; !CONDITION(_VirtualItemCargo + _VirtualMagazineCargo) || {isclass(configfile >> _x >> _Item)} count ["cfgweapons","cfgglasses","cfgmagazines"] == 0} count _InventoryMagazines > 0
	||
	{_Item = _x; !CONDITION(_VirtualItemCargo + _VirtualMagazineCargo) || {isclass(configfile >> _x >> _Item)} count ["cfgweapons","cfgglasses","cfgmagazines"] == 0} count _InventoryItems > 0
	||
	{_Item = _x; !CONDITION(_VirtualBackpackCargo) || !isclass(configfile >> "cfgvehicles" >> _Item)} count _InventoryBackpacks > 0
) then {
	_CtrlTreeView tvSetColor [_TargetTab,[1,1,1,0.25]]; //Makes loadout Grey in TreeView so user knowns it has items they dont have acces to
	_CtrlTreeView tvSetValue [_TargetTab,-1]; //Set Value to -1 so load button is disabled on it (That function is in BIS arsenal code)
};

_CtrlTreeView tvExpand _TargetTabOriginal; //Expands parent for nicer visuals
_CtrlTreeView tvSetCurSel ([_CtrlTreeView,_LoadoutName,_TargetTabOriginal,"tvloadout"] call VANA_fnc_TreeViewGetPosition);

[_TargetTab,_LoadoutName]; //Returns Path and Name of loaded loadout
