#include "AllowedOptions.inc"

params [
	["_OptionName", "", [""]],
	"_VANAOptionsData",
	"_DefualtValue",
	"_Return"
];

_OptionName = tolower _OptionName;
_DefualtValue = nil;
{if ((_x select 0) isequalto _OptionName) exitwith {_DefualtValue = (_x select 1)}} foreach ALLOWEDOPTIONS;
_Return = _DefualtValue;

_VANAOptionsData = profilenamespace getvariable ["VANA_fnc_OptionsMenu_Data", []];
(_VANAOptionsData select {(_x select 0) isequalto _OptionName}) params [["_OptionArray", [_OptionName]]];

if (Count _OptionArray isequalto 2) then {_Return = (_OptionArray select 1)};

_Return
