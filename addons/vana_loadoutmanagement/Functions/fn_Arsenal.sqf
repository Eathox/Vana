//an edited version of BIS_fnc_arsenal - (All Changes marked with "VANA")

#include "\A3\ui_f\hpp\defineDIKCodes.inc"
#include "\A3\Ui_f\hpp\defineResinclDesign.inc"

disableserialization;

_mode = [_this,0,"Open",[displaynull,""]] call bis_fnc_param;
_this = [_this,1,[]] call bis_fnc_param;
_fullVersion = missionnamespace getvariable ["BIS_fnc_arsenal_fullArsenal",false];

#define IDCS_LEFT\
	IDC_RSCDISPLAYARSENAL_TAB_PRIMARYWEAPON,\
	IDC_RSCDISPLAYARSENAL_TAB_SECONDARYWEAPON,\
	IDC_RSCDISPLAYARSENAL_TAB_HANDGUN,\
	IDC_RSCDISPLAYARSENAL_TAB_UNIFORM,\
	IDC_RSCDISPLAYARSENAL_TAB_VEST,\
	IDC_RSCDISPLAYARSENAL_TAB_BACKPACK,\
	IDC_RSCDISPLAYARSENAL_TAB_HEADGEAR,\
	IDC_RSCDISPLAYARSENAL_TAB_GOGGLES,\
	IDC_RSCDISPLAYARSENAL_TAB_NVGS,\
	IDC_RSCDISPLAYARSENAL_TAB_BINOCULARS,\
	IDC_RSCDISPLAYARSENAL_TAB_MAP,\
	IDC_RSCDISPLAYARSENAL_TAB_GPS,\
	IDC_RSCDISPLAYARSENAL_TAB_RADIO,\
	IDC_RSCDISPLAYARSENAL_TAB_COMPASS,\
	IDC_RSCDISPLAYARSENAL_TAB_WATCH,\
	IDC_RSCDISPLAYARSENAL_TAB_FACE,\
	IDC_RSCDISPLAYARSENAL_TAB_VOICE,\
	IDC_RSCDISPLAYARSENAL_TAB_INSIGNIA

#define IDCS_RIGHT\
	IDC_RSCDISPLAYARSENAL_TAB_ITEMOPTIC,\
	IDC_RSCDISPLAYARSENAL_TAB_ITEMACC,\
	IDC_RSCDISPLAYARSENAL_TAB_ITEMMUZZLE,\
	IDC_RSCDISPLAYARSENAL_TAB_ITEMBIPOD,\
	IDC_RSCDISPLAYARSENAL_TAB_CARGOMAG,\
	IDC_RSCDISPLAYARSENAL_TAB_CARGOMAGALL,\
	IDC_RSCDISPLAYARSENAL_TAB_CARGOTHROW,\
	IDC_RSCDISPLAYARSENAL_TAB_CARGOPUT,\
	IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC\

#define IDCS	[IDCS_LEFT,IDCS_RIGHT]

