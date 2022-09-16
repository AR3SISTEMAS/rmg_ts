unit ControllerPessoa;

interface

uses Classes, SysUtils, generics.collections, ControllerEndereco,
     FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
     FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
     FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TPessoa = class
  private
    Fnmprimeiro: string;
    Fdtregistro: TDateTime;
    Fnmsegundo: string;
    Fdsdocumento: string;
    Fidpessoa: Integer;
    Fflnatureza: Integer;
    FEnderecos : TObjectList<TEndereco>;
    procedure Setdsdocumento(const Value: string);
    procedure Setdtregistro(const Value: TDateTime);
    procedure Setflnatureza(const Value: Integer);
    procedure Setnmprimeiro(const Value: string);
    procedure Setnmsegundo(const Value: string);
    procedure Setidpessoa(const Value: Integer);
    procedure InicializaPessoa;
  public
    property Enderecos   : TObjectList<TEndereco> read FEnderecos;
    property idpessoa    : Integer read Fidpessoa write Setidpessoa;
    property flnatureza  : Integer read Fflnatureza write Setflnatureza;
    property dsdocumento : string read Fdsdocumento write Setdsdocumento;
    property nmprimeiro  : string read Fnmprimeiro write Setnmprimeiro;
    property nmsegundo   : string read Fnmsegundo write Setnmsegundo;
    property dtregistro  : TDateTime read Fdtregistro write Setdtregistro;

    constructor Create;
    destructor Destroy;

    procedure AdicionarCep (const ACep : string; const Aidendereco : Integer = -1);
    procedure DeletarCep (const ACep : string);

    function GravarPessoa : Boolean;
    function GravarEnderecoIntegracao : Boolean;
    function ValidaPessoa : string;
    function  ExcluiPessoa (const Aidpessoa : Integer) : Boolean;
    function LocalizaPessoa (const Aidpessoa : Integer) : Boolean;
    procedure ListaPessoas (var AFDMemTable : TFDMemTable; const AFiltro : string = '');
    function QuantidadePessoasCadastradas : Integer;

  end;

implementation

uses
  DAOPessoa, WK.Validate, DAOEnderecoIntegracao;

{ TPessoa }

constructor TPessoa.Create;
begin
  FEnderecos := TObjectList<TEndereco>.Create();
  InicializaPessoa;
end;

procedure TPessoa.AdicionarCep(const ACep: string; const Aidendereco : Integer);
Var obj : TEndereco;
begin
  obj := TEndereco.Create;
  obj.idpessoa := Fidpessoa;
  obj.dsCep := ACep;
  if Aidendereco > -1 then
    obj.idendereco := Aidendereco;
  FEnderecos.Add(obj);
end;

procedure TPessoa.DeletarCep(const ACep: string);
Var obj : TEndereco;
begin
  for obj in FEnderecos do
    if obj.dsCep = ACep  then
      obj.Free;
end;

destructor TPessoa.Destroy;
begin
  if FEnderecos <> nil then
    FreeAndNil(FEnderecos);
end;

function TPessoa.ExcluiPessoa(const Aidpessoa: Integer): Boolean;
var DAOPessoa : TDAOPessoa;
begin
  DAOPessoa := TDAOPessoa.Create;
  try
    DAOPessoa.ExcluiPessoa(Aidpessoa);
  finally
    DAOPessoa.Free;
  end;
end;

procedure TPessoa.Setdsdocumento(const Value: string);
begin
  Fdsdocumento := Value;
end;

procedure TPessoa.Setdtregistro(const Value: TDateTime);
begin
  Fdtregistro := Value;
end;

procedure TPessoa.Setflnatureza(const Value: Integer);
begin
  Fflnatureza := Value;
end;

procedure TPessoa.Setidpessoa(const Value: Integer);
begin
  Fidpessoa := Value;
end;

procedure TPessoa.Setnmprimeiro(const Value: string);
begin
  Fnmprimeiro := Value;
end;

procedure TPessoa.Setnmsegundo(const Value: string);
begin
  Fnmsegundo := Value;
end;


function TPessoa.ValidaPessoa: string;
begin
  Result := '';
  if (Fflnatureza <> 0) and (Fflnatureza <> 1) then
  begin
    Result := 'Natureza não preenchida';
    Exit;
  end;
  if (ValidaCNPJCPF(Fdsdocumento) = False) or (Length(Fdsdocumento) < 11) then
  begin
    Result := 'Documento inválido';
    Exit;
  end;
  if Fnmprimeiro = '' then
  begin
    Result := 'Nome não preenchido';
    Exit;
  end;
  if Fnmsegundo = '' then
  begin
    Result := 'Sobrenome não preenchido';
    Exit;
  end;
  if FEnderecos.Count = 0 then
  begin
    Result := 'Nenhum CEP informado';
    Exit;
  end;
end;

procedure TPessoa.ListaPessoas(var AFDMemTable: TFDMemTable; const AFiltro : string);
Var DAOPessoa : TDAOPessoa;
begin
  DAOPessoa := TDAOPessoa.Create;
  try
    DAOPessoa.ListaPessoas(AFDMemTable, AFiltro);
  finally
    DAOPessoa.Free;
  end;
end;

function TPessoa.LocalizaPessoa(const Aidpessoa: Integer): Boolean;
Var DAOPessoa : TDAOPessoa;
begin
  DAOPessoa := TDAOPessoa.Create;
  DAOPessoa.LocalizaPessoa(Self, Aidpessoa);
  DAOPessoa.Free;
end;

function TPessoa.QuantidadePessoasCadastradas: Integer;
Var DAOPessoa : TDAOPessoa;
begin
  DAOPessoa := TDAOPessoa.Create;
  try
    Result := DAOPessoa.QuantidadePessoasCadastradas;
  finally
    DAOPessoa.Free;
  end;
end;

function TPessoa.GravarEnderecoIntegracao: Boolean;
Var DAOEnderecoIntegracao : TDAOEnderecoIntegracao;
begin
  DAOEnderecoIntegracao := TDAOEnderecoIntegracao.Create;
  DAOEnderecoIntegracao.GravarEnderecoIntegracao(Fidpessoa);
  DAOEnderecoIntegracao.Free;
end;

function TPessoa.GravarPessoa: Boolean;
var DAOPessoa : TDAOPessoa;
begin
  DAOPessoa := TDAOPessoa.Create;
  Result := DAOPessoa.GravarPessoa(Self);
  DAOPessoa.Free;
end;


procedure TPessoa.InicializaPessoa;
begin
  idpessoa    := -1;
  flnatureza  := -1;
  dsdocumento := '';
  nmprimeiro  := '';
  nmsegundo   := '';
  Fdtregistro := -1;
  while FEnderecos.Count > 0 do
    FEnderecos[0].Free;
end;

end.
