#SingleInstance force

evernote = "c:\Users\tadatuta\AppData\Local\Apps\Evernote\Evernote\Evernote.exe"
tc = "c:\Program Files (x86)\totalcmd\TOTALCMD64.EXE"
dpPath = %ProgramFiles%\Dexpot\dexpot.exe
snippingTool = "c:\Windows\System32\SnippingTool.exe"


; win + f1 - run evernote.
#F1::
    Run, %evernote%
    return

; win + f2 - run total commander.
#F2::
    Run, %tc%
    return

; win + f3 - run snipping tool.
#F3::
    Run, %snippingTool%
    return


; Control instead of capslock.
Capslock::Control

;;;;;;; Dexpot ;;;;;;;

; control + alt + 1 - switch desktop 1.
if WinExist("ahk_exe dexpot.exe")
    ^!1::Send #^!1
    return

if WinExist("ahk_exe dexpot.exe")
    ^!2::Send #^!2
    return

if WinExist("ahk_exe dexpot.exe")
    ^!3::Send #^!3
    return

; control + alt + shift + 1 - move window to desktop 1.
if WinExist("ahk_exe dexpot.exe")
    ^!+1::Send #^!+1
    return

if WinExist("ahk_exe dexpot.exe")
    ^!+2::Send #^!+2
    return

if WinExist("ahk_exe dexpot.exe")
    ^!+3::Send #^!+3
    return


;;;;;;; PDF-X Viewer ;;;;;;;
#IfWinActive ahk_class DSUI:PDFXCViewer
    >!j::Send {Down}
    return

#IfWinActive ahk_class DSUI:PDFXCViewer
    >!k::Send {Up}
    return


;;;;;;; Total Commander ;;;;;;;
; lalt + j - down.
#IfWinActive, ahk_class TTOTAL_CMD
    <!j::Send, {Down}
    return

; lalt + k - up.
#IfWinActive, ahk_class TTOTAL_CMD
    <!k::Send, {Up}
    return

; lalt + l - enter.
#IfWinActive, ahk_class TTOTAL_CMD
    <!l::Send, {Enter}
    return

; lalt + h - backspace.
#IfWinActive, ahk_class TTOTAL_CMD
    <!h::Send, {Backspace}
    return

; alt + shift + j - pgdown.
#IfWinActive, ahk_class TTOTAL_CMD
    !+j::Send, {PGDN}
    return

; alt + shift + k - pgup.
#IfWinActive, ahk_class TTOTAL_CMD
    !+k::Send, {PGUP}
    return

; alt + shift + d - delete.
#IfWinActive, ahk_class TTOTAL_CMD
    !+d::PostMessage, 0x433, 908,,, ahk_class TTOTAL_CMD
    return

; alt + shift + h - back.
#IfWinActive, ahk_class TTOTAL_CMD
    !+h::PostMessage, 0x433, 573,,, ahk_class TTOTAL_CMD
    return

; alt + shift + l - forward.
#IfWinActive, ahk_class TTOTAL_CMD
    !+l::PostMessage, 0x433, 574,,, ahk_class TTOTAL_CMD
    return

; alt + shift + r - rename.
#IfWinActive, ahk_class TTOTAL_CMD
    !+r::PostMessage, 0x433, 1002,,, ahk_class TTOTAL_CMD
    return

; alt + shift + u - go to up folder.
#IfWinActive, ahk_class TTOTAL_CMD
    !+u::PostMessage, 0x433, 2002,,, ahk_class TTOTAL_CMD
    return

; alt + shift + i - go to root folder.
#IfWinActive, ahk_class TTOTAL_CMD
    !+i::PostMessage, 0x433, 2001,,, ahk_class TTOTAL_CMD
    return

; alt + shift + ctrl + r - create folder.
#IfWinActive, ahk_class TTOTAL_CMD
    !+^c::PostMessage, 0x433, 907,,, ahk_class TTOTAL_CMD
    return

