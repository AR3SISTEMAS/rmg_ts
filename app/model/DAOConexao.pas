unit DAOConexao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Forms,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, Vcl.StdCtrls, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, WK.Database;



type
  TConexao = class
  private
    FConn : TFDConnection;
    FDPhysPgDriverLink: TFDPhysPgDriverLink;
    FSessionID : Integer;
  public
    property  Conn : TFDConnection read FConn;
    constructor Create;
    constructor Destroy;
    function Conectar : Boolean;
    function Desconectar : Boolean;
    function ObterChavePrimaria (const ATabela, AColuna : string) : LongInt;
    function GetConexoes : Integer;
  end;


implementation

{ TConnection }

function TConexao.Conectar: Boolean;
begin
  FConn.Open();
  try
    Result := True;
  except
    Result := False;
  end;
end;

constructor TConexao.Create;
begin
  FConn := TFDConnection.Create(nil);
  FDPhysPgDriverLink := TFDPhysPgDriverLink.Create(nil);

  FConn.LoginPrompt     := False;
  FConn.DriverName      := 'PG';
  FConn.Params.Database := 'wk_bd_ts';
  FConn.Params.UserName := 'postgres';
  FConn.Params.Password := '123456';

  FDPhysPgDriverLink.VendorHome := ExtractFilePath(Application.ExeName) + 'vendor\dpg';

end;

function TConexao.Desconectar: Boolean;
begin
  FConn.Close;
end;

constructor TConexao.destroy;
begin
  Desconectar;
  if FConn <> nil then
    FConn.Free;
end;

function TConexao.GetConexoes: Integer;
begin
  Result := StrToIntDef(QuerySingleResult(FConn, 'SELECT count(*) AS NumConexoes FROM pg_stat_activity WHERE datname = ' + QuotedStr('wk_bd_ts')), -1);
end;

function TConexao.ObterChavePrimaria(const ATabela, AColuna: string): LongInt;
begin
  Result := StrToIntDef(QuerySingleResult(FConn, 'SELECT MAX(' + AColuna + ') FROM ' + ATabela), 0) + 1;
end;

end.
