class MiscOptions: RscVANAOptionGroup
{
	idc=981100;
	x="0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
	y="(0 - 0.2) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	h="((5 * 1.222) + 2.88) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

	class controls
	{
		class BackGroundList: RscVANABackGroundList
		{
			idc=981101;
		};
		class MiscOptionsTitle: RscVANAOptionCategoryTitle
		{
			idc=-1;
			text="Miscellaneous"; //LOCALIZE
			x="0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
		};
		class ExportDataText: RscVANAOptionText
		{
			idc=-1;
			text="Export Data"; //LOCALIZE
			optiondescription="Dummy"; //LOCALIZE
			optionbuttonidc=981102;
			y="(1.1 * 1.2) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class ExportButton: RscVANAOptionPictureButton
		{
			idc=981102;
			text="\vana_LoadoutManagement\UI\Data_Icons\ButtonExport.paa";
			index=0;
			y="(1.062 * 1.2) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			x="17.95 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			w="1 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[]={0,0,0,0.8};
			colorBackgroundFocused[] ={0,0,0,0.8};
			colorBackgroundHover[] ={0,0,0,0.8};
			colorBackgroundPressed[] ={0,0,0,0.8};
			colorBackgroundDisabled[] ={0,0,0,0.8};
		};
		class ImportDataText: RscVANAOptionText
		{
			idc=-1;
			text="Import Data"; //LOCALIZE
			optiondescription="Dummy"; //LOCALIZE
			optionbuttonidc=981103;
			y="(2.1 * 1.2) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class ImportButton: RscVANAOptionPictureButton
		{
			idc=981103;
			text="\vana_LoadoutManagement\UI\Data_Icons\ButtonImport.paa";
			index=1;
			y="(2.062 * 1.2) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			x="17.95 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			w="1 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[]={0,0,0,0.8};
			colorBackgroundFocused[] ={0,0,0,0.8};
			colorBackgroundHover[] ={0,0,0,0.8};
			colorBackgroundPressed[] ={0,0,0,0.8};
			colorBackgroundDisabled[] ={0,0,0,0.8};
		};
		class WipeDataText: RscVANAOptionText
		{
			idc=-1;
			text="Wipe Data"; //LOCALIZE
			optiondescription="Dummy"; //LOCALIZE
			optionbuttonidc=981104;
			y="(3.1 * 1.2) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class WipeDataButton: RscVANAOptionPictureButton
		{
			idc=981104;
			text="\vana_LoadoutManagement\UI\Data_Icons\ButtonWipeData.paa";
			index=2;
			y="(3.062 * 1.2) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			x="17.95 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			w="1 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[]={0,0,0,0.8};
			colorBackgroundFocused[] ={0,0,0,0.8};
			colorBackgroundHover[] ={0,0,0,0.8};
			colorBackgroundPressed[] ={0,0,0,0.8};
			colorBackgroundDisabled[] ={0,0,0,0.8};
		};
		class RestoreBackupText: RscVANAOptionText
		{
			idc=-1;
			text="Restore Backup"; //LOCALIZE
			optiondescription="Dummy"; //LOCALIZE
			optionbuttonidc=981105;
			y="(4.1 * 1.2) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class RestoreBackupButton: RscVANAOptionPictureButton
		{
			idc=981105;
			text="\vana_LoadoutManagement\UI\Data_Icons\ButtonRestoreBackup.paa";
			index=3;
			y="(4.062 * 1.2) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			x="17.95 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			w="1 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[]={0,0,0,0.8};
			colorBackgroundFocused[] ={0,0,0,0.8};
			colorBackgroundHover[] ={0,0,0,0.8};
			colorBackgroundPressed[] ={0,0,0,0.8};
			colorBackgroundDisabled[] ={0,0,0,0.8};
		};
		class DropDownMenu: RscVANAOptionGroup
		{
			idc=981150;
			y="-0.2 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			x="13.95 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			w="5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h="2.88 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			class controls
			{
				class DropDownMenuLayoutButton: RscVANAOptionButton
				{
					idc=981151;
					text="Layout"; //LOCALIZE
					y="0 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					x="0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					w="5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h="0.95 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					sizeex="0.95 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class DropDownMenuLoadoutButton: RscVANAOptionButton
				{
					idc=981152;
					text="Loadout"; //LOCALIZE
					y="0.96 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					x="0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					w="5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h="0.95 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					sizeex="0.95 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class DropDownMenuBothButton: RscVANAOptionButton
				{
					idc=981153;
					text="Both"; //LOCALIZE
					y="1.92 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					x="0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					w="5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h="0.95 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					sizeex="0.95 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};

				//Just here so that DropDownMenu doesnt get disabled if all buttons are disabled
				class DropDownMenuBackground: RscBackgroundGUI
				{
					idc=981154;
					x="0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y="0 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w="0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h="0 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[]={0,0,0,0};
				};
			};
		};
	};
};
