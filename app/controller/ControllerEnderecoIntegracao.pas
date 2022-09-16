unit ControllerEnderecoIntegracao;

interface

uses
  System.JSON, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Comp.Client, System.Classes,
  REST.Client, IPPeerClient, System.SysUtils;

type

 TEnderecoIntegracao = class
   private
    Fnmcidade: string;
    Fnmlogradouro: string;
    Fidendereco: Integer;
    Fnmbairro: string;
    Fdsuf: string;
    Fdscomplemento: string;
    procedure Setdscomplemento(const Value: string);
    procedure Setdsuf(const Value: string);
    procedure Setidendereco(const Value: Integer);
    procedure Setnmbairro(const Value: string);
    procedure Setnmcidade(const Value: string);
    procedure Setnmlogradouro(const Value: string);
   public
     property	idendereco : Integer read Fidendereco write Setidendereco;
     property	dsuf : string read Fdsuf write Setdsuf;
     property	nmcidade : string read Fnmcidade write Setnmcidade;
     property	nmbairro : string read Fnmbairro write Setnmbairro;
     property	nmlogradouro : string read Fnmlogradouro write Setnmlogradouro;
     property	dscomplemento : string read Fdscomplemento write Setdscomplemento;

     constructor Create;
     function GetCEP (const ACEP : string) : Boolean;
 end;


implementation

{ TEnderecoIntegracao }

constructor TEnderecoIntegracao.Create;
begin
  Fidendereco := -1;
  Fnmcidade := '';
  Fnmlogradouro := '';
  Fnmbairro := '';
  Fdsuf := '';
  Fdscomplemento := '';
end;

function TEnderecoIntegracao.GetCEP (const ACEP : string): Boolean;
var
  LJSON         : TJSONObject;
  LRESTClient   : TRESTClient;
  LRESTRequest  : TRESTRequest;
  LRESTResponse : TRESTResponse;
           LCEP : String;
begin
  Result := False;
  LRESTClient := TRESTClient.Create(nil);
  LRESTRequest := TRESTRequest.Create(nil);
  LRESTResponse := TRESTResponse.Create(nil);
  LRESTRequest.Client := LRESTClient;
  LRESTRequest.Response := LRESTResponse;
  LCEP := StringReplace(ACEP, '-', '', [rfReplaceAll]);
  LRESTClient.BaseURL := 'https://viacep.com.br/ws/' + LCEP + '/json';
  LRESTRequest.Execute;
  LJSON := LRESTResponse.JSONValue as TJSONObject;

  try
    if Assigned(LJSON) then
    begin
      Fnmlogradouro  := LJSON.Values['logradouro'].Value;
      Fnmbairro      := LJSON.Values['bairro'].Value;
      Fdsuf          := LJSON.Values['uf'].Value;
      Fnmcidade      := LJSON.Values['localidade'].Value;
      Fdscomplemento := LJSON.Values['complemento'].Value;
    end;
  finally
    FreeAndNil(LJSON);
  end;
  Result := True;
end;

procedure TEnderecoIntegracao.Setdscomplemento(const Value: string);
begin
  Fdscomplemento := Value;
end;

procedure TEnderecoIntegracao.Setdsuf(const Value: string);
begin
  Fdsuf := Value;
end;

procedure TEnderecoIntegracao.Setidendereco(const Value: Integer);
begin
  Fidendereco := Value;
end;

procedure TEnderecoIntegracao.Setnmbairro(const Value: string);
begin
  Fnmbairro := Value;
end;

procedure TEnderecoIntegracao.Setnmcidade(const Value: string);
begin
  Fnmcidade := Value;
end;

procedure TEnderecoIntegracao.Setnmlogradouro(const Value: string);
begin
  Fnmlogradouro := Value;
end;

end.
