unit WK.Forms;

interface

uses Windows, Vcl.Controls, Vcl.StdCtrls, Vcl.Forms, System.Classes;

procedure InicializaCampos (AParent : TWinControl);

implementation

procedure InicializaCampos (AParent : TWinControl);
var
  I: integer;
begin
  for i := 0 to AParent.ControlCount - 1 do
  begin
    if (AParent.Controls[i] is TEdit) then
      (AParent.Controls[i] as TEdit).Text := '';
    if (AParent.Controls[i] is TComboBox) then
      (AParent.Controls[i] as TComboBox).Text := '';
  end;
end;


end.
