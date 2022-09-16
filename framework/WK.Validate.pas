unit WK.Validate;

interface

uses System.SysUtils, WK.Messages, WK.Strings;

function ValidaCondicaoLogica (const ACondicao : Boolean; const AMsgErro : string) : Boolean;
function ValidaCEP(const ACEP: string): boolean;
function ValidaCPF(ACPF : string): boolean;
function ValidaCNPJ(ACNPJ : string): boolean;
function ValidaCNPJCPF(ACNPJCPF : string): boolean;

implementation

function ValidaCondicaoLogica (const ACondicao : Boolean; const AMsgErro : String) : Boolean;
begin
  Result := ACondicao;
  if Result then
  begin
    MsgBoxAlert(AMsgErro);
    Abort;
  end;
end;

function ValidaCEP(const ACEP: string): boolean;
begin
  Result := (Length(RemoveCaracteresNaoNumericos(ACEP)) = 8);
end;

function ValidaCPF(ACPF : string): boolean;
var
  i,d1,d2: integer;
  lAux: boolean;
begin
  ACPF := RemoveCaracteresNaoNumericos(ACPF);

  Result := false;
  if Length(ACPF) <> 11 then
    exit;

  lAux := true;
  d1 := 0;
  for i := 9 downto 1 do
  begin
    if ACPF[1] <> ACPF[i] then
      lAux := false;
    d1 := d1 + StrToInt(ACPF[i])*(11-i);
  end;
  d1 := 11 - (d1 mod 11);
  if d1 >= 10 then
    d1:=0;

  if lAux then
    exit;

  d2 := d1*2;
  for i := 9 downto 1 do
    d2 := d2 + StrToInt(ACPF[i])*(12-i);
  d2 := 11 - (d2 mod 11);
  if d2 >= 10 then
    d2 := 0;

  Result := ((d1 = StrToInt(ACPF[10])) and (d2 = StrToInt(ACPF[11])));
end;

//Valida CNPJ
function ValidaCNPJ(ACNPJ : string): boolean;
var
  i,j,k,d1: integer;
begin
  ACNPJ := RemoveCaracteresNaoNumericos(ACNPJ);

  Result := false;

  if Length(ACNPJ) <> 14 then
    exit;

  for j := 1 to 2 do
  begin
    k := 2;
    d1 := 0;
    for i := 12 + j - 1 downto 1 do
    begin
      d1 := d1 + strtoint(ACNPJ[i]) * k;
      inc(k);
      if (k > 9) then
        k := 2;
    end;
    d1 := 11 - d1 mod 11;
    if d1 >= 10 then
      d1 := 0;
    ACNPJ := ACNPJ + inttostr(d1);
  end;

  Result := (copy(ACNPJ,13,2) = copy(ACNPJ,15,2));
end;

function ValidaCNPJCPF(ACNPJCPF : string): boolean;
Var lValor : String;
begin
  Result := False;
  lValor := RemoveCaracteresNaoNumericos(ACNPJCPF);
  if lValor = '' then
  begin
    Result := True;
    Exit;
  end;

  if (Length(lValor) <> 11) and (Length(lValor) <> 14) then
    Exit;
  if (Length(lValor) = 11) then
    Result := ValidaCPF(lValor);
  if (Length(lValor) = 14) then
    Result := ValidaCNPJ(lValor);
end;


end.
