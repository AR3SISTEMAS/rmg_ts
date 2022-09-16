unit DAOPessoa;

interface

uses DAOConexao, System.SysUtils, ControllerPessoa,
     FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
     FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
     FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, Vcl.StdCtrls, Data.DB,
     FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
     FireDAC.DApt, FireDAC.Comp.DataSet, WK.Database;

type
  TDAOPessoa = class
    private
      FConexao : TConexao;
    public
      constructor Create;
      destructor Destroy;
      function GravarPessoa (var APessoa : TPessoa) : Boolean;
      function GravarEnderecoIntegracao (const Aidpessoa : Integer) : Boolean;
      function LocalizaPessoa (var APessoa : TPessoa; const Aidpessoa : Integer) : Boolean;
      function ExcluiPessoa (const Aidpessoa : Integer) : Boolean;
      function QuantidadePessoasCadastradas : Integer;
      procedure ListaPessoas(var AFDMemTable: TFDMemTable; const AFiltro : string = '' );
  end;


implementation

{ TDAOPessoa }

uses DAOEndereco, DAOEnderecoIntegracao;

constructor TDAOPessoa.create;
begin
  FConexao := TConexao.Create();
  FConexao.Conectar;
end;

destructor TDAOPessoa.destroy;
begin
  FConexao.Desconectar;
  FConexao.Free;
end;

function TDAOPessoa.ExcluiPessoa(const Aidpessoa: Integer): Boolean;
begin
  try
    Result := True;
    ExecQuery(FConexao.Conn, 'DELETE FROM endereco_integracao WHERE idendereco IN (SELECT idendereco FROM endereco WHERE idPessoa = ' + IntToStr(Aidpessoa) + ')');
    ExecQuery(FConexao.Conn, 'DELETE FROM endereco WHERE idPessoa = ' + IntToStr(Aidpessoa));
    ExecQuery(FConexao.Conn, 'DELETE FROM pessoa WHERE idPessoa = ' + IntToStr(Aidpessoa));
  finally
    Result := False;
  end;
end;

function TDAOPessoa.GravarEnderecoIntegracao(const Aidpessoa: Integer): Boolean;
Var EnderecoIntegracao : TDAOEnderecoIntegracao;
begin
  EnderecoIntegracao := TDAOEnderecoIntegracao.Create;
  EnderecoIntegracao.GravarEnderecoIntegracao(Aidpessoa);
  EnderecoIntegracao.Free;
end;

function TDAOPessoa.GravarPessoa(var APessoa: TPessoa): Boolean;
var Query : TFDQuery;
    Endereco : TDAOEndereco;
begin
  if APessoa.idpessoa = -1 then
  begin
    APessoa.idpessoa := FConexao.ObterChavePrimaria('pessoa', 'idpessoa');
    Query := OpenQuery(FConexao.Conn, 'SELECT * FROM pessoa WHERE idpessoa = -1');
    Query.Append;
    Query.FieldByName('idpessoa').AsInteger := APessoa.idpessoa;
  end
  else
  begin
    Query := OpenQuery(FConexao.Conn, 'SELECT * FROM pessoa WHERE idpessoa = ' + IntToStr(APessoa.idpessoa));
    Query.Edit;
  end;
  Query.FieldByName('flnatureza').AsInteger := APessoa.flnatureza;
  Query.FieldByName('dsdocumento').AsString := APessoa.dsdocumento;
  Query.FieldByName('nmprimeiro').AsString := APessoa.nmprimeiro;
  Query.FieldByName('nmsegundo').AsString := APessoa.nmsegundo;
  Query.FieldByName('dtregistro').AsDateTime := Now();
  try
    Query.Post;
    Endereco := TDAOEndereco.Create;
    Endereco.GravarEndereco(APessoa);
    Endereco.Free;
    Result := True;
  except
    Result := False;
  end;
  Query.Free;
end;

procedure TDAOPessoa.ListaPessoas(var AFDMemTable: TFDMemTable; const AFiltro : string);
var Query : TFDQuery;
begin
  AFDMemTable.Close;
  AFDMemTable.Open;

  Query := OpenQuery(FConexao.Conn, 'SELECT * FROM pessoa ' + AFiltro);
  while not Query.Eof do
  begin
    AFDMemTable.Append;
    AFDMemTable.FieldByName('idpessoa').AsInteger    :=  Query.FieldByName('idpessoa').AsInteger;
    AFDMemTable.FieldByName('flnatureza').AsInteger  :=  Query.FieldByName('flnatureza').AsInteger;
    AFDMemTable.FieldByName('dsdocumento').AsString  :=  Query.FieldByName('dsdocumento').AsString;
    AFDMemTable.FieldByName('nmprimeiro').AsString   :=  Query.FieldByName('nmprimeiro').AsString;
    AFDMemTable.FieldByName('nmsegundo').AsString    :=  Query.FieldByName('nmsegundo').AsString;
    AFDMemTable.FieldByName('dtregistro').AsDateTime :=  Query.FieldByName('dtregistro').AsDateTime;
    AFDMemTable.Post;
    Query.Next;
  end;
  Query.Free;

end;


function TDAOPessoa.LocalizaPessoa(var APessoa: TPessoa; const Aidpessoa: Integer): Boolean;
var Query : TFDQuery;
    QueryEndereco : TFDQuery;
begin
  Query := OpenQuery(FConexao.Conn, 'SELECT * FROM pessoa WHERE idpessoa = ' + IntToStr(Aidpessoa));
  QueryEndereco := OpenQuery(FConexao.Conn, 'SELECT * FROM endereco WHERE idpessoa = ' + IntToStr(Aidpessoa));
  try
    APessoa.idpessoa := Query.FieldByName('idpessoa').AsInteger;
    APessoa.flnatureza := Query.FieldByName('flnatureza').AsInteger;
    APessoa.dsdocumento := Query.FieldByName('dsdocumento').AsString;
    APessoa.nmprimeiro := Query.FieldByName('nmprimeiro').AsString;
    APessoa.nmsegundo := Query.FieldByName('nmsegundo').AsString;
    APessoa.dtregistro := Query.FieldByName('dtregistro').AsDateTime;
    while not QueryEndereco.Eof do
    begin
      APessoa.AdicionarCep(QueryEndereco.FieldByName('dsCep').AsString, QueryEndereco.FieldByName('idendereco').AsInteger);
      QueryEndereco.Next;
    end;
  finally
    Query.Free;
    QueryEndereco.Free;
  end;
end;

function TDAOPessoa.QuantidadePessoasCadastradas : Integer;
begin
  Result := StrToIntDef(QuerySingleResult(FConexao.Conn, 'SELECT COUNT(*) AS TotalPessoas FROM pessoa'), 0);
end;

end.