#define INITTYPES\
	_types = [];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_UNIFORM,["Uniform"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_VEST,["Vest"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_BACKPACK,["Backpack"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_HEADGEAR,["Headgear"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_GOGGLES,["Glasses"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_NVGS,["NVGoggles"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_BINOCULARS,["Binocular","LaserDesignator"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_PRIMARYWEAPON,["AssaultRifle","MachineGun","SniperRifle","Shotgun","Rifle","SubmachineGun"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_SECONDARYWEAPON,["Launcher","MissileLauncher","RocketLauncher"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_HANDGUN,["Handgun"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_MAP,["Map"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_GPS,["GPS","UAVTerminal"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_RADIO,["Radio"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_COMPASS,["Compass"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_WATCH,["Watch"]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_FACE,[]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_VOICE,[]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_INSIGNIA,[]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_ITEMOPTIC,[]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_ITEMACC,[]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_ITEMMUZZLE,[]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_ITEMBIPOD,[]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_CARGOMAG,[]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_CARGOMAGALL,[]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_CARGOTHROW,[/*"Grenade","SmokeShell"*/]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_CARGOPUT,[/*"Mine","MineBounding","MineDirectional"*/]];\
	_types set [IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC,["FirstAidKit","Medikit","MineDetector","Toolkit"]];

#define STATS_WEAPONS\
	["reloadtime","dispersion","maxzeroing","hit","mass","initSpeed"],\
	[true,true,false,true,false,false]

#define STATS_EQUIPMENT\
	["passthrough","armor","maximumLoad","mass"],\
	[false,false,false,false]

switch _mode do {

	///////////////////////////////////////////////////////////////////////////////////////////
	Default {[_mode,_this] call BIS_fnc_arsenal;};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "Exit": {
		[_this select 0, _mode] call VANA_fnc_arsenaltreeview;
		[_mode,_this] call BIS_fnc_arsenal;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "Init": {
		["bis_fnc_arsenal"] call bis_fnc_startloadingscreen;
		_display = _this select 0;
		_toggleSpace = uinamespace getvariable ["BIS_fnc_arsenal_toggleSpace",false];
		_center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
		BIS_fnc_arsenal_type = 0; //--- 0 - Arsenal, 1 - Garage
		BIS_fnc_arsenal_toggleSpace = nil;

		if !(is3DEN) then {
			if (_fullVersion) then {
				if (missionname == "Arsenal") then {
					moveout player;
					player switchaction "playerstand";
					[player,0] call bis_fnc_setheight;
				};

				//--- Default appearance (only at the mission start)
				if (time < 1) then {
					_defaultArray = uinamespace getvariable ["bis_fnc_arsenal_defaultClass",[]];
					_defaultClass = [_defaultArray,0,"",[""]] call bis_fnc_paramin;
					if (isclass (configfile >> "cfgvehicles" >> _defaultClass)) then {

						//--- Load specific class (e.g., when defined by mod browser)
						[player,_defaultClass] call bis_fnc_loadinventory;

						_defaultItems = [_defaultArray,1,[],[[]]] call bis_fnc_paramin;
						_defaultShow = [_defaultArray,2,-1,[0]] call bis_fnc_paramin;
						uinamespace setvariable ["bis_fnc_arsenal_defaultItems",_defaultItems];
						uinamespace setvariable ["bis_fnc_arsenal_defaultShow",_defaultShow];
					} else {
						//--- Randomize default loadout
						_soldiers = [];
						{
							_soldiers pushback (configname _x);
						} foreach ("isclass _x && getnumber (_x >> 'scope') > 1 && gettext (_x >> 'simulation') == 'soldier'" configclasses (configfile >> "cfgvehicles"));
						[player,_soldiers call bis_fnc_selectrandom] call bis_fnc_loadinventory;
					};
					player switchMove "";
					uinamespace setvariable ["bis_fnc_arsenal_defaultClass",nil];
				};
			};
		};

		INITTYPES
		["InitGUI",[_display,"bis_fnc_arsenal"]] call VANA_fnc_arsenal; //VANA
		["Preload"] call BIS_fnc_arsenal;
		["ListAdd",[_display]] call BIS_fnc_arsenal;
		["ListSelectCurrent",[_display]] call BIS_fnc_arsenal;

		//VANA Init
		call
		{
			[_display, "Init"] call VANA_fnc_ArsenalTreeView;

			if !(_display getvariable ["Vana_Initialised", False]) exitwith {};

			[_display, "Init"] call VANA_fnc_UIPopup;
			[_display, "Init"] call VANA_fnc_OptionsMenu;
		};

		//--- Save default weapon type
		BIS_fnc_arsenal_selectedWeaponType = switch true do {
			case (currentweapon _center == primaryweapon _center): {0};
			case (currentweapon _center == secondaryweapon _center): {1};
			case (currentweapon _center == handgunweapon _center): {2};
			default {-1};
		};

		//--- Load stats
		if (isnil {uinamespace getvariable "bis_fnc_arsenal_weaponStats"}) then {
			uinamespace setvariable [
				"bis_fnc_arsenal_weaponStats",
				[
					("isclass _x && getnumber (_x >> 'scope') == 2 && getnumber (_x >> 'type') < 5") configclasses (configfile >> "cfgweapons"),
					STATS_WEAPONS
				] call bis_fnc_configExtremes
			];
		};
		if (isnil {uinamespace getvariable "bis_fnc_arsenal_equipmentStats"}) then {
			_statsEquipment = [
				("isclass _x && getnumber (_x >> 'scope') == 2 && getnumber (_x >> 'itemInfo' >> 'type') in [605,701,801]") configclasses (configfile >> "cfgweapons"),
				STATS_EQUIPMENT
			] call bis_fnc_configExtremes;
			_statsBackpacks = [
				("isclass _x && getnumber (_x >> 'scope') == 2 && getnumber (_x >> 'isBackpack') == 1") configclasses (configfile >> "cfgvehicles"),
				STATS_EQUIPMENT
			] call bis_fnc_configExtremes;

			_statsEquipmentMin = _statsEquipment select 0;
			_statsEquipmentMax = _statsEquipment select 1;
			_statsBackpacksMin = _statsBackpacks select 0;
			_statsBackpacksMax = _statsBackpacks select 1;
			for "_i" from 2 to 3 do { //--- Ignore backpack armor and passThrough, has no effect
				_statsEquipmentMin set [_i,(_statsEquipmentMin select _i) min (_statsBackpacksMin select _i)];
				_statsEquipmentMax set [_i,(_statsEquipmentMax select _i) max (_statsBackpacksMax select _i)];
			};

			uinamespace setvariable ["bis_fnc_arsenal_equipmentStats",[_statsEquipmentMin,_statsEquipmentMax]];
		};

		with missionnamespace do {
			[missionnamespace,"arsenalOpened",[_display,_toggleSpace]] call bis_fnc_callscriptedeventhandler;
		};
		["bis_fnc_arsenal"] call bis_fnc_endloadingscreen;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "InitGUI": {
		_display = _this select 0;
		_function = _this select 1;
		BIS_fnc_arsenal_display = _display;
		BIS_fnc_arsenal_mouse = [0,0];
		BIS_fnc_arsenal_buttons = [[],[]];
		BIS_fnc_arsenal_action = "";
		_center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
		_center hideobject false;
		cuttext ["","plain"];
		showcommandingmenu "";
		//["#(argb,8,8,3)color(0,0,0,1)",false,nil,0.1,[0,0.5]] spawn bis_fnc_textTiles;

		//--- Force internal view to enable consistent screen blurring. Restore the original view after closing Arsenal.
		BIS_fnc_arsenal_cameraview = cameraview;
		player switchcamera "internal";

		showhud false;

		if (is3DEN) then {
			_centerOrig = _center;
			_centerPos = position _centerOrig;
			_centerPos set [2,500];
			_sphere = createvehicle ["Sphere_3DEN",_centerPos,[],0,"none"];
			_sphere setposatl _centerPos;
			_sphere setdir 0;
			_sphere setobjecttexture [0,"#(argb,8,8,3)color(0.93,1.0,0.98,0.028,co)"];
			_sphere setobjecttexture [1,"#(argb,8,8,3)color(0.93,1.0,0.98,0.01,co)"];
			_center = if (_function == "bis_fnc_arsenal") then {
				createagent [typeof _centerOrig,position _centerOrig,[],0,"none"]
			} else {
				createvehicle [typeof _centerOrig,position _centerOrig,[],0,"none"]
			};
			_center setposatl getposatl _sphere;//[getposatl _sphere select 0,getposatl _sphere select 1,(getposatl _sphere select 2) - 4];
			_center setdir 0;
			_center switchmove animationstate _centerOrig;
			_center switchaction "playerstand";
			if (_function == "bis_fnc_arsenal") then {
				_inventory = [_centerOrig,[_center,"arsenal"]] call bis_fnc_saveInventory;
				[_center,[_center,"arsenal"]] call bis_fnc_loadInventory;
				_face = face _centerOrig;
				_center setface _face;
			} else {
				{
					_center setobjecttexture [_foreachindex,_x];
				} foreach getobjecttextures _centerOrig;
				{
					_configname = configname _x;
					_center animate [_configname,_centerOrig animationphase _configname,true];
					[_center, _centerOrig animationphase _configname] call compile (getText(configfile >> "CfgVehicles" >> typeOf _center >> "AnimationSources" >> _configname >> "onPhaseChanged"));
				} foreach configproperties [configfile >> "cfgvehicles" >> typeof _center >> "animationsources","isclass _x"];
			};
			_center enablesimulation false;

			//--- Create light for night editing (code based on BIS_fnc_3DENFlashlight)
			_intensity = 20;
			_light = "#lightpoint" createvehicle _centerPos;
			_light setlightbrightness _intensity;
			_light setlightambient [1,1,1];
			_light setlightcolor [0,0,0];
			_light lightattachobject [_sphere,[0,0,-_intensity * 7]];

			//--- Save to global variables, so it can be deleted latger
			missionnamespace setvariable ["BIS_fnc_arsenal_light",_light];
			missionnamespace setvariable ["BIS_fnc_arsenal_centerOrig",_centerOrig];
			missionnamespace setvariable ["BIS_fnc_arsenal_center",_center];
			missionnamespace setvariable ["BIS_fnc_arsenal_sphere",_sphere];

			//--- Use the same vision mode as in Eden
			missionnamespace setvariable ["BIS_fnc_arsenal_visionMode",-2 call bis_fnc_3DENVisionMode];
			["ShowInterface",false] spawn bis_fnc_3DENInterface;
			if (get3denactionstate "togglemap" > 0) then {do3DENAction "togglemap";};
		};

		_display displayaddeventhandler ["mousebuttondown","with uinamespace do {['MouseButtonDown',_this] call BIS_fnc_arsenal;};"];
		_display displayaddeventhandler ["mousebuttonup","with uinamespace do {['MouseButtonUp',_this] call BIS_fnc_arsenal;};"];
		//_display displayaddeventhandler ["mousezchanged","with uinamespace do {['MouseZChanged',_this] call BIS_fnc_arsenal;};"];
		//_display displayaddeventhandler ["keydown","with (uinamespace) do {['KeyDown',_this] call BIS_fnc_arsenal;};"]; //VANA - Disabled this
		//_display displayaddeventhandler ["mousemoving","with (uinamespace) do {['Loop',_this] call BIS_fnc_arsenal;};"];
		//_display displayaddeventhandler ["mouseholding","with (uinamespace) do {['Loop',_this] call BIS_fnc_arsenal;};"];

		_ctrlMouseArea = _display displayctrl IDC_RSCDISPLAYARSENAL_MOUSEAREA;
		_ctrlMouseArea ctrladdeventhandler ["mousemoving","with uinamespace do {['Mouse',_this] call BIS_fnc_arsenal;};"];
		_ctrlMouseArea ctrladdeventhandler ["mouseholding","with uinamespace do {['Mouse',_this] call BIS_fnc_arsenal;};"];
		_ctrlMouseArea ctrladdeventhandler ["mousebuttonclick","with uinamespace do {['TabDeselect',[ctrlparent (_this select 0),_this select 1]] call BIS_fnc_arsenal;};"];
		_ctrlMouseArea ctrladdeventhandler ["mousezchanged","with uinamespace do {['MouseZChanged',_this] call BIS_fnc_arsenal;};"];
		ctrlsetfocus _ctrlMouseArea;

		_ctrlMouseBlock = _display displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;
		_ctrlMouseBlock ctrlenable false;
		_ctrlMouseBlock ctrladdeventhandler ["setfocus",{_this spawn {disableserialization; (_this select 0) ctrlenable false; (_this select 0) ctrlenable true;};}];

		_ctrlMessage = _display displayctrl IDC_RSCDISPLAYARSENAL_MESSAGE;
		_ctrlMessage ctrlsetfade 1;
		_ctrlMessage ctrlcommit 0;

		_ctrlInfo = _display displayctrl IDC_RSCDISPLAYARSENAL_INFO_INFO;
		_ctrlInfo ctrlsetfade 1;
		_ctrlInfo ctrlcommit 0;

		_ctrlStats = _display displayctrl IDC_RSCDISPLAYARSENAL_STATS_STATS;
		_ctrlStats ctrlsetfade 1;
		_ctrlStats ctrlenable false;
		_ctrlStats ctrlcommit 0;

		//--- UI event handlers
		_ctrlButtonInterface = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONINTERFACE;
		_ctrlButtonInterface ctrladdeventhandler ["buttonclick","with uinamespace do {['buttonInterface',[ctrlparent (_this select 0)]] call BIS_fnc_arsenal;};"];

		_ctrlButtonRandom = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONRANDOM;
		_ctrlButtonRandom ctrladdeventhandler ["buttonclick",format ["with uinamespace do {['buttonRandom',[ctrlparent (_this select 0)]] call %1;};",_function]];

		_ctrlButtonSave = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONSAVE;
		//_ctrlButtonSave ctrladdeventhandler ["buttonclick","with uinamespace do {['buttonSave',[ctrlparent (_this select 0)]] call BIS_fnc_arsenal;};"]; VANA - Disabled this

		_ctrlButtonLoad = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONLOAD;
		//_ctrlButtonLoad ctrladdeventhandler ["buttonclick","with uinamespace do {['buttonLoad',[ctrlparent (_this select 0)]] call BIS_fnc_arsenal;};"]; VANA - Disabled this

		_ctrlButtonExport = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONEXPORT;
		_ctrlButtonExport ctrladdeventhandler ["buttonclick",format ["with uinamespace do {['buttonExport',[ctrlparent (_this select 0),'init']] call %1;};",_function]];
		_ctrlButtonExport ctrlenable !ismultiplayer;

		_ctrlButtonImport = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONIMPORT;
		_ctrlButtonImport ctrladdeventhandler ["buttonclick",format ["with uinamespace do {['buttonImport',[ctrlparent (_this select 0),'init']] call %1;};",_function]];

		_ctrlButtonOK = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONOK;
		_ctrlButtonOK ctrladdeventhandler ["buttonclick",format ["with uinamespace do {['buttonOK',[ctrlparent (_this select 0),'init']] call %1;};",_function]];

		_ctrlButtonTry = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONTRY;
		_ctrlButtonTry ctrladdeventhandler ["buttonclick","with uinamespace do {['buttonTry',[ctrlparent (_this select 0)]] call bis_fnc_garage;};"];

		_ctrlArrowLeft = _display displayctrl IDC_RSCDISPLAYARSENAL_ARROWLEFT;
		_ctrlArrowLeft ctrladdeventhandler ["buttonclick","with uinamespace do {['buttonCargo',[ctrlparent (_this select 0),-1]] call BIS_fnc_arsenal;};"];

		_ctrlArrowRight = _display displayctrl IDC_RSCDISPLAYARSENAL_ARROWRIGHT;
		_ctrlArrowRight ctrladdeventhandler ["buttonclick","with uinamespace do {['buttonCargo',[ctrlparent (_this select 0),+1]] call BIS_fnc_arsenal;};"];


		_ctrlTemplateButtonOK = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK;
		// _ctrlTemplateButtonOK ctrladdeventhandler ["buttonclick",format ["with uinamespace do {['buttonTemplateOK',[ctrlparent (_this select 0)]] call %1;};",_function]]; VANA - Disabled this


		_ctrlTemplateButtonCancel = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONCANCEL;
		_ctrlTemplateButtonCancel ctrladdeventhandler ["buttonclick","with uinamespace do {['buttonTemplateCancel',[ctrlparent (_this select 0)]] call BIS_fnc_arsenal;};"];


		_ctrlTemplateButtonDelete = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONDELETE;
		//_ctrlTemplateButtonDelete ctrladdeventhandler ["buttonclick","with uinamespace do {['buttonTemplateDelete',[ctrlparent (_this select 0)]] call BIS_fnc_arsenal;};"]; VANA - Disabled this

		_ctrlTemplateValue = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		/* VANA - Disabled this
		_ctrlTemplateValue ctrladdeventhandler ["lbselchanged","with uinamespace do {['templateSelChanged',[ctrlparent (_this select 0)]] call BIS_fnc_arsenal;};"];
		_ctrlTemplateValue ctrladdeventhandler ["lbdblclick",format ["with uinamespace do {['buttonTemplateOK',[ctrlparent (_this select 0)]] call %1;};",_function]];
		*/

		//--- Menus
		_ctrlIcon = _display displayctrl IDC_RSCDISPLAYARSENAL_TAB;
		_sortValues = uinamespace getvariable ["bis_fnc_arsenal_sort",[]];
		if !(isnull _ctrlIcon) then {
			_ctrlIconPos = ctrlposition _ctrlIcon;
			_ctrlTabs = _display displayctrl IDC_RSCDISPLAYARSENAL_TABS;
			_ctrlTabsPos = ctrlposition _ctrlTabs;
			_ctrlTabsPosX = _ctrlTabsPos select 0;
			_ctrlTabsPosY = _ctrlTabsPos select 1;
			_ctrlIconPosW = _ctrlIconPos select 2;
			_ctrlIconPosH = _ctrlIconPos select 3;
			_columns = (_ctrlTabsPos select 2) / _ctrlIconPosW;
			_rows = (_ctrlTabsPos select 3) / _ctrlIconPosH;
			_gridH = ctrlposition _ctrlTemplateButtonOK select 3;

			{
				_idc = _x;
				_ctrlIcon = _display displayctrl (IDC_RSCDISPLAYARSENAL_ICON + _idc);
				_ctrlTab = _display displayctrl (IDC_RSCDISPLAYARSENAL_TAB + _idc);
				_mode = if (_idc in [IDCS_LEFT]) then {"TabSelectLeft"} else {"TabSelectRight"};
				{
					_x ctrladdeventhandler ["buttonclick",format ["with uinamespace do {['%2',[ctrlparent (_this select 0),%1]] call %3;};",_idc,_mode,_function]];
					_x ctrladdeventhandler ["mousezchanged","with uinamespace do {['MouseZChanged',_this] call BIS_fnc_arsenal;};"];
				} foreach [_ctrlIcon,_ctrlTab];

				_sort = _sortValues param [_idc,0];
				_ctrlSort = _display displayctrl (IDC_RSCDISPLAYARSENAL_SORT + _idc);
				_ctrlSort ctrladdeventhandler ["lbselchanged",format ["with uinamespace do {['lbSort',[_this,%1]] call BIS_fnc_arsenal;};",_idc]];
				_ctrlSort lbsetcursel _sort;
				_sortValues set [_idc,_sort];

				_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _idc);
				_ctrlList ctrlenable false;
				_ctrlList ctrlsetfade 1;
				_ctrlList ctrlsetfontheight (_gridH * 0.8);
				_ctrlList ctrlcommit 0;

				_ctrlList ctrladdeventhandler ["lbselchanged",format ["with uinamespace do {['SelectItem',[ctrlparent (_this select 0),(_this select 0),%1]] call %2;};",_idc,_function]];
				_ctrlList ctrladdeventhandler ["lbdblclick",format ["with uinamespace do {['ShowItem',[ctrlparent (_this select 0),(_this select 0),%1]] spawn BIS_fnc_arsenal;};",_idc]];

				_ctrlListDisabled = _display displayctrl (IDC_RSCDISPLAYARSENAL_LISTDISABLED + _idc);
				_ctrlListDisabled ctrlenable false;

				_ctrlSort ctrlsetfade 1;
				_ctrlSort ctrlcommit 0;
			} foreach IDCS;
		};
		uinamespace setvariable ["bis_fnc_arsenal_sort",_sortValues];
		['TabDeselect',[_display,-1]] call BIS_fnc_arsenal;
		['SelectItem',[_display,controlnull,-1]] call (uinamespace getvariable _function);

		_ctrlButtonClose = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONCLOSE;
		_ctrlButtonClose ctrladdeventhandler ["buttonclick","with uinamespace do {['buttonClose',[ctrlparent (_this select 0)]] spawn BIS_fnc_arsenal;}; true"];

		if (is3DEN) then {
			_ctrlButtonClose ctrlsettext localize "STR_DISP_CANCEL";
			_ctrlButtonClose ctrlsettooltip "";
			_ctrlButtonOK ctrlsettext localize "STR_DISP_OK";
			_ctrlButtonOK ctrlsettooltip "";
		} else {
			if (missionname == "Arsenal") then {
				_ctrlButtonClose ctrlsettext localize "STR_DISP_ARCMAP_EXIT";
			};
			if (missionname != "arsenal") then {
				_ctrlButtonOK ctrlsettext "";
				_ctrlButtonOK ctrlenable false;
				_ctrlButtonOK ctrlsettooltip "";
				_ctrlButtonTry ctrlsettext "";
				_ctrlButtonTry ctrlenable false;
				_ctrlButtonTry ctrlsettooltip "";
			};
		};
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrlenable false;
			_ctrl ctrlsetfade 1;
			_ctrl ctrlcommit 0;
		} foreach [
			IDC_RSCDISPLAYARSENAL_FRAMELEFT,
			IDC_RSCDISPLAYARSENAL_FRAMERIGHT,
			IDC_RSCDISPLAYARSENAL_BACKGROUNDLEFT,
			IDC_RSCDISPLAYARSENAL_BACKGROUNDRIGHT,
			IDC_RSCDISPLAYARSENAL_LINEICON,
			IDC_RSCDISPLAYARSENAL_LINETABLEFT,
			IDC_RSCDISPLAYARSENAL_LINETABRIGHT,
			IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE
		];

		if (_fullVersion && !is3DEN) then {
			if (missionname == "Arsenal") then {
				_ctrlSpace = _display displayctrl IDC_RSCDISPLAYARSENAL_SPACE_SPACE;
				_ctrlSpace ctrlshow true;
				{
					_ctrl = _display displayctrl (_x select 0);
					_ctrlBackground = _display displayctrl (_x select 1);
					_ctrl ctrladdeventhandler ["buttonclick","with uinamespace do {['buttonSpace',_this] spawn BIS_fnc_arsenal;}; true"];
					if (_foreachindex == bis_fnc_arsenal_type) then {
						_ctrl ctrlenable false;
						_ctrl ctrlsettextcolor [1,1,1,1];
						_ctrlBackground ctrlsetbackgroundcolor [0,0,0,1];
					};
				} foreach [
					[IDC_RSCDISPLAYARSENAL_SPACE_SPACEARSENAL,IDC_RSCDISPLAYARSENAL_SPACE_SPACEARSENALBACKGROUND],
					[IDC_RSCDISPLAYARSENAL_SPACE_SPACEGARAGE,IDC_RSCDISPLAYARSENAL_SPACE_SPACEGARAGEBACKGROUND]
				];
			} else {
				_ctrlSpace = _display displayctrl IDC_RSCDISPLAYARSENAL_SPACE_SPACE;
				_ctrlSpace ctrlsetposition [-1,-1,0,0];
				_ctrlSpace ctrlcommit 0;
			};
		} else {
			{
				_tab = _x;
				{
					_ctrl = _display displayctrl (_tab + _x);
					_ctrl ctrlshow false;
					_ctrl ctrlenable false;
					_ctrl ctrlremovealleventhandlers "buttonclick";
					_ctrl ctrlremovealleventhandlers "mousezchanged";
					_ctrl ctrlremovealleventhandlers "lbselchanged";
					_ctrl ctrlremovealleventhandlers "lbdblclick";
					_ctrl ctrlsetposition [0,0,0,0];
					_ctrl ctrlcommit 0;
				} foreach [IDC_RSCDISPLAYARSENAL_TAB,IDC_RSCDISPLAYARSENAL_ICON,IDC_RSCDISPLAYARSENAL_ICONBACKGROUND];
			} foreach [
				IDC_RSCDISPLAYARSENAL_TAB_FACE,
				IDC_RSCDISPLAYARSENAL_TAB_VOICE,
				IDC_RSCDISPLAYARSENAL_TAB_INSIGNIA
			];
			_ctrlSpace = _display displayctrl IDC_RSCDISPLAYARSENAL_SPACE_SPACE;
			_ctrlSpace ctrlsetposition [-1,-1,0,0];
			_ctrlSpace ctrlcommit 0;
		};

		//--- Camera init
		_camPosVar = format ["BIS_fnc_arsenal_campos_%1",BIS_fnc_arsenal_type];
		BIS_fnc_arsenal_campos = missionnamespace getvariable [
			_camPosVar,
			uinamespace getvariable [
				_camPosVar,
				if (BIS_fnc_arsenal_type == 0) then {[5,0,0,[0,0,0.85]]} else {[10,-45,15,[0,0,-1]]}
			]
		];
		BIS_fnc_arsenal_campos = +BIS_fnc_arsenal_campos;
		_target = createagent ["Logic",position _center,[],0,"none"];
		_target attachto [_center,BIS_fnc_arsenal_campos select 3,""];
		missionnamespace setvariable ["BIS_fnc_arsenal_target",_target];

		_cam = "camera" camcreate position _center;
		_cam cameraeffect ["internal","back"];
		_cam campreparefocus [-1,-1];
		_cam campreparefov 0.35;
		_cam camcommitprepared 0;
		//cameraEffectEnableHUD true;
		showcinemaborder false;
		BIS_fnc_arsenal_cam = _cam;
		["#(argb,8,8,3)color(0,0,0,1)",false,nil,0,[0,0.5]] call bis_fnc_textTiles;

		//--- Camera reset
		["Mouse",[controlnull,0,0]] call BIS_fnc_arsenal;
		BIS_fnc_arsenal_draw3D = addMissionEventHandler ["draw3D",{with (uinamespace) do {['draw3D',_this] call BIS_fnc_arsenal;};}];

		setacctime (missionnamespace getvariable ["BIS_fnc_arsenal_acctime",1]);
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "KeyDown": {
		BIS_fnc_arsenal_type = uinamespace getvariable ["BIS_fnc_arsenal_type", 0]; //VANA

		_display = _this select 0;
		_key = _this select 1;
		_shift = _this select 2;
		_ctrl = _this select 3;
		_alt = _this select 4;
		_center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
		_return = false;
		_ctrlTemplate = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
		_inTemplate = ctrlfade _ctrlTemplate == 0;

		switch true do {
			/* VANA - Disabled this
			case (_key == DIK_ESCAPE): {
				if (_inTemplate) then {
					_ctrlTemplate ctrlsetfade 1;
					_ctrlTemplate ctrlcommit 0;
					_ctrlTemplate ctrlenable false;

					_ctrlMouseBlock = _display displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;
					_ctrlMouseBlock ctrlenable false;
				} else {
					if (_fullVersion) then {["buttonClose",[_display]] spawn BIS_fnc_arsenal;} else {_display closedisplay 2;};
				};
				_return = true;
			};

			//--- Enter
			case (_key in [DIK_RETURN,DIK_NUMPADENTER]): {
				_ctrlTemplate = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
				if (ctrlfade _ctrlTemplate == 0) then {
					if (BIS_fnc_arsenal_type == 0) then {
						["buttonTemplateOK",[_display]] spawn VANA_fnc_arsenal;
					} else {
						["buttonTemplateOK",[_display]] spawn bis_fnc_garage;
					};
					_return = true;
				};
			};
			*/

			//--- Prevent opening the commanding menu
			case (_key == DIK_1);
			case (_key == DIK_2);
			case (_key == DIK_3);
			case (_key == DIK_4);
			case (_key == DIK_5);
			case (_key == DIK_1);
			case (_key == DIK_7);
			case (_key == DIK_8);
			case (_key == DIK_9);
			case (_key == DIK_0): {
				_return = true;
			};

			//--- Tab to browse tabs
			case (_key == DIK_TAB): {
				_idc = -1;
				{
					_ctrlTab = _display displayctrl (IDC_RSCDISPLAYARSENAL_TAB + _x);
					if !(ctrlenabled _ctrlTab) exitwith {_idc = _x;};
				} foreach [IDCS_LEFT];
				_idcCount = {!isnull (_display displayctrl (IDC_RSCDISPLAYARSENAL_TAB + _x))} count [IDCS_LEFT];
				_idc = if (_ctrl) then {(_idc - 1 + _idcCount) % _idcCount} else {(_idc + 1) % _idcCount};
				if (BIS_fnc_arsenal_type == 0) then {
					["TabSelectLeft",[_display,_idc]] call BIS_fnc_arsenal;
				} else {
					["TabSelectLeft",[_display,_idc]] call bis_fnc_garage;
				};
				_return = true;
			};

			//--- Export to script
			case (_key == DIK_C): {
				_mode = if (_shift) then {"config"} else {"init"};
				if (BIS_fnc_arsenal_type == 0) then {
					if (_ctrl) then {['buttonExport',[_display,_mode]] call BIS_fnc_arsenal;};
				} else {
					if (_ctrl) then {['buttonExport',[_display,_mode]] call bis_fnc_garage;};
				};
			};
			//--- Export from script
			case (_key == DIK_V): {
				if (BIS_fnc_arsenal_type == 0) then {
					if (_ctrl) then {['buttonImport',[_display]] call BIS_fnc_arsenal;};
				} else {
					if (_ctrl) then {['buttonImport',[_display]] call bis_fnc_garage;};
				};
			};

			/* VANA - Disabled this
			//--- Save
			case (_key == DIK_S): {
				if (_ctrl) then {['buttonSave',[_display]] call VANA_fnc_arsenal;};
			};
			//--- Open
			case (_key == DIK_O): {
				if (_ctrl) then {['buttonLoad',[_display]] call VANA_fnc_arsenal;};
			};
			*/

			//--- Randomize
			case (_key == DIK_R): {
				if (_ctrl) then {
					if (BIS_fnc_arsenal_type == 0) then {
						if (_shift) then {
							_soldiers = [];
							{
								_soldiers set [count _soldiers,configname _x];
							} foreach ("isclass _x && getnumber (_x >> 'scope') > 1 && gettext (_x >> 'simulation') == 'soldier'" configclasses (configfile >> "cfgvehicles"));
							[_center,_soldiers call bis_fnc_selectrandom] call bis_fnc_loadinventory;
							_center switchmove "";
							["ListSelectCurrent",[_display]] call BIS_fnc_arsenal;
						} else {
							['buttonRandom',[_display]] call BIS_fnc_arsenal;
						};
					} else {
						['buttonRandom',[_display]] call bis_fnc_garage;
					};
				};
			};
			//--- Toggle interface
			case (_key == DIK_BACKSPACE && !_inTemplate): {
				['buttonInterface',[_display]] call BIS_fnc_arsenal;
				_return = true;
			};

			//--- Acctime
			case (_key in (actionkeys "timeInc")): {
				if (acctime == 0) then {setacctime 1;};
				_return = true;
			};
			case (_key in (actionkeys "timeDec")): {
				if (acctime != 0) then {setacctime 0;};
				_return = true;
			};

			//--- Vision mode
			case (_key in (actionkeys "nightvision") && !_inTemplate): {
				_mode = missionnamespace getvariable ["BIS_fnc_arsenal_visionMode",-1];
				_mode = (_mode + 1) % 3;
				missionnamespace setvariable ["BIS_fnc_arsenal_visionMode",_mode];
				switch _mode do {
					//--- Normal
					case 0: {
						camusenvg false;
						false setCamUseTi 0;
					};
					//--- NVG
					case 1: {
						camusenvg true;
						false setCamUseTi 0;
					};
					//--- TI
					default {
						camusenvg false;
						true setCamUseTi 0;
					};
				};
				playsound ["RscDisplayCurator_visionMode",true];
				_return = true;
			};
			/*
			//--- Delete template
			case (_key == DIK_DELETE): {
				_ctrlMouseBlock = _display displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;
				if !(ctrlenabled _ctrlMouseBlock) then {
					['buttonTemplateDelete',[_display]] call VANA_fnc_arsenal;
					_return = true;
				};
			};
			*/
		};
		_return
	};

	//VANA - Disabled These:
	case "buttonTemplateOK": {};
	case "buttonTemplateDelete": {};
	case "templateSelChanged": {};
	case "showTemplates": {};
	case "buttonLoad": {};
	case "buttonSave": {};
};
