unit WK.Messages;

interface

uses
  windows, forms;

procedure MsgBox      (const ARotulo : String);
procedure MsgBoxAlert (const ARotulo : String);
procedure MsgBoxError (const ARotulo : String);
function  MsgBoxConfirmDefYes (const ARotulo : String) : Boolean;
function  MsgBoxConfirmDefYesCancel (const ARotulo : String) : Integer;
function  MsgBoxConfirmDefNo  (const ARotulo : String) : Boolean;
function  MsgBoxErrorDefNo    (const ARotulo : String) : Boolean;


implementation

procedure MsgBox (const ARotulo : String);
begin
  Application.MessageBox(PChar(ARotulo), PChar(Application.Title), mb_Ok + MB_ICONASTERISK + mb_DefButton1 + mb_applmodal);
end;

procedure MsgBoxAlert (const ARotulo : String);
begin
  Application.MessageBox(PChar(ARotulo), PChar(Application.Title), mb_Ok + MB_ICONEXCLAMATION + mb_DefButton1 + mb_applmodal);
end;

procedure MsgBoxError (const ARotulo : String);
begin
  Application.MessageBox(PChar(ARotulo), PChar(Application.Title), mb_Ok + MB_ICONERROR + mb_DefButton1 + mb_applmodal);
end;

function  MsgBoxConfirmDefYes (const ARotulo : String) : Boolean;
begin
  Result := Application.MessageBox(PChar(ARotulo), PChar(Application.Title), MB_YESNO + MB_ICONQUESTION + mb_DefButton1 + mb_applmodal) = idYes;
end;

function  MsgBoxConfirmDefYesCancel (const ARotulo : String) : Integer;
begin
  Result := Application.MessageBox(PChar(ARotulo), PChar(Application.Title), MB_YESNOCANCEL + MB_ICONQUESTION + mb_DefButton1 + mb_applmodal);
end;

function  MsgBoxConfirmDefNo  (const ARotulo : String) : Boolean;
begin
  Result := Application.MessageBox(PChar(ARotulo), PChar(Application.Title), MB_YESNO + MB_ICONQUESTION + mb_DefButton2 + mb_applmodal) = idYes;
end;

function  MsgBoxErrorDefNo (const ARotulo : String) : Boolean;
begin
  Result := Application.MessageBox(PChar(ARotulo), PChar(Application.Title), MB_YESNO + MB_ICONERROR + mb_DefButton2 + mb_applmodal) = idYes;
end;


end.
