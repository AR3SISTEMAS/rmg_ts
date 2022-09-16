unit WK.Database;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Forms,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, Vcl.StdCtrls, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, WK.Messages;


  function OpenQuery(const AConn: TFDConnection; const ASQL: string): TFDQuery;
  function QuerySingleResult(const AConn: TFDConnection; const ASQL: string): string;
  function ExecQuery(const AConn: TFDConnection; const ASQL: string): Integer;

implementation

function OpenQuery(const AConn: TFDConnection; const ASQL: String): TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  try
    Result.Connection := AConn;
    Result.SQL.Add(ASQL);
    Result.Open;
  except
  on E: Exception do
    begin
      MsgBoxError('Erro ao criar a consulta SQL!' + #13 + E.message + #13 +#13 + ASQL);
      Result.Free;
    end;
  end;
end;

function QuerySingleResult(const AConn: TFDConnection; const ASQL: string): String;
Var lQuery : TFDQuery;
begin
  lQuery := OpenQuery(AConn, ASQL);
  try
    Result := lQuery.Fields[0].AsString;
  finally
    lQuery.Free;
  end;
end;

function ExecQuery(const AConn: TFDConnection; const ASQL: string): Integer;
Var
  lQuery : TFDQuery;
begin
  result := 0;
  lQuery := TFDQuery.Create(nil);
  try
    with lQuery do
    begin
      Connection := AConn;
      SQL.Add(ASQL);
      ExecSQL;
      result := RowsAffected;
    end;
  lQuery.Free;
  except
    on e : Exception do
      MsgBoxError('Erro ao tentar executar a instrução ' + #13 + e.Message + #13#13 + ASQL );
  end;
end;


end.
