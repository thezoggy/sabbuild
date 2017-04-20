; -*- coding: latin-1 -*-
;
; Copyright 2008-2015 The SABnzbd-Team <team@sabnzbd.org>
;
; This program is free software; you can redistribute it and/or
; modify it under the terms of the GNU General Public License
; as published by the Free Software Foundation; either version 2
; of the License, or (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with this program; if not, write to the Free Software
; Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

!addplugindir ..\win\nsis\Plugins
!addincludedir ..\win\nsis\Include

!include "MUI2.nsh"
!include "registerExtension.nsh"
!include "FileFunc.nsh"
!include "LogicLib.nsh"
!include "WinVer.nsh"
!include "WinSxSQuery.nsh"
!include "nsProcess.nsh"
!include "x64.nsh"
!include "servicelib.nsh"
!include "UAC.nsh"

;------------------------------------------------------------------
;
; Marco for removing existing and the current installation
; It shared by the installer and the uninstaller.
; Make sure it covers 0.5.x, 0.6.x, 0.7.x and 0.8.x in one go.
;
; DON'T DELETE THE WHOLE FOLDER! Some users store the sabnzbd.ini
; and scripts in the install directory... Oops!
;
!define RemovePrev "!insertmacro RemovePrev"
!macro RemovePrev idir
  Delete   "${idir}\email\email-de.tmpl"
  Delete   "${idir}\email\email-en.tmpl"
  Delete   "${idir}\email\email-nl.tmpl"
  Delete   "${idir}\email\email-fr.tmpl"
  Delete   "${idir}\email\email-fi.tmpl"
  Delete   "${idir}\email\email-sv.tmpl"
  Delete   "${idir}\email\email-da.tmpl"
  Delete   "${idir}\email\email-nb.tmpl"
  Delete   "${idir}\email\email-pl.tmpl"
  Delete   "${idir}\email\email-ro.tmpl"
  Delete   "${idir}\email\email-sr.tmpl"
  Delete   "${idir}\email\email-es.tmpl"
  Delete   "${idir}\email\email-pt_BR.tmpl"
  Delete   "${idir}\email\email-sr.tmpl"
  Delete   "${idir}\email\email-ru.tmpl"
  Delete   "${idir}\email\email-zh_CN.tmpl"
  Delete   "${idir}\email\rss-de.tmpl"
  Delete   "${idir}\email\rss-en.tmpl"
  Delete   "${idir}\email\rss-nl.tmpl"
  Delete   "${idir}\email\rss-pl.tmpl"
  Delete   "${idir}\email\rss-fr.tmpl"
  Delete   "${idir}\email\rss-fi.tmpl"
  Delete   "${idir}\email\rss-sv.tmpl"
  Delete   "${idir}\email\rss-da.tmpl"
  Delete   "${idir}\email\rss-nb.tmpl"
  Delete   "${idir}\email\rss-ro.tmpl"
  Delete   "${idir}\email\rss-sr.tmpl"
  Delete   "${idir}\email\rss-es.tmpl"
  Delete   "${idir}\email\rss-pt_BR.tmpl"
  Delete   "${idir}\email\rss-sr.tmpl"
  Delete   "${idir}\email\rss-ru.tmpl"
  Delete   "${idir}\email\rss-zh_CN.tmpl"
  Delete   "${idir}\email\badfetch-da.tmpl"
  Delete   "${idir}\email\badfetch-de.tmpl"
  Delete   "${idir}\email\badfetch-en.tmpl"
  Delete   "${idir}\email\badfetch-fr.tmpl"
  Delete   "${idir}\email\badfetch-fi.tmpl"
  Delete   "${idir}\email\badfetch-nb.tmpl"
  Delete   "${idir}\email\badfetch-nl.tmpl"
  Delete   "${idir}\email\badfetch-pl.tmpl"
  Delete   "${idir}\email\badfetch-ro.tmpl"
  Delete   "${idir}\email\badfetch-sr.tmpl"
  Delete   "${idir}\email\badfetch-sv.tmpl"
  Delete   "${idir}\email\badfetch-sr.tmpl"
  Delete   "${idir}\email\badfetch-es.tmpl"
  Delete   "${idir}\email\badfetch-pt_BR.tmpl"
  Delete   "${idir}\email\badfetch-ru.tmpl"
  Delete   "${idir}\email\badfetch-zh_CN.tmpl"
  RMDir    "${idir}\email"
  Delete   "${idir}\scripts\Sample-PostProc.cmd"
  Delete   "${idir}\scripts\Sample-PostProc.sh"
  RMDir    "${idir}\scripts" ; Only remove if empty!
  RMDir /r "${idir}\locale"
  RMDir /r "${idir}\interfaces\Classic"
  RMDir /r "${idir}\interfaces\Plush"
  RMDir /r "${idir}\interfaces\smpl"
  RMDir /r "${idir}\interfaces\Mobile"
  RMDir /r "${idir}\interfaces\wizard"
  RMDir /r "${idir}\interfaces\Config"
  RMDir /r "${idir}\interfaces\Glitter"
  RMDir    "${idir}\interfaces"
  RMDir /r "${idir}\win\curl"
  RMDir /r "${idir}\win\par2"
  RMDir /r "${idir}\win\unrar"
  RMDir /r "${idir}\win\unzip"
  RMDir /r "${idir}\win"
  RMDir /r "${idir}\licenses"
  RMDir /r "${idir}\lib\"
  RMDir /r "${idir}\po\email"
  RMDir /r "${idir}\po\main"
  RMDir /r "${idir}\po\nsis"
  RMDir    "${idir}\po"
  RMDir /r "${idir}\icons"
  Delete   "${idir}\CHANGELOG.txt"
  Delete   "${idir}\COPYRIGHT.txt"
  Delete   "${idir}\email.tmpl"
  Delete   "${idir}\GPL2.txt"
  Delete   "${idir}\GPL3.txt"
  Delete   "${idir}\INSTALL.txt"
  Delete   "${idir}\ISSUES.txt"
  Delete   "${idir}\LICENSE.txt"
  Delete   "${idir}\nzbmatrix.txt"
  Delete   "${idir}\MSVCR71.dll"
  Delete   "${idir}\nzb.ico"
  Delete   "${idir}\sabnzbd.ico"
  Delete   "${idir}\PKG-INFO"
  Delete   "${idir}\python25.dll"
  Delete   "${idir}\python26.dll"
  Delete   "${idir}\python27.dll"
  Delete   "${idir}\README.txt"
  Delete   "${idir}\README.rtf"
  Delete   "${idir}\ABOUT.txt"
  Delete   "${idir}\IMPORTANT_MESSAGE.txt"
  Delete   "${idir}\SABnzbd-console.exe"
  Delete   "${idir}\SABnzbd.exe"
  Delete   "${idir}\SABnzbd.exe.log"
  Delete   "${idir}\SABnzbd-helper.exe"
  Delete   "${idir}\SABnzbd-service.exe"
  Delete   "${idir}\portable.cmd"
  Delete   "${idir}\Sample-PostProc.cmd"
  Delete   "${idir}\Uninstall.exe"
  Delete   "${idir}\w9xpopen.exe"
  ; Only remove if nothing left in the folder
  RMDir    "${idir}"
!macroend

;------------------------------------------------------------------
; Define names of the product
  Name "${SAB_PRODUCT}"
  OutFile "${SAB_FILE}"
  InstallDir "$PROGRAMFILES\SABnzbd"


;------------------------------------------------------------------
; Some default compiler settings (uncomment and change at will):
  SetCompress auto ; (can be off or force)
  SetDatablockOptimize on ; (can be off)
  CRCCheck on ; (can be off)
  AutoCloseWindow false ; (can be true for the window go away automatically at end)
  ShowInstDetails hide ; (can be show to have them shown, or nevershow to disable)
  SetDateSave off ; (can be on to have files restored to their orginal date)
  WindowIcon on
  SpaceTexts none


;------------------------------------------------------------------
; Vista/Win7 redirects $SMPROGRAMS to all users without this
  RequestExecutionLevel admin
  FileErrorText "If you have no admin rights, try to install into a user directory."


;------------------------------------------------------------------
;Variables
  Var MUI_TEMP
  Var STARTMENU_FOLDER
  Var PREV_INST_DIR

;------------------------------------------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

  ;Show all languages, despite user's codepage
  !define MUI_LANGDLL_ALLLANGUAGES

  !define MUI_ICON "common/icons/sabnzbd.ico"


;--------------------------------
;Pages

  !insertmacro MUI_PAGE_LICENSE "common/LICENSE.txt"
  !define MUI_COMPONENTSPAGE_NODESC
  !insertmacro MUI_PAGE_COMPONENTS

  !insertmacro MUI_PAGE_DIRECTORY

  ;Start Menu Folder Page Configuration
  !define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU"
  !define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\SABnzbd"
  !define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"
  !define MUI_STARTMENUPAGE_DEFAULTFOLDER "SABnzbd"
  ;Remember the installer language
  !define MUI_LANGDLL_REGISTRY_ROOT "HKCU"
  !define MUI_LANGDLL_REGISTRY_KEY "Software\SABnzbd"
  !define MUI_LANGDLL_REGISTRY_VALUENAME "Installer Language"

  !insertmacro MUI_PAGE_STARTMENU Application $STARTMENU_FOLDER

  !insertmacro MUI_PAGE_INSTFILES
  ; !define MUI_FINISHPAGE_RUN
  ; !define MUI_FINISHPAGE_RUN_FUNCTION PageFinishRun
  ; !define MUI_FINISHPAGE_RUN_TEXT $(MsgRunSAB)
  !define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\README.txt"
  !define MUI_FINISHPAGE_SHOWREADME_TEXT $(MsgShowRelNote)
  !define MUI_FINISHPAGE_LINK $(MsgSupportUs)
  !define MUI_FINISHPAGE_LINK_LOCATION "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=670741"

  !insertmacro MUI_PAGE_FINISH

  !insertmacro MUI_UNPAGE_CONFIRM
  !define MUI_UNPAGE_COMPONENTSPAGE_NODESC
  !insertmacro MUI_UNPAGE_COMPONENTS
  !insertmacro MUI_UNPAGE_INSTFILES

;------------------------------------------------------------------
; Run as user-level at end of install
; DOES NOT WORK
; Function PageFinishRun
;   !insertmacro UAC_AsUser_ExecShell "" "$INSTDIR\SABnzbd.exe" "" "" ""
; FunctionEnd


;------------------------------------------------------------------
; Set supported languages
  !insertmacro MUI_LANGUAGE "English" ;first language is the default language
  !insertmacro MUI_LANGUAGE "French"
  !insertmacro MUI_LANGUAGE "German"
  !insertmacro MUI_LANGUAGE "Dutch"
  !insertmacro MUI_LANGUAGE "Finnish"
  !insertmacro MUI_LANGUAGE "Polish"
  !insertmacro MUI_LANGUAGE "Swedish"
  !insertmacro MUI_LANGUAGE "Danish"
  !insertmacro MUI_LANGUAGE "NORWEGIAN"
  !insertmacro MUI_LANGUAGE "Romanian"
  !insertmacro MUI_LANGUAGE "Spanish"
  !insertmacro MUI_LANGUAGE "PortugueseBR"
  !insertmacro MUI_LANGUAGE "Serbian"
  !insertmacro MUI_LANGUAGE "Russian"
  !insertmacro MUI_LANGUAGE "SimpChinese"


;------------------------------------------------------------------
;Reserve Files
  ;If you are using solid compression, files that are required before
  ;the actual installation should be stored first in the data block,
  ;because this will make your installer start faster.

  !insertmacro MUI_RESERVEFILE_LANGDLL


;------------------------------------------------------------------
; SECTION main program
;
Section "SABnzbd" SecDummy

  SetOutPath "$INSTDIR"

  ;------------------------------------------------------------------
  ; In case we moved installation directories and service is installed
  ; we warn that they need to change it
  ${If} ${RunningX64}
    IfFileExists "$PROGRAMFILES32\SABnzbd\SABnzbd.exe" 0 endDirSwitchCheck
      ; Only when the service is installed
      !insertmacro SERVICE "installed" "SABnzbd" ""
      Pop $0 ;response
      ${If} $0 == true
        MessageBox MB_OK $(MsgCheckDir)
      ${EndIf}
    endDirSwitchCheck:
  ${EndIf}

  ;------------------------------------------------------------------
  ; Make sure old versions are gone (reg-key already read in onInt)
  StrCmp $PREV_INST_DIR "" noPrevInstallRemove
    ${RemovePrev} "$PREV_INST_DIR"
  noPrevInstallRemove:

  ; add files / whatever that need to be installed here.
  File /r "common\*"
  ${If} ${RunningX64}
    File /r "x64\*"
  ${Else}
    File /r "win32\*"
  ${EndIf}

  ;------------------------------------------------------------------
  ; Add firewall rule
  liteFirewallW::AddRule "$INSTDIR\SABnzbd.exe" "SABnzbd"

  ;------------------------------------------------------------------
  ; Add to registery
  WriteRegStr HKEY_LOCAL_MACHINE "SOFTWARE\SABnzbd" "" "$INSTDIR"
  WriteRegStr HKEY_LOCAL_MACHINE "SOFTWARE\SABnzbd" "Installer Language" "$(MsgLangCode)"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\SABnzbd" "DisplayName" "SABnzbd ${SAB_VERSION}"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\SABnzbd" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\SABnzbd" "DisplayVersion" '${SAB_VERSION}'
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\SABnzbd" "Publisher" 'The SABnzbd Team'
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\SABnzbd" "HelpLink" 'https://forums.sabnzbd.org/'
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\SABnzbd" "URLInfoAbout" 'https://sabnzbd.org/wiki/'
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\SABnzbd" "URLUpdateInfo" 'https://sabnzbd.org/'
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\SABnzbd" "Comments" 'The automated Usenet download tool'
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\SABnzbd" "DisplayIcon" '$INSTDIR\icons\sabnzbd.ico'
  WriteRegDWORD HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\SABnzbd" "EstimatedSize"  25674
  WriteRegDWORD HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\SABnzbd" "NoRepair" -1
  WriteRegDWORD HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\SABnzbd" "NoModify" -1
  ; write out uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    ;Create shortcuts
    CreateDirectory "$SMPROGRAMS\$STARTMENU_FOLDER"
    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\SABnzbd.lnk" "$INSTDIR\SABnzbd.exe"
    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\SABnzbd - SafeMode.lnk" "$INSTDIR\SABnzbd.exe" "--server 127.0.0.1:8080 -b1 --no-login"
    WriteINIStr "$SMPROGRAMS\$STARTMENU_FOLDER\SABnzbd - Documentation.url" "InternetShortcut" "URL" "https://sabnzbd.org/wiki/"
    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Uninstall.lnk" "$INSTDIR\Uninstall.exe"
  !insertmacro MUI_STARTMENU_WRITE_END
SectionEnd ; end of default section

Section $(MsgIcon) desktop
  CreateShortCut "$DESKTOP\SABnzbd.lnk" "$INSTDIR\SABnzbd.exe"
SectionEnd ; end of desktop icon section

Section $(MsgAssoc) assoc
  ${registerExtension} "$INSTDIR\icons\nzb.ico" "$INSTDIR\SABnzbd.exe" ".nzb" "NZB File"
  ${RefreshShellIcons}
SectionEnd ; end of file association section

Section /o $(MsgRunAtStart) startup
  CreateShortCut "$SMPROGRAMS\Startup\SABnzbd.lnk" "$INSTDIR\SABnzbd.exe" "-b0"
SectionEnd ;

;------------------------------------------------------------------
Function .onInit
  ; We need to modify the dir here for X64
  ${If} ${RunningX64}
      StrCpy $INSTDIR "$PROGRAMFILES64\SABnzbd"
  ${Else}
      StrCpy $INSTDIR "$PROGRAMFILES\SABnzbd"
  ${EndIf}

  ;------------------------------------------------------------------
  ; Change settings based on if SAB was already installed
  ReadRegStr $PREV_INST_DIR HKEY_LOCAL_MACHINE "SOFTWARE\SABnzbd" ""
  StrCmp $PREV_INST_DIR "" noPrevInstall
    ; We want to use the user's costom dir if he used one
    StrCmp $PREV_INST_DIR "$PROGRAMFILES\SABnzbd" noSpecialDir
      StrCmp $PREV_INST_DIR "$PROGRAMFILES64\SABnzbd" noSpecialDir
        ; Set what the user had before
        StrCpy $INSTDIR "$PREV_INST_DIR"
    noSpecialDir:

    ;------------------------------------------------------------------
    ; Check what the user has currently set for install options
    IfFileExists "$SMPROGRAMS\Startup\SABnzbd.lnk" 0 endCheckStartup
      SectionSetFlags ${startup} 1
    endCheckStartup:

    IfFileExists "$DESKTOP\SABnzbd.lnk" endCheckDesktop 0
      SectionSetFlags ${desktop} 0 ; SAB is installed but desktop-icon not, so uncheck it
    endCheckDesktop:

    Push $1
    ReadRegStr $1 HKCR ".nzb" ""  ; read current file association
    StrCmp "$1" "NZB File" noPrevInstall 0
      SectionSetFlags ${assoc} 0 ; Uncheck it when it wasn't checked before
  noPrevInstall:

  ;--------------------------------
  ; Display language chooser
  !insertmacro MUI_LANGDLL_DISPLAY

  ;--------------------------------
  ;make sure that the requires MS Runtimes are installed
  ;
  goto nodownload ; Problems, most Windows systems already have it
  runtime_loop:
    push 'msvcr90.dll'
    push 'Microsoft.VC90.CRT,version="9.0.30729.6161",type="win32",processorArchitecture="x86",publicKeyToken="1fc8b3b9a1e18e3b"'
    call WinSxS_HasAssembly
    pop $0

    StrCmp $0 "1" nodownload
      MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION $(MsgNoRuntime) /SD IDOK IDOK download IDCANCEL noinstall
      download:
        inetc::get /BANNER $(MsgDLRuntime) \
        "http://download.microsoft.com/download/f/6/7/f67fdf05-0586-413f-8231-affbe12f80a8/VS90sp1-KB945140-ENU.exe" \
        "$TEMP\vcredist_x86.exe"
        Pop $0
        DetailPrint "Downloaded MS runtime library"
        StrCmp $0 "OK" dlok
          MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION $(MsgDLError) /SD IDCANCEL IDCANCEL exitinstall IDOK download
        dlok:
          ExecWait "$TEMP\vcredist_x86.exe" $1
          DetailPrint "VCRESULT=$1"
          DetailPrint "Tried to install MS runtime library"
          delete "$TEMP\vcredist_x86.exe"
          StrCmp $1 "0" nodownload
        noinstall:
          MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION $(MsgDLNeed) /SD IDOK IDOK runtime_loop IDCANCEL exitinstall
          Abort
    nodownload:


  ;------------------------------------------------------------------
  ; make sure user terminates sabnzbd.exe or else abort
  ;
  loop:
    ${nsProcess::FindProcess} "SABnzbd.exe" $R0
    StrCmp $R0 0 0 endcheck
    MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION $(MsgCloseSab) IDOK loop IDCANCEL exitinstall
    exitinstall:
      ${nsProcess::Unload}
      Abort
  endcheck:

  ;------------------------------------------------------------------
  ; make sure both services aren't running
  ;
  !insertmacro SERVICE "running" "SABnzbd" ""
  Pop $0 ;response
  !insertmacro SERVICE "running" "SABHelper" ""
  Pop $1
  ${If} $0 == true
  ${OrIf} $1 == true
    MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION $(MsgCloseSab) IDOK loop IDCANCEL exitinstall
    ; exitinstall already defined above
  ${EndIf}

FunctionEnd

;------------------------------------------------------------------
; Show the shortcuts at end of install so user can start SABnzbd
; This is instead of us trying to run SAB from the installer
;
Function .onInstSuccess
  ExecShell "open" "$SMPROGRAMS\$STARTMENU_FOLDER"
FunctionEnd

;--------------------------------
; begin uninstall settings/section
UninstallText $(MsgUninstall)

Section "un.$(MsgDelProgram)" Uninstall
;make sure sabnzbd.exe isnt running..if so shut it down
  ${nsProcess::KillProcess} "SABnzbd.exe" $R0
  ${nsProcess::Unload}
  DetailPrint "Process Killed"


  ; add delete commands to delete whatever files/registry keys/etc you installed here.
  Delete "$INSTDIR\uninstall.exe"
  DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\SABnzbd"
  DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\SABnzbd"

  ${RemovePrev} "$INSTDIR"

  !insertmacro MUI_STARTMENU_GETFOLDER Application $MUI_TEMP

  Delete "$SMPROGRAMS\$MUI_TEMP\SABnzbd.lnk"
  Delete "$SMPROGRAMS\$MUI_TEMP\Uninstall.lnk"
  Delete "$SMPROGRAMS\$MUI_TEMP\SABnzbd - SafeMode.lnk"
  Delete "$SMPROGRAMS\$MUI_TEMP\SABnzbd - Documentation.url"
  RMDir  "$SMPROGRAMS\$MUI_TEMP"

  Delete "$SMPROGRAMS\Startup\SABnzbd.lnk"

  Delete "$DESKTOP\SABnzbd.lnk"

  DeleteRegKey HKEY_CURRENT_USER  "Software\SABnzbd"

  ${unregisterExtension} ".nzb" "NZB File"
  ${RefreshShellIcons}

SectionEnd ; end of uninstall section

Section /o "un.$(MsgDelSettings)" DelSettings
  DetailPrint "Uninstall settings $LOCALAPPDATA"
  Delete "$LOCALAPPDATA\sabnzbd\sabnzbd.ini"
  RMDir /r "$LOCALAPPDATA\sabnzbd"
SectionEnd

; eof

;--------------------------------
;Language strings
  LangString MsgShowRelNote ${LANG_ENGLISH} "Show Release Notes"

  ; LangString MsgRunSAB      ${LANG_ENGLISH} "Start SABnzbd"

  LangString MsgSupportUs   ${LANG_ENGLISH} "Support the project, Donate!"

  LangString MsgCloseSab    ${LANG_ENGLISH} "Please close $\"SABnzbd.exe$\" first"

  LangString MsgCheckDir    ${LANG_ENGLISH} "The installation directory has changed (now in $\"Program Files$\"). $\nIf you run SABnzbd as a service, you need to update the service settings."

  LangString MsgUninstall   ${LANG_ENGLISH} "This will uninstall SABnzbd from your system"

  LangString MsgRunAtStart  ${LANG_ENGLISH} "Run at startup"

  LangString MsgIcon        ${LANG_ENGLISH} "Desktop Icon"

  LangString MsgAssoc       ${LANG_ENGLISH} "NZB File association"

  LangString MsgDelProgram  ${LANG_ENGLISH} "Delete Program"

  LangString MsgDelSettings ${LANG_ENGLISH} "Delete Settings"

  LangString MsgNoRuntime   ${LANG_ENGLISH} "This system requires the Microsoft runtime library VC90 to be installed first. Do you want to do that now?"

  LangString MsgDLRuntime   ${LANG_ENGLISH} "Downloading Microsoft runtime installer..."

  LangString MsgDLError     ${LANG_ENGLISH} "Download error, retry?"

  LangString MsgDLNeed      ${LANG_ENGLISH} "Cannot install without runtime library, retry?"

  LangString MsgRemoveOld   ${LANG_ENGLISH} "You cannot overwrite an existing installation. $\n$\nClick `OK` to remove the previous version or `Cancel` to cancel this upgrade."

  LangString MsgRemoveOld2  ${LANG_ENGLISH} "Your settings and data will be preserved."

  LangString MsgLangCode    ${LANG_ENGLISH} "en"

Function un.onInit
  !insertmacro MUI_UNGETLANGUAGE
FunctionEnd
