#define DEPTH(PLUSMIN) _Depth = _Depth PLUSMIN 1;
#define MAXDEPTHPLUS _MaxDepth = _MaxDepth+1;
#define NEXTELEMENT (_ArrayDataString select (_ForeachIndex+1))
#define LASTELEMENT (_ArrayDataString select (_ForeachIndex-1))

//WIP Rework so _ValidateArray only has to be run once for each array

params [
	["_Import", "", [""]],
	"_DataTypes",
	"_Import",
	"_LayoutData",
	"_LoadoutData",
	"_LayoutDataValidation",
	"_LoadoutDataValidation"
];

_DataTypes = [];
_LayoutData = [];
_LoadoutData = [];

_Import = _Import splitString (toString [13,10]);
if (_Import isequalto []) exitwith {[_DataTypes, [_LayoutData, _LoadoutData]]};

_LayoutDataValidation = { //Format Validation
	private _Result = _This;

	if ((_Result select 1) isequalto [] || (_Result select 0) != 3) exitwith {[]};
	_Result = _Result select 1;

	//Validate format of LayoutData
	if (_Result isequalto [] || !(_Result isequaltypeall [])) exitwith {[]};
	if ({!(_x isequaltypearray ["",[],"",0] && (if (count _x > 2) then {((_x select 2) in ["tvloadout","tvtab"])} else {false}))} count _Result > 0) exitwith {[]};

	_Result
};

_LoadoutDataValidation = { //Format Validation
	params ["_Result","_LoadoutDataTemplate"];

	_Result = _This;
	_LoadoutDataTemplate = [["",[]],["",[]],["",[]],"","","",["",["","","",""],""],["",["","","",""],""],["",["","","",""],""],[/*Can be 6 long*/],["","",""]];

	if ((_Result select 1) isequalto [] || (_Result select 0) != 4) exitwith {[]};
	_Result = _Result select 1;

	//Validate format of LayoutData
	if ({
		switch (Typename _x) do {
			case "STRING": {if !((_Result find _x)+1 isequalto count _Result) then {!(_Result select (_Result find _x)+1 isequaltype [])} else {true}};
			case "ARRAY": {
				if (_x isequaltypearray _LoadoutDataTemplate) then {
					private _Array = _x;
					{if (_x isequaltype []) then {!(_x isEqualTypeParams ["",[]] || (_x isEqualTypeAll "" && ((count _x <= 6 && (_Array Find _x) == 9) || (count _x == 3 && (_Array Find _x) == 10))))} else {false}} count _Array > 0
				} else {true};
			};
			default {true};
		};
	} count _Result > 0) exitwith {[]};

	_Result
};

{
	//Array Format Validation
	params ["_ImportSubArray""_Depth","_MaxDepth","_Result","_InString","_ArrayDataString","_ArrayValidation","_ValidationResult"];
	scopeName "ArrayValidation";

	_ImportSubArray = _x;
	_Depth = 0;
	_MaxDepth = 0;
	_Result = [];
	_InString = False;
	_ArrayDataString = _ImportSubArray splitString "";

	{if !(_x in [" ", (toString [9]), toString [10]]) exitwith {_ArrayDataString deleteRange [0,_ForeachIndex]}} foreach _ArrayDataString;
	if !((_ArrayDataString select 0) isequalto "[") exitwith {[_MaxDepth, _Result]};

	{
		Switch true do {
			case (_x isequalto """"): {if _InString then {_InString = False} else {_InString = True}};
			case (_x isequalto "[" && !_InString): {
				DEPTH(+)
				if (_Depth > _MaxDepth) then {MAXDEPTHPLUS};
			};
			case (_x isequalto "]" && !_InString): {
				DEPTH(-)
				if (_Depth <= 0) then
				{
					if !(_ForeachIndex+1 isequalto count _ArrayDataString) then {Breakto "ArrayValidation"};
					_Result = call compile _ImportSubArray;
				};
			};

			case (_x isequalto "," && !_InString): {if (NEXTELEMENT isequalto "]" || LASTELEMENT isequalto "[") then {Breakto "ArrayValidation"}};
			case (_x isequalto "-" && !_InString): {if !(NEXTELEMENT in ["0","1","2","3","4","5","6","7","8","9"]) then {Breakto "ArrayValidation"}};
			case (_x in ["0","1","2","3","4","5","6","7","8","9"] && !_InString): {if (NEXTELEMENT in ["[",""""] || LASTELEMENT in ["]",""""]) then {Breakto "ArrayValidation"}};
			case (_x in [" ", (toString [9]), (toString [10])] && !_InString): {};
			default {if !_InString then {Breakto "ArrayValidation"}};
		};
	} foreach _ArrayDataString;

	if (_Result isequalto []) then {_MaxDepth = 0};
	_ArrayValidation = [_MaxDepth, _Result];

	if (_LayoutData isequalto []) then {
		_ValidationResult = _ArrayValidation call _LayoutDataValidation;
		if (count _ValidationResult > 0) then {_DataTypes Pushback "Layout"; _LayoutData = _ValidationResult};
	};

	if (_LoadoutData isequalto []) then {
		_ValidationResult = _ArrayValidation call _LoadoutDataValidation;
		if (count _ValidationResult > 0) then {_DataTypes Pushback "Loadout"; _LoadoutData = _ValidationResult};
	};
} foreach _Import;

if (count _DataTypes == 2) then {_DataTypes pushback "Both"};
[_DataTypes, [_LayoutData, _LoadoutData]]
