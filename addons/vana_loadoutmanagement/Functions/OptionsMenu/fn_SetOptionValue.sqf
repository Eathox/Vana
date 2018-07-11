#include "AllowedOptions.inc"

params [
	["_OptionName", "", [""]],
	["_Value", nil],
	"_Location",
	"_VANAOptionsData",
	"_AllowedOptions"
];

_Location = -1;
_OptionName = tolower _OptionName;
_VANAOptionsData = profilenamespace getvariable ["VANA_fnc_OptionsMenu_Data", []];

_AllowedOptions = [];
{_AllowedOptions pushback (_x select 0)} foreach ALLOWEDOPTIONS;
(_VANAOptionsData select {(_x select 0) isequalto _OptionName}) params [["_OptionArray", [_OptionName]]];
if (Count _OptionArray isequalto 2) then {_Location = _VANAOptionsData find _OptionArray};

//Deletes optiondata from profile if its not an allowed option
if !(_OptionName in _AllowedOptions) exitwith {
	if (_Location > -1) then	{
		_VANAOptionsData DeleteAt _Location;
		saveprofilenamespace;
	};

	False
};

_OptionArray set [1, _Value];
call ([{_VANAOptionsData set [_Location, _OptionArray]}, {_VANAOptionsData pushback _OptionArray}] select (_Location isequalto -1));
saveprofilenamespace;

True
