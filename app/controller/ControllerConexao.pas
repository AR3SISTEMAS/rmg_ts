unit ControllerConexao;

interface

uses DAOConexao, System.SysUtils,
     FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
     FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
     FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, Vcl.StdCtrls, Data.DB,
     FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
     FireDAC.DApt, FireDAC.Comp.DataSet, WK.Database, WK.Messages;

type
  TCConexao = class
  private
  public
    function ObterNumeroConexoesAtivas : Integer;
  end;

implementation

{ TCConexao }

function TCConexao.ObterNumeroConexoesAtivas: Integer;
var DAOConexao : TConexao;
begin
  DAOConexao := TConexao.Create;
  Result := DAOConexao.GetConexoes;
  DAOConexao.Desconectar;
  DAOConexao.Free;
end;

end.
