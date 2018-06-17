Private _TargetTv = +_This;

if !(_TargetTv isequalto []) then
{
	_TargetTv resize (Count _TargetTv-1);

	_TargetTv
} else {
	[]
};
