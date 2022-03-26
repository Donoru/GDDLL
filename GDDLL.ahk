#SingleInstance, Force

Gui, New, -MaximizeBox, Geometry Dash DLL Injector
Gui, Add, Link,, Welcome to GDDLL by <a href="https://www.github.com/donoru/GDDLL">Donoru</a>!
Gui, Add, Text,, Enter filepath of DLL to inject:
Gui, Add, Edit, w200 vFilePath
Gui, Add, Radio, vAbsolute, Add filepath to absolutedlls
Gui, Add, Radio, vExtensions, Move file to extensions folder
Gui, Add, Text,, Enter Geometry Dash directory (leave blank for default)
Gui, Add, Edit, w200 vGDPath
Gui, Add, Button, gInject, Inject DLL
Gui, Show, AutoSize
Return

Inject:
Gui, Submit, NoHide
if (FilePath = "") {
    MsgBox, Please enter a filepath
} else {
    if (Absolute = 0 and Extensions = 0) {
        MsgBox, Please select an option
    } else {
        if (!FileExist(FilePath)) {
            MsgBox, That file doesn't exist.
        } else if (SubStr(FilePath, -3) != ".dll") {
            MsgBox, File must be a DLL
        } else {
            if (GDPath = "") {
                if (Absolute = 1) {
                    FileAppend, `n%FilePath%, C:\Program Files (x86)\Steam\steamapps\common\Geometry Dash\absolutedlls
                    MsgBox, DLL injected through absolutedlls!
                } else if (Extensions = 1) {
                    if (!FileExist("C:\Program Files (x86)\Steam\steamapps\common\Geometry Dash\extensions")) {
                        FileCreateDir, C:\Program Files (x86)\Steam\steamapps\common\Geometry Dash\extensions
                    }
                    FileCopy, %FilePath%, C:\Program Files (x86)\Steam\steamapps\common\Geometry Dash\extensions
                    MsgBox, DLL injected through extensions folder!
                }
            } else {
                if (!FileExist(GDPath)) {
                    MsgBox, Geometry Dash directory doesn't exist.
                } else {
                    if (Absolute = 1) {
                        FileAppend, `n%FilePath%, %GDPath%\absolutedlls
                        MsgBox, DLL injected through absolutedlls!
                    } else if (Extensions = 1) {
                        if (!FileExist(GDPath . "\extensions")) {
                            FileCreateDir, %GDPath%\extensions
                        }
                        FileCopy, %FilePath%, %GDPath%\extensions
                        MsgBox, DLL injected through extensions folder!
                    }
                }
            }
        }
    }
}
Return