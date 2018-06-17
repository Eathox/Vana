Params ["_Current","_CurrentLength","_PastData","_Past","_PastLength"];

_Current = CopyFromClipboard;
_CurrentLength = Count _Current;
_PastData = UInamespace getvariable ["VANA_fnc_ClipboardChanged_Past", ["", 0]];
_Past = _PastData select 0;
_PastLength = _PastData select 1;

if (_CurrentLength > 10) then {_Current = _Current select [0,10]};
if !(_Current isequalto _Past && _CurrentLength isequalto _PastLength) then
{
	UInamespace Setvariable ["VANA_fnc_ClipboardChanged_Past", [_Current, _CurrentLength]];
	True
} else {
	False
};
