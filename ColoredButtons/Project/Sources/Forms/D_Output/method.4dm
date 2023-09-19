// v19 #f55afb20-184a-437b-8ef9-9f6eb0a6111e
// ----------------------------------------------------
// User name (OS): Daniel Nestor Solenthaler
// Date and time: 11.06.10, 20:45:00
// ----------------------------------------------------
// Method: [ADR_ADDRESSES].D_Output
// This is the form method of the new listbox type
//output form for the address table
// ----------------------------------------------------


C_BOOLEAN:C305($Handled)
C_LONGINT:C283($Element_n; $find; $SavedSetID; $Error)
C_TEXT:C284($ListboxName; $ListboxDefinitions; $ListboxDefaultSortCol; $PicturePath)
C_PICTURE:C286($Dummy)
$Handled:=_FM_Call(Form event code:C388; Current method name:C684)
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		//***** Define Variables *****
		ARRAY TEXT:C222(as_FilterName; 0)
		C_TEXT:C284($FilterCreationMethod)
		$FilterCreationMethod:=SYS_Parameter_Get(vParListNr; "FilterCreationMethod")
		SYS_DISPOSE_VARIABLE(->vs_Search; ->vt_SearchInput)
		Clairvoyance_b:=False:C215
		ADR_ADDRESS_Scroll_ID_n:=0  // 11/06/14.kdw 
		
		//***** Set the ADD and DELETE buttons, according to Read/Write Privileges *****
		GEN_HANDLE_BUTTONS  //remember: the buttons must be called 'bh_Add' and 'bh_Delete'
		
		
		//***** Prepare highlightning of last used records *****
		CREATE EMPTY SET:C140("$SYS_SavedHighlighted")  //Might be used to select the last selected record(s) again
		
		
		//***** Prepare the Search Field PopUp Menu, if available *****
		GEN_BUILD_SEARCHFIELD_POPUP  //defines the as_SearchFieldName and ai_SearchFieldNr arrays, based on the resource strings in 16xxxx
		If ($FilterCreationMethod#"")  //If defined, it means, that we are in an output form 
			EXECUTE FORMULA:C63($FilterCreationMethod)
		End if 
		
		
		//***** Initialize listbox *****
		$ListboxName:=SYS_Parameter_Get(vParListNr; "ListboxName")  // Modified by: kwilbur, 1/25/2011
		$ListboxDefinitions:=SYS_Parameter_Get(vParListNr; "ListboxDefinitions")  // Modified by: kwilbur, 1/25/2011
		$ListboxDefaultSortCol:=SYS_Parameter_Get(vParListNr; "DefaultSortOrder")  // Modified by: kwilbur, 2/15/2011
		UTI_LISTBOX_DYNCOL_MANAGER("initColumnConstants"; $ListboxDefinitions)  //MUST Do BEFORE regular "init"  // Modified by: kwilbur, 1/27/2011
		UTI_LISTBOX_DYNCOL_MANAGER("init")  //initialize variables
		UTI_LISTBOX_DYNCOL_MANAGER("load_user_default"; $ListboxDefinitions)  //load listbox definition into array (argument is the resource ID with the listbox default) // Modified by: kwilbur, 1/25/2011
		UTI_LISTBOX_DYNCOL_MANAGER("setup_listbox"; $ListboxName)  //setup the listbox based on the arrays (arguments are the base table number and the listbox object name) // Modified by: kwilbur, 1/25/2011
		UTI_LISTBOX_DYNCOL_MANAGER("order_selection"; $ListboxName; $ListboxDefaultSortCol)  //sorts the listbox // Modified by: kwilbur, 1/25/2011
		
		
		//***** Prepare other GUI elements *****
		GEN_SET_WINDOW_TITLE
		
		
		//***** Handle Platform specific objects *****
		If (Is macOS:C1572)
			UTI_GET_PICTURE_FROM_LIBRARY(28482; ->$Dummy; ->$PicturePath)  //#f55afb20-184a-437b-8ef9-9f6eb0a6111e
			OBJECT SET FORMAT:C236(bAddressbook; "1;4;file:"+$PicturePath+";240")
			UTI_GET_PICTURE_FROM_LIBRARY(28433; ->$Dummy; ->$PicturePath)  //#f55afb20-184a-437b-8ef9-9f6eb0a6111e
			OBJECT SET FORMAT:C236(bSendMail; "1;4;file:"+$PicturePath+";240")
		Else 
			UTI_GET_PICTURE_FROM_LIBRARY(28481; ->$Dummy; ->$PicturePath)  //#f55afb20-184a-437b-8ef9-9f6eb0a6111e
			OBJECT SET FORMAT:C236(bAddressbook; "1;4;file:"+$PicturePath+";240")
			UTI_GET_PICTURE_FROM_LIBRARY(28432; ->$Dummy; ->$PicturePath)  //#f55afb20-184a-437b-8ef9-9f6eb0a6111e
			OBJECT SET FORMAT:C236(bSendMail; "1;4;file:"+$PicturePath+";240")
		End if 
		
		
		//***** Enable/Disable the buttons
		ADR_OUTPUTFORM_HANDLE_BUTTONS  //Enable/Disable buttons, depending of the highlighted records
		
		<>ADR_ADDRESS_Scroll_ID_n:=-1  // Modified by: kwilbur, 09/18/14
		
		//Set a special tools menu bar for this form
		_MenuBar_Push  //we pop the old menu bar in the 'On Unload' cycle of this form
		Case of 
			: (SYS_CurrentApplicationType="legal")  // Modified by: kwilbur, 8/23/2011
				If (USR_GetAccessPriv(":15399,32")="OK")  // Modified by: solenthaler (09.06.22) #6e5995b2-1447-46fc-85e9-536132270907
					GEN_SET_FORM_MENU(kMenuItem_ADR_RECORDS_SUITE; kMenuItem_ADR_SELECTION_SUITE; kMenuItem_Line; kMenuItem_ADR_EXPORT_SUITE; kMenuItem_ADR_IMPORT_SUITE; kMenuItem_ADR_APPLY_SUITE; kMenuItem_Line; kMenuItem_ADR_INTERNET_SUITE; kMenuItem_Line; kMenuItem_StartAdressSelector; kMenuItem_Line; kMenuItem_CopyAddressBlock; kMenuItem_ZoomContact; kMenuItem_FIND_DUPS_CONFLICT; kMenuItem_Line; kMenuItem_Record2TODO; kMenuItem_AddDocument; kMenuItem_AddNote)
				Else 
					GEN_SET_FORM_MENU(kMenuItem_ADR_RECORDS_SUITE; kMenuItem_ADR_SELECTION_SUITE; kMenuItem_Line; kMenuItem_ADR_IMPORT_SUITE; kMenuItem_ADR_APPLY_SUITE; kMenuItem_Line; kMenuItem_ADR_INTERNET_SUITE; kMenuItem_Line; kMenuItem_StartAdressSelector; kMenuItem_Line; kMenuItem_CopyAddressBlock; kMenuItem_ZoomContact; kMenuItem_FIND_DUPS_CONFLICT; kMenuItem_Line; kMenuItem_Record2TODO; kMenuItem_AddDocument; kMenuItem_AddNote)
				End if 
			: (SYS_CurrentApplicationType="Inhouse")  // Modified by: kwilbur, 02/01/2012
				GEN_SET_FORM_MENU(kMenuItem_ADR_RECORDS_SUITE; kMenuItem_ADR_SELECTION_SUITE; kMenuItem_Line; kMenuItem_ADR_EXPORT_SUITE; kMenuItem_ADR_IMPORT_SUITE; kMenuItem_ADR_APPLY_SUITE; kMenuItem_Line; kMenuItem_ADR_INTERNET_SUITE; kMenuItem_Line; kMenuItem_StartAdressSelector; kMenuItem_Line; kMenuItem_CopyAddressBlock; kMenuItem_ZoomContact; kMenuItem_FIND_DUPS_CONFLICT; kMenuItem_Line; kMenuItem_Record2TODO; kMenuItem_AddDocument; kMenuItem_AddNote)
			Else 
				GEN_SET_FORM_MENU(kMenuItem_ADR_RECORDS_SUITE; kMenuItem_ADR_SELECTION_SUITE; kMenuItem_Line; kMenuItem_ADR_EXPORT_SUITE; kMenuItem_ADR_IMPORT_SUITE; kMenuItem_ADR_APPLY_SUITE; kMenuItem_Line; kMenuItem_ADR_INTERNET_SUITE; kMenuItem_Line; kMenuItem_StartAdressSelector; kMenuItem_Line; kMenuItem_CopyAddressBlock; kMenuItem_ZoomContact; kMenuItem_FindDuplicates; kMenuItem_Line; kMenuItem_Record2TODO; kMenuItem_AddDocument; kMenuItem_AddNote)
		End case 
		
		
	: (Form event code:C388=On Clicked:K2:4)
		ADR_OUTPUTFORM_HANDLE_BUTTONS
		
		
		
	: (Form event code:C388=On Close Box:K2:21)
		If (Macintosh option down:C545)  //User did an option click into the close box
			GEN_CLOSE_ALL_FUNCTIONS
		Else 
			CANCEL:C270
		End if 
		
	: (Form event code:C388=On Outside Call:K2:11)
		GEN_HANDLE_OUTSIDE_CALL(SimpleDialog)
		
		// 11/06/14.kdw  BEGIN
		If (ADR_ADDRESS_Scroll_ID_n>0)  // This only occurrs whend a VCard is dropped
			ARRAY LONGINT:C221($AddressID_an; 0)
			SELECTION TO ARRAY:C260([ADR_ADDRESSES:11]ADDRESS_ID:1; $AddressID_an)
			$Element_n:=Find in array:C230($AddressID_an; ADR_ADDRESS_Scroll_ID_n)
			If ($Element_n>0)
				OBJECT SET SCROLL POSITION:C906(lbAddressChooser; $Element_n)
			End if 
			ADR_ADDRESS_Scroll_ID_n:=0
			ARRAY LONGINT:C221($AddressID_an; 0)
		End if 
		// 11/06/14.kdw  END
		
	: (Form event code:C388=On Resize:K2:27)  //We move the button group in the middle of the output form, in order to adjust to the window size
		GEN_CORRECT_WINDOWSIZE
		UTI_LISTBOX_SHOW_HIDE_SCROLLBAR(->lbAddressChooser; "horizontal")
		
	: (Form event code:C388=On Timer:K2:25)
		If (Clairvoyance_b)
			Clairvoyance_b:=False:C215  // Modified by: kwilbur, 10/17/2012
			vs_Search:=Get edited text:C655
			GEN_QUERY_SELECTION
			GEN_SET_WINDOW_TITLE(SYS_Parameter_Get(vParListNr; "SelectionTitle"))
			GOTO OBJECT:C206(vt_SearchInput)
		Else 
			// Modified by: kwilbur, 09/18/14 BEGIN
			Case of 
				: (<>ADR_ADDRESS_Scroll_ID_n>0)
					ARRAY LONGINT:C221($AddressID_an; 0)
					SELECTION TO ARRAY:C260([ADR_ADDRESSES:11]ADDRESS_ID:1; $AddressID_an)
					$Element_n:=Find in array:C230($AddressID_an; <>ADR_ADDRESS_Scroll_ID_n)
					If ($Element_n>0)
						OBJECT SET SCROLL POSITION:C906(lbAddressChooser; $Element_n)
					End if 
					ARRAY LONGINT:C221($AddressID_an; 0)
					<>ADR_ADDRESS_Scroll_ID_n:=-1
					
				: (Records in selection:C76([ADR_ADDRESSES:11])<501)  // Modified by: Daniel Solenthaler (15.09.2014)
					OBJECT SET SCROLL POSITION:C906(lbAddressChooser)  //Just scroll if we have few records. Otherwise it takes too long!
			End case 
			// Modified by: kwilbur, 09/18/14 END
			
			ADR_OUTPUTFORM_HANDLE_BUTTONS  //Enable/Disable buttons, depending of the highlighted records
		End if 
		SET TIMER:C645(0)
		
		
	: (Form event code:C388=On Unload:K2:2)
		<>ADR_ADDRESS_Scroll_ID_n:=-1  // Modified by: kwilbur, 09/18/14
		$ListboxDefinitions:=SYS_Parameter_Get(vParListNr; "ListboxDefinitions")  // Modified by: kwilbur, 1/25/2011
		UTI_LISTBOX_DYNCOL_MANAGER("save_user_default"; $ListboxDefinitions)  // Modified by: kwilbur, 1/25/2011
		$find:=Find in array:C230(<>al_OpenFunctionProcessNr; Current process:C322)  //find out, wether this process ought to be restored or not
		If ($find=-1)  //no, the current process will be permanently closed
			$SavedSetID:=Num:C11(SYS_Parameter_Get(vParListNr; "SavedSetID"))  //...so this function is about to be permanently closed
			Case of   //Delete selection document if this was a PowerSearch Window
				: ($SavedSetID>0)  //The set is saved in the infopool
					$Error:=INFO_DeleteDocument($SavedSetID)
				: ($SavedSetID<0)  //The set is saved in the STUFF folder
					$Error:=SYS_DeleteSet(-$SavedSetID)
			End case 
		End if 
		SYS_DISPOSE_SET("$SYS_SavedHighlighted")
		SYS_DISPOSE_VARIABLE(->vs_Search)
		_MenuBar_Pop
		
End case 