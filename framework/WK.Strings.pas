unit WK.Strings;

interface

function RemoveCaracteresNaoNumericos(const ATexto : string): string;
function CompletarComZerosAEsquerda (const AValor : String; const ATamanho : Integer) : String;

implementation

function RemoveCaracteresNaoNumericos(const ATexto : string): string;
var
  i: integer;
  lStr: string;
begin
  lStr := '';
  if ATexto <> '' then
    for i := 0 to Length(ATexto) do
      if ATexto[i] in ['0'..'9'] then
        lStr := lStr + ATexto[i];
  Result := lStr;
end;

function CompletarComZerosAEsquerda (const AValor : String; const ATamanho : Integer) : String;
Var I : Integer;
begin
  Result := AValor;

  if Length(AValor) >= ATamanho then
    Exit;

  for I := 0 to (ATamanho - Length(AValor) -1) do
    Result := '0' + Result;
end;

end.
