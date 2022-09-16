unit DAOEnderecoIntegracao;

interface

uses DAOConexao, ControllerEnderecoIntegracao, System.SysUtils,
     FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
     FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
     FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, Vcl.StdCtrls, Data.DB,
     FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
     FireDAC.DApt, FireDAC.Comp.DataSet, WK.Database, WK.Messages;

type
    TDAOEnderecoIntegracao = class
    private
      FConexao : TConexao;
    public
      constructor Create;
      destructor Destroy;
      function GravarEnderecoIntegracao (const Aidpessoa : Integer) : Boolean;
  end;

implementation

{ TDAOEnderecoIntegracao }

uses WK.Strings;

constructor TDAOEnderecoIntegracao.Create;
begin
  FConexao := TConexao.Create();
  FConexao.Conectar;
end;

destructor TDAOEnderecoIntegracao.Destroy;
begin
  FConexao.Desconectar;
  FConexao.Free;
end;

function TDAOEnderecoIntegracao.GravarEnderecoIntegracao(const Aidpessoa : Integer): Boolean;
var Query : TFDQuery;
    QueryEndereco : TFDQuery;
    EnderecoIntegracao : TEnderecoIntegracao;
begin
  ExecQuery(FConexao.Conn, 'DELETE FROM endereco_integracao WHERE idendereco IN (SELECT idendereco FROM endereco WHERE idPessoa = ' + IntToStr(Aidpessoa) + ')');
  Query := OpenQuery(FConexao.Conn, 'SELECT * FROM endereco_integracao WHERE 1 = 2');
  QueryEndereco := OpenQuery(FConexao.Conn, 'SELECT * FROM endereco WHERE idpessoa = ' + IntToStr(Aidpessoa));
  try
    Result := True;
    while not QueryEndereco.Eof do
    begin
      EnderecoIntegracao := TEnderecoIntegracao.Create;
      if EnderecoIntegracao.GetCEP(CompletarComZerosAEsquerda(QueryEndereco.FieldByName('dsCEP').AsString, 8)) then
      begin
        Query.Append;
        Query.FieldByName('idendereco').AsInteger   := QueryEndereco.FieldByName('idendereco').AsInteger;
        Query.FieldByName('dsuf').AsString          := EnderecoIntegracao.dsuf;
        Query.FieldByName('nmcidade').AsString      := EnderecoIntegracao.nmcidade;
        Query.FieldByName('nmbairro').AsString      := EnderecoIntegracao.nmbairro;
        Query.FieldByName('nmlogradouro').AsString  := EnderecoIntegracao.nmlogradouro;
        Query.FieldByName('dscomplemento').AsString := EnderecoIntegracao.dscomplemento;
        Query.Post;
      end;
      EnderecoIntegracao.Free;
      QueryEndereco.Next;
    end;
  except
    Result := False;
  end;
  Query.Free;
  QueryEndereco.Free;
end;

end.
