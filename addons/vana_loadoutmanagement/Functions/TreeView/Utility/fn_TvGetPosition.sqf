params
[
	["_ArsenalDisplay", displaynull, [displaynull]],
	["_Arguments", [], [[]]],
	["_TypeData", "All", [""]],
	"_Name",
	"_TvParent",
	"_FncArguments",
	"_Target"
];

_Arguments params
[
	["_TvParent", [-1], [[]]],
	["_Name", "", [""]]
];

//Find Correct SubTv
_FncArguments = [[_ArsenalDisplay, [_TvParent, (toLower _TypeData)], [], False], [_ArsenalDisplay, [[], (toLower _TypeData)]]] select (_TvParent isequalto [-1]);
_Target = (_FncArguments call VANA_fnc_TvGetData) select {(_x select 0) isequalto _Name};

if (_Target isequalto []) exitwith {[-1]};

(_Target select 0) select 1
