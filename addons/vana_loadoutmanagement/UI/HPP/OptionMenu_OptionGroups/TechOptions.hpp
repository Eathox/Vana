class TechOptions: RscVANAOptionGroup
{
	idc=981200;
	x="0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
	y="(0 - 0.2) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	h="((4 * 1.222) + 2.88) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

	class controls
	{
		class BackGroundList: RscVANABackGroundList
		{
			idc=981201;
		};
		class TechOptionsTitle: RscVANAOptionCategoryTitle
		{
			idc=-1;
			text="Technical"; //LOCALIZE
			x="0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
		};
		class IgnoreValidationText: RscVANAOptionText
		{
			idc=-1;
			text="IgnoreValidation"; //LOCALIZE
			optiondescription="Dummy1"; //LOCALIZE
			optionbuttonidc=981202;
			y="(1.1 * 1.2) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class IgnoreValidationCheckbox: RscVANAOptionCheckbox
		{
			idc=981202;
			index=0;
			optionname="ignorevalidation";
			onCheckedChanged="['ignorevalidation', ([False, True] select (_this select 1 == 1))] call VANA_fnc_SetOptionValue";
			y="(1.062 * 1.2) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			x="17.95 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			w="1 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class IgnoreValidationText1: RscVANAOptionText
		{
			idc=-1;
			text="IgnoreValidation"; //LOCALIZE
			optiondescription="Dummy2"; //LOCALIZE
			optionbuttonidc=981203;
			y="(2.1 * 1.2) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class IgnoreValidationCheckbox1: RscVANAOptionCheckbox
		{
			idc=981203;
			index=1;
			y="(2.062 * 1.2) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			x="17.95 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			w="1 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class IgnoreValidationText2: RscVANAOptionText
		{
			idc=-1;
			text="IgnoreValidation"; //LOCALIZE
			optiondescription="Dummy3"; //LOCALIZE
			optionbuttonidc=981204;
			y="(3.1 * 1.2) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class IgnoreValidationCheckbox2: RscVANAOptionCheckbox
		{
			idc=981204;
			index=2;
			y="(3.062 * 1.2) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			x="17.95 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			w="1 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
	};
};
