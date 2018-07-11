disableserialization;

#include "\vana_LoadoutManagement\UI\defineDIKCodes.inc"
#include "\vana_LoadoutManagement\UI\defineResinclDesign.inc"

#define Expanded 1
#define Collapsed 0

params [
	["_ArsenalDisplay", displaynull, [displaynull]],
	["_Mode", "False", [""]],
	["_Arguments", [], [[]]],
	"_CtrlTreeView"
];

_CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
switch (toLower _Mode) do {
	case "mousedown": {
		params ["_InAction"];

		//Check if user is using scroll bar
		If !(_CtrlTreeView getvariable ["MouseInTreeView", True]) exitwith {["mousedown", False]};

		//Tell script to get Target
		_CtrlTreeView Setvariable ["TvDragDrop_GetTarget", True];

		//Double check user is initiating TvDragDrop action
		_CtrlTreeView Setvariable ["TvDragDrop_InAction", "Double Check"];
		UiSleep 0.1;

		_InAction = _CtrlTreeView Getvariable ["TvDragDrop_InAction", False];
		_CtrlTreeView Setvariable ["TvDragDrop_InAction", ([False, True] select (_InAction isequalto "Double Check"))];

		["mousedown", (_CtrlTreeView Getvariable ["TvDragDrop_InAction", False])]
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "mousemove": {
		params ["_Return","_GetTarget","_InAction","_CursorTab"];

		_Return = ["mousemove", False];
		_GetTarget = _CtrlTreeView Getvariable ["TvDragDrop_GetTarget", False];
		_InAction = _CtrlTreeView Getvariable ["TvDragDrop_InAction", False];
		_CursorTab = _Arguments;

		//Get Target
		if _GetTarget then {
			_CtrlTreeView Setvariable ["TvDragDrop_TargetTv", _CursorTab];
			_CtrlTreeView Setvariable ["TvDragDrop_GetTarget", nil];

			_Return = ["mousemove", True];
		};

		//Get Release Subtv
		if (_InAction isequalto true) then {
			_CtrlTreeView Setvariable ["TvDragDrop_ReleaseTv", _CursorTab];

			_Return = ["mousemove", True];
		};

		_Return
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "mouseup": {
		params ["_FncReturn","_TargetTv","_ReleaseTv"];

		_TargetTv = _CtrlTreeView Getvariable ["TvDragDrop_TargetTv", [-1]];
		_ReleaseTv = _CtrlTreeView Getvariable ["TvDragDrop_ReleaseTv", [-1]];

		//Clear Values
		_CtrlTreeView Setvariable ["TvDragDrop_InAction", nil];
		_CtrlTreeView Setvariable ["TvDragDrop_GetTarget", nil];
		_CtrlTreeView Setvariable ["TvDragDrop_TargetTv", nil];
		_CtrlTreeView Setvariable ["TvDragDrop_ReleaseTv", nil];

		//Call TvDragDrop function
		if !(_TargetTv isequalto [-1]) exitwith {
			_FncReturn = [_ArsenalDisplay, "DragDropFnc", [_TargetTv, _ReleaseTv]] call VANA_fnc_TvDragDrop;

			["DragDropFnc", _FncReturn]
		};

		["MouseUp", False]
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "dragdropfnc": {
		_Arguments params [
			["_TargetTv", [-1], [[]]],
			["_ReleaseTv", [-1], [[]]],
			"_TargetTvData",
			"_TargetTvText",
			"_TargetTvValue",
			"_TargetTvParent",
			"_IsParent",
			"_IsChild",
			"_MovedSubtv",
			"_MovedLoadouts",
			"_NewSubTVPath",
			"_MovedSubtvGrandParent"
		];

		_TargetTvData = _CtrlTreeView tvData _TargetTv;
		_TargetTvText = _CtrlTreeView tvText _TargetTv;
		_TargetTvValue = _CtrlTreeView tvValue _TargetTv;

		//Making sure the DragDrop action is valid
		if (_ReleaseTv isequalto [-1] || _TargetTv isequalto [] || _TargetTv isequalto _ReleaseTv) exitwith {False};

		if (_CtrlTreeView tvData _ReleaseTv isequalto "tvloadout") then {
			_ReleaseTv = _ReleaseTv call VANA_fnc_TvGetParent;
		};
		_TargetTvParent = _TargetTv call VANA_fnc_TvGetParent;

		//Making sure the DragDrop action is valid
		_IsParent = _TargetTvParent isequalto _ReleaseTv;
		_IsChild = _ReleaseTv select [0,(count _TargetTv)] isequalto _TargetTv;

		if (_IsParent || _IsChild) exitwith {False};

		//Create Moved SubTv
		_MovedSubtv = +_ReleaseTv;
		_NewSubTvPath = _CtrlTreeView tvadd [_ReleaseTv, _TargetTvText];

		_CtrlTreeView TvExpand _ReleaseTv;
		_MovedSubtv pushback _NewSubTvPath;

		//Visualy/Technical classify Moved SubTv
		_CtrlTreeView tvSetData [_MovedSubtv, _TargetTvData];
		_CtrlTreeView TvSetValue [_MovedSubtv, _TargetTvValue];

		if (_TargetTvValue < 0) then {_CtrlTreeView tvSetColor [_MovedSubtv, [1,1,1,0.25]]};
		If (_TargetTvValue isequalto Expanded) then {_CtrlTreeView TvExpand _MovedSubtv};

		if (_TargetTvData isequalto "tvtab") then {
			_CtrlTreeView tvSetPicture [_MovedSubtv, "\vana_LoadoutManagement\UI\Data_Icons\Tab_Icon.paa"];
			_MovedLoadouts = [];

			//Move Child SubTv's
			{
				params ["_TvName","_TvPosition","_TvNewParent","_Tab","_Expanded","_Return"];

				_TvName = _x select 0;
				_TvPosition = (_x select 1) select [(count _TargetTv), (count (_x select 1) - count _TargetTv)]; //Selects [Position] and removes _TargetTv array from the front of it

				_TvNewParent = _MovedSubtv + _TvPosition;
				_TvNewParent resize (Count _TvNewParent)-1;

				switch tolower (_x select 2) do {
					case "tvtab": {
						_Tab = [_ArsenalDisplay, [_TvNewParent, _TvName], "DragDrop"] call VANA_fnc_TvCreateTab;
						_Expanded = (_x select 3) isequalto Expanded;

						If _Expanded then {_CtrlTreeView TvExpand _Tab};
						_CtrlTreeView TvSetValue [_Tab, ([Collapsed, Expanded] select _Expanded)];
					};
					case "tvloadout": {
						_Return = [_ArsenalDisplay, [_TvNewParent, _TvName], "DragDrop"] call VANA_fnc_TvCreateLoadout;
						_MovedLoadouts pushback [_TvName, (_Return select 0)];
					};
				};
				True
			} count ([_ArsenalDisplay, [_TargetTv]] call VANA_fnc_TvGetData);

			[_ArsenalDisplay, _MovedLoadouts] call VANA_fnc_TvValidateLoadouts;
		};

		_CtrlTreeView tvSetCurSel _MovedSubtv;
		_CtrlTreeView tvDelete _TargetTv;

		//Get _MovedSubtv True posistion
		_MovedSubtvGrandParent = +_MovedSubtv;
		_MovedSubtvGrandParent resize (count _TargetTvParent);

		if (_TargetTvParent isequalto _MovedSubtvGrandParent) then {
			private _Number = _MovedSubtv select (count _TargetTvParent);
			_MovedSubtv set [(count _TargetTvParent), _Number -1];
		};

		_MovedSubtv
	};
};
