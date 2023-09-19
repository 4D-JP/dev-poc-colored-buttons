property IMAGES : 4D:C1709.Folder  //the root images folder

Class constructor
	
Function get IMAGES()->$IMAGES : 4D:C1709.Folder
	
	$IMAGES:=Folder:C1567("/RESOURCES/Images/raw/")
	
Function getRawImage($name : Text)->$SVG : Text
	
	var $file : 4D:C1709.File
	
	$file:=This:C1470.IMAGES.file($name+".svg")
	
	If ($file.exists)
		$SVG:=$file.getText("utf-8-no-bom"; Document with CR:K24:21)
	End if 
	
/*
	
raw images use white,black,oapcity=0.5 only for colors
	
width:33
height:132
viewBox:0 0 22 132
	
*/