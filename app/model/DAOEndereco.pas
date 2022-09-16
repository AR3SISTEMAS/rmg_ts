unit DAOEndereco;

interface

uses DAOConexao, ControllerPessoa, ControllerEndereco, System.SysUtils,
     FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
     FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
     FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, Vcl.StdCtrls, Data.DB,
     FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
     FireDAC.DApt, FireDAC.Comp.DataSet, WK.Database, WK.Messages;

type
  TDAOEndereco = class
    private
      FConexao : TConexao;
    public
      constructor Create;
      destructor Destroy;
      function GravarEndereco (var APessoa : TPessoa) : Boolean;
  end;


implementation

{ TDAOEndereco }

constructor TDAOEndereco.Create;
begin
  FConexao := TConexao.Create();
  FConexao.Conectar;
end;

destructor TDAOEndereco.Destroy;
begin
  FConexao.Desconectar;
  FConexao.Free;
end;

function TDAOEndereco.GravarEndereco(var APessoa: TPessoa): Boolean;
var Query : TFDQuery;
    obj   : TEndereco;
begin
  ExecQuery(FConexao.Conn, 'DELETE FROM endereco WHERE idPessoa = ' + IntToStr(APessoa.idpessoa));
  Query := OpenQuery(FConexao.Conn, 'SELECT * FROM endereco WHERE idpessoa = ' + IntToStr(APessoa.idpessoa));
  try
    Result := True;
    for obj in APessoa.Enderecos do
    begin
      Query.Append;
      Query.FieldByName('idendereco').AsInteger := FConexao.ObterChavePrimaria('endereco', 'idendereco');
      Query.FieldByName('idpessoa').AsInteger := APessoa.idpessoa;
      Query.FieldByName('dscep').AsString := obj.dsCep;
      Query.Post;
    end;
  except
    Result := False;
  end;
  FConexao.Desconectar;
  Query.Free;
end;

end.
