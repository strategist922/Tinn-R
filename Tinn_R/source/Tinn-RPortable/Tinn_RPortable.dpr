(*
 Tinn is a ASCII file editor primarily intended as a better replacement
 of the default Notepad.exe under Windows.

 This software is distributed under the terms of the GNU General
 Public License, either Version 2, June 1991 or Version 3, June 2007.
 The terms of version 2 and of the license are in a folder called
 doc (licence_gpl2.txt and licence_gpl2.txt)
 which you should have received with this software.

 See http://www.opensource.org/licenses/gpl-license.html or
 http://www.fsf.org/copyleft/gpl.html for further information.

 Copyright
  Russell May - http://www.solarvoid.com

 Tinn-R is an extension of Tinn that provides additional tools to control R
 (http://cran.r-project.org). The project is coordened by Jos� Cl�udio Faria
 (joseclaudio.faria@gmail.com).

 As such, Tinn-R is a feature-rich replacement of the basic script editor
 provided with Rgui. It provides syntax-highlighting, submission of code in
 whole, or line-by-line, and many other useful tools to ease writting and
 debugging of R code.

 Copyright
  Tinn-R team - http://nbcgib.uesc.br/lec/software/editores/tinn-r/en

 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; either version 2 and 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*)

program Tinn_RPortable;

uses
  Forms,
  Windows,
  SysUtils,
  Messages,
  Dialogs,
  classes,
  codeEditor in '..\Tinn-R\codeEditor.pas',
  diffUnit in '..\Tinn-R\diffUnit.pas',
  dirWatch in '..\Tinn-R\dirWatch.pas',
  fileView in '..\Tinn-R\fileView.pas' {frmFilesFrame: TFrame},
  findReplace in '..\Tinn-R\findReplace.pas',
  folderView in '..\Tinn-R\folderView.pas' {frmFoldersFrame: TFrame},
  hashUnit in '..\Tinn-R\hashUnit.pas',
  searches in '..\Tinn-R\searches.pas',
  trCodeSender in '..\Tinn-R\trCodeSender.pas',
  trRHistory in '..\Tinn-R\trRHistory.pas',
  trUtils in '..\Tinn-R\trUtils.pas',
  udmSyn in '..\Tinn-R\udmSyn.pas' {dmSyn: TDataModule},
  ufrmAbout in '..\Tinn-R\ufrmAbout.pas' {frmAbout},
  ufrmAppOptions in '..\Tinn-R\ufrmAppOptions.pas' {frmAppOptions},
  ufrmColors in '..\Tinn-R\ufrmColors.pas' {frmColors},
  ufrmConfigurePrint in '..\Tinn-R\ufrmConfigurePrint.pas' {frmConfigurePrint},
  ufrmConfirmReplace in '..\Tinn-R\ufrmConfirmReplace.pas' {frmConfirmReplaceDialog},
  ufrmCount in '..\Tinn-R\ufrmCount.pas' {frmCount},
  ufrmEditor in '..\Tinn-R\ufrmEditor.pas' {frmEditor},
  ufrmGotoBox in '..\Tinn-R\ufrmGotoBox.pas' {frmGotoBox},
  ufrmGroupRename in '..\Tinn-R\ufrmGroupRename.pas' {frmGroupRename},
  ufrmHotKeys in '..\Tinn-R\ufrmHotKeys.pas' {frmHotKeys},
  ufrmLatexDimensional in '..\Tinn-R\ufrmLatexDimensional.pas' {frmLatexDimensional},
  ufrmNewGoup in '..\Tinn-R\ufrmNewGoup.pas' {frmNewGroup},
  ufrmPandoc in '..\Tinn-R\ufrmPandoc.pas' {frmPandoc},
  ufrmPrintPreview in '..\Tinn-R\ufrmPrintPreview.pas' {frmPrintPreview},
  ufrmRcard in '..\Tinn-R\ufrmRcard.pas' {frmRcard},
  ufrmReplaceText in '..\Tinn-R\ufrmReplaceText.pas' {frmReplaceDialog},
  ufrmRServer in '..\Tinn-R\ufrmRServer.pas' {frmRServer},
  ufrmRterm in '..\Tinn-R\ufrmRterm.pas' {frmRterm},
  ufrmSearchInFiles in '..\Tinn-R\ufrmSearchInFiles.pas' {frmSearchInFiles},
  ufrmSearchText in '..\Tinn-R\ufrmSearchText.pas' {frmSearchDialog},
  ufrmShortcuts in '..\Tinn-R\ufrmShortcuts.pas' {frmShortcuts},
  ufrmSplash in '..\Tinn-R\ufrmSplash.pas' {frmSplash},
  ufrmTools in '..\Tinn-R\ufrmTools.pas' {frmTools},
  uModDados in '..\Tinn-R\uModDados.pas' {modDados: TDataModule},
  ufrmDiffMain in '..\diff\ufrmDiffMain.pas' {frmDiffMain},
  sndkey32 in '..\others\sndkey32.pas',
  uActionMacro in '..\others\uActionMacro.pas',
  ufrmAsciiChart in '..\others\ufrmAsciiChart.pas' {frmAsciiChart},
  ATxCodepages in '..\others\ATxCodepages.pas',
  SynEditPrintPreview in '..\SynEdit_adapted\SynEditPrintPreview.pas',
  SynEditStrConst in '..\SynEdit_adapted\SynEditStrConst.pas',
  SynCompletionProposal in '..\SynEdit_adapted\SynCompletionProposal.pas',
  SynHighlighterAll in '..\SynEdit_highlighters\SynHighlighterAll.pas',
  SynHighlighterR in '..\SynEdit_highlighters\SynHighlighterR.pas',
  SynHighlighterR_term in '..\SynEdit_highlighters\SynHighlighterR_term.pas',
  SynHighlighterTeX in '..\SynEdit_highlighters\SynHighlighterTeX.pas',
  SynHighlighterText in '..\SynEdit_highlighters\SynHighlighterText.pas',
  SynHighlighterText_term in '..\SynEdit_highlighters\SynHighlighterText_term.pas',
  SynHighlighterURI in '..\SynEdit_highlighters\SynHighlighterURI.pas',
  ufrmComments in '..\Tinn-R\ufrmComments.pas' {frmComments},
  ufrmCompletion in '..\Tinn-R\ufrmCompletion.pas' {frmCompletion},
  ufrmRmirrors in '..\Tinn-R\ufrmRmirrors.pas' {frmRmirrors},
  SynEditOC in '..\SynEdit_adapted\SynEditOC.pas',
  Split in '..\others\Split.pas',
  ufrmMain in 'ufrmMain.pas' {frmTinnMain};

{$R Tinn_RPortable.KLR}
{$R *.RES}

var
  hPrevious, hMutex: HWnd;
  slFilesStarting  : TStringList;
  i                : integer;
  cTemp            : PChar;
  sTemp            : string;

{This code, to allow file association and open clicked files in the running
 instance of app was written by Andrius Adamonis}
function EnumWindowsCallback(hHandle: HWnd; lpParam: LParam): Boolean; Stdcall;

  function IsMyClass: Boolean;
  var
    aClassName: array[0..30] of Char;

  begin
    GetClassName(hHandle, aClassName, 30);
    Result:= (StrIComp(aClassName, 'TfrmTinnMain') = 0) and
             (SendMessage(hHandle, WM_FINDINSTANCE, 0, 0) = MyUniqueConst);
  end;

begin
  Result:= not IsMyClass; // Needs True to continue
  if not Result then hPrevious:= hHandle;
end;

procedure FillFileList(slFile: TStringList);
var
  i, iPos : integer;
  hHandle : THandle;
  curFile : WIN32_FIND_DATA;
  sPath   : string;

begin
  for i:= 1 to ParamCount do begin // Loop through all the parameters and build a file list
    iPos:= pos('*', ParamStr(i));
    if (iPos > 0) then begin // Do multi file globbing
      sPath  := ExtractFilePath(ExpandFileName(ParamStr(i)));
      hHandle:= FindFirstFile(PChar(ParamStr(i)), curFile);
      if FileExists(sPath + curFile.cFilename) then slFile.Add('"' + sPath + curFile.cFilename + '"');
      while FindNextFile(hHandle, curFile) do
        if FileExists(sPath + curFile.cFilename) then slFile.Add('"' + sPath + curFile.cFilename + '"');
    end // End globbing
    else begin	// Do single file open
      if FileExists(ParamStr(i)) then begin // Check for file
        if (i < ParamCount) then iPos:= pos('lin=', ParamStr(i + 1))// Check for line number
                            else iPos:= -1;
        if (iPos > 0) then slFile.Add('"' + ExpandFileName(ParamStr(i)) + '"' + ',' + Copy(ParamStr(i+1), iPos + 3, length(ParamStr(i+1))))
                      else slFile.Add('"' + ExpandFileName(ParamStr(i)) + '"');
      end
      else begin // Create a new file
        // Check for the line request
        iPos:= pos('lin=', ParamStr(i));
        if (iPos = 0) then begin
          sPath:= ExtractFilePath(ExpandFileName(ParamStr(i)));
          // if the path isn't already in the file name, add it
          if (Pos(sPath, ParamStr(i)) = 0) then slFile.Add('"' + sPath + ParamStr(i) + '"')
                                           else slFile.Add('"' + ParamStr(i) + '"');
        end;
      end;
    end; // End single file open
  end; // End param loop
end;

procedure SendString(sToSend: string);
var
  copyDataStruct: TCopyDataStruct;

begin
  copyDataStruct.dwData:= 0; //Use it to identify the message contents
  //copyDataStruct.cbData:= 1 + Length(sToSend);
  copyDataStruct.cbData:= (length(sToSend) + 1) * sizeof(char); //Radoslaw Bujak
  copyDataStruct.lpData:= PChar(sToSend);
  SendMessage(hPrevious, WM_COPYDATA, Integer(hPrevious), Integer(@copyDataStruct));
end;

begin
  slFilesStarting:= TStringList.Create;
  hPrevious:= 0;
  EnumWindows(@EnumWindowsCallback, 0);

  // The condition below avoid multiples instances of Tinn-R!
  // If Tinn-R IS RUNNIG and the user select more than one
  // associated file from win_explorer.
  //PS: NOT CHANGE THIS PLACE
  if (hPrevious <> 0) then begin
    SetForegroundWindow(hPrevious);
    PostMessage(hPrevious, WM_RESTOREAPP, 0, 0);
    if (ParamCount > 0) then begin
      FillFileList(slFilesStarting);
      if (slFilesStarting.Count > 0) then begin
        for i:= 0 to (slFilesStarting.Count - 1) do
          SendString(slFilesStarting.Strings[i]);
      end;
    end;
    Exit;
  end;

  // The condition below avoid multiples instances of Tinn-R!
  // If Tinn-R IS NOT RUNNIG and the user select more than one
  // associated file from win_explorer, it will open one.
  //PS: NOT CHANGE THIS PLACE
  hMutex:= CreateMutex(nil, True, 'Tinn-R');
  if (GetLastError <> 0) then begin
    CloseHandle(hMutex);
    Exit;
  end;

  frmSplash:= TfrmSplash.Create(Application);
  frmSplash.Show;
  frmSplash.Update;
  Application.Initialize;

  Application.Title := 'Tinn-R Editor';
  Application.HelpFile:= '';
  Application.CreateForm(TfrmTinnMain, frmTinnMain);
  if (ParamCount > 0) then FillFileList(slFilesStarting);
  if (slFilesStarting.Count > 0) then begin
    dmSyn.boolLoadedFileFromStartUp:= True;
    cTemp:= PChar(slFilesStarting.Strings[0]);
    sTemp:= AnsiExtractQuotedStr(cTemp, '"');
    frmTinnMain.CheckIfFileFromDVI(sTemp);
  end;
  FreeAndNil(slFilesStarting);
  frmSplash.Hide;
  frmSplash.Free;
  Application.Run;
end.
