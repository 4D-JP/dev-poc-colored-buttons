//%attributes = {}
var $UI : cs:C1710.UI

$UI:=cs:C1710.UI.new()

$image:=$UI.getColoredButton("_GEN_Bttn_AddRecord er-sc")

SET PICTURE TO PASTEBOARD:C521($image)

$UI.exportOne("_GEN_Bttn_AddRecord er-sc")

$UI.exportAll()

SHOW ON DISK:C922($UI.cacheFolder.platformPath)