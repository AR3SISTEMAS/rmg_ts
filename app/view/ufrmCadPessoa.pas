unit ufrmCadPessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmModeloCRUD, Data.DB, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Mask, ControllerPessoa,
  Vcl.Menus;

type
  TfrmCadPessoa = class(TfrmModeloCRUD)
    grbCEPPessoa: TGroupBox;
    pnlCeps: TPanel;
    grdCep: TDBGrid;
    btnIncluirCEP: TButton;
    btnExcluirCEP: TButton;
    fmdTabPrincipalidpessoa: TIntegerField;
    fmdTabPrincipalflnatureza: TIntegerField;
    fmdTabPrincipaldsdocumento: TStringField;
    fmdTabPrincipalnmprimeiro: TStringField;
    fmdTabPrincipalnmsegundo: TStringField;
    fmdTabPrincipaldtregistro: TDateTimeField;
    grbPessoa: TGroupBox;
    lblId: TLabel;
    lblNome: TLabel;
    lblSobrenome: TLabel;
    lblDataRegistro: TLabel;
    tdbId: TDBEdit;
    tdbNome: TDBEdit;
    tdbSobrenome: TDBEdit;
    tdbDataRegistro: TDBEdit;
    grbNatureza: TGroupBox;
    lblDocumento: TLabel;
    tdbDocumento: TDBEdit;
    chkPessoaFisica: TRadioButton;
    chkPessoaJuridica: TRadioButton;
    lblAlertaRegistros: TLabel;
    fmdTabEndereco: TFDMemTable;
    dsTabEndereco: TDataSource;
    fmdTabEnderecoidendereco: TIntegerField;
    fmdTabEnderecoidpessoa: TIntegerField;
    fmdTabEnderecodscep: TStringField;
    procedure FormShow(Sender: TObject);
    procedure chkPessoaFisicaClick(Sender: TObject);
    procedure dbnAcaoClick(Sender: TObject; Button: TNavigateBtn);
    procedure tdbDocumentoKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirCEPClick(Sender: TObject);
    procedure dbnGravacaoBeforeAction(Sender: TObject; Button: TNavigateBtn);
    procedure dbnAcoesBeforeAction(Sender: TObject; Button: TNavigateBtn);
    procedure dbnAcoesClick(Sender: TObject; Button: TNavigateBtn);
    procedure btnPesquisarClick(Sender: TObject);
    procedure dsTabPrincipalStateChange(Sender: TObject);
    procedure btnExcluirCEPClick(Sender: TObject);
  private
    procedure ClickPesquisar(Sender: TObject);
    procedure ListaPessoas (AFiltro : string = '');
    procedure ConfiguraNaturezaPessoa;
  public
  end;

var
  frmCadPessoa: TfrmCadPessoa;

implementation

{$R *.dfm}

uses WK.Forms, WK.Validate, WK.Messages, WK.Strings;

procedure TfrmCadPessoa.btnExcluirCEPClick(Sender: TObject);
begin
  inherited;
  if fmdTabEndereco.RecordCount > 0 then
  begin
    if MsgBoxConfirmDefNo('Confirma a exclusão do CEP?') then
      fmdTabEndereco.Delete;
  end
  else
    btnExcluirCEP.Enabled := False;
end;

procedure TfrmCadPessoa.btnIncluirCEPClick(Sender: TObject);
Var lCep : string;
begin
  InputQuery('CEP', 'Digite', lCep);
  ValidaCondicaoLogica(ValidaCEP(lCep) = False, 'CEP inválido');
  ValidaCondicaoLogica(fmdTabEndereco.Locate('dsCep', RemoveCaracteresNaoNumericos(lCep), []) , 'CEP já cadastrado para esta pessoa');
  fmdTabEndereco.Append;
  fmdTabEnderecoidpessoa.AsInteger := fmdTabPrincipalidpessoa.AsInteger;
  fmdTabEnderecodscep.AsString := RemoveCaracteresNaoNumericos(lCep);
  fmdTabEndereco.Post;
end;

procedure TfrmCadPessoa.btnPesquisarClick(Sender: TObject);
Var lSQL : string;
begin
  ValidaCondicaoLogica(Length(txtPesquisar.Text) < 3, 'Informe pelo menos 3 caracteres para pesquisa');
  case ppmPesquisa.Tag of
   1 : lSQL := ' WHERE nmprimeiro Like  ' + QuotedStr('%' + txtPesquisar.Text + '%');
   2 : lSQL := ' WHERE dsDocumento Like ' + QuotedStr('%' + txtPesquisar.Text + '%');
  end;
  ListaPessoas(lSQL);
end;

procedure TfrmCadPessoa.chkPessoaFisicaClick(Sender: TObject);
begin
  ConfiguraNaturezaPessoa;
end;

procedure TfrmCadPessoa.ClickPesquisar(Sender: TObject);
Var I : Integer;
begin
  for I := 0 to ppmPesquisa.Items.Count - 1 do
    ppmPesquisa.Items[I].Checked := False;

  ppmPesquisa.Tag           := TMenuItem(Sender).Tag;
  TMenuItem(Sender).Checked := True;
  txtPesquisar.Text         := '';
  txtPesquisar.SetFocus;
end;

procedure TfrmCadPessoa.ConfiguraNaturezaPessoa;
begin
  lblDocumento.Caption   := '';
  tdbDocumento.MaxLength := 0;
  if chkPessoaFisica.Checked then
  begin
    tdbDocumento.MaxLength := 11;
    lblDocumento.Caption   := 'CPF';
  end;

  if chkPessoaJuridica.Checked then
  begin
    tdbDocumento.MaxLength := 14;
    lblDocumento.Caption   := 'CNPJ';
  end;
end;

procedure TfrmCadPessoa.dbnAcaoClick(Sender: TObject; Button: TNavigateBtn);
begin
  if Button in [nbInsert, nbEdit] then
    ConfiguraNaturezaPessoa;
end;

procedure TfrmCadPessoa.dbnAcoesBeforeAction(Sender: TObject;
  Button: TNavigateBtn);
var Pessoa : TPessoa;
begin
  inherited;

  if Button = nbDelete then
  begin
    if MsgBoxConfirmDefNo('Confirma a exclusão do registro?') then
    begin
      Pessoa := TPessoa.Create;
      Pessoa.ExcluiPessoa(fmdTabPrincipalidpessoa.AsInteger);
      Pessoa.Free;
    end
    else
      Abort;
  end;
end;

procedure TfrmCadPessoa.dbnAcoesClick(Sender: TObject; Button: TNavigateBtn);
var Pessoa : TPessoa;
         I : Integer;
begin
  inherited;

  if Button = nbInsert then
  begin
    chkPessoaFisica.Checked := False;
    chkPessoaJuridica.Checked := False;
    fmdTabPrincipal.Append;
    Exit;
  end;

  if Button = nbEdit then
  begin
    Pessoa := TPessoa.Create;
    Pessoa.LocalizaPessoa(fmdTabPrincipalidpessoa.AsInteger);
    case Pessoa.flnatureza of
      0 : chkPessoaFisica.Checked := True;
      1 : chkPessoaJuridica.Checked := True;
    end;
    ConfiguraNaturezaPessoa;

    fmdTabEndereco.Close;
    fmdTabEndereco.Open;

    for I := 0 to Pessoa.Enderecos.Count - 1 do
    begin
      fmdTabEndereco.Append;
      fmdTabEnderecoidendereco.AsInteger := Pessoa.Enderecos[I].idendereco;
      fmdTabEnderecodscep.AsString := Pessoa.Enderecos[I].dsCep;
      fmdTabEndereco.Post;
    end;
    Pessoa.Free;
  end;
end;

procedure TfrmCadPessoa.dbnGravacaoBeforeAction(Sender: TObject;
  Button: TNavigateBtn);
Var lMsg : string;
    Pessoa : TPessoa;
    lBkm : TBookmark;
begin

  if Button = nbPost then
  begin
    Pessoa := TPessoa.Create();

    if fmdTabPrincipal.State = dsInsert then
      Pessoa.idpessoa := -1
    else
      Pessoa.idpessoa := StrToInt(tdbId.Text);

    if chkPessoaFisica.Checked then
      Pessoa.flnatureza := 0;
    if chkPessoaJuridica.Checked then
      Pessoa.flnatureza := 1;

    Pessoa.dsdocumento := tdbDocumento.Text;
    Pessoa.nmprimeiro  := tdbNome.Text;
    Pessoa.nmsegundo   := tdbSobrenome.Text;
    Pessoa.dtregistro  := Date;

    lBkm := fmdTabEndereco.GetBookmark();
    fmdTabEndereco.DisableControls;
    try
      fmdTabEndereco.First;
      while not fmdTabEndereco.Eof do
      begin
        Pessoa.AdicionarCep(fmdTabEnderecodscep.AsString);
        fmdTabEndereco.Next;
      end;
    finally
      fmdTabEndereco.GotoBookmark(lBkm);
      fmdTabEndereco.FreeBookmark(lBkm);
      fmdTabEndereco.EnableControls;
    end;

    lMsg := Pessoa.ValidaPessoa;
    if lMsg <> '' then
    begin
      MsgBoxError(lMsg);
      Abort;
    end;

    if Pessoa.GravarPessoa then
    begin
      fmdTabPrincipalidpessoa.AsInteger := Pessoa.idpessoa;
      fmdTabPrincipaldtregistro.AsDateTime := Pessoa.dtregistro;

      fmdTabEndereco.Close;
      fmdTabEndereco.Open;
    end;

    Pessoa.Free;
  end;

  inherited;
end;

procedure TfrmCadPessoa.dsTabPrincipalStateChange(Sender: TObject);
begin
  inherited;
  btnExcluirCEP.Enabled := fmdTabEndereco.RecordCount > 0;
end;

procedure TfrmCadPessoa.FormShow(Sender: TObject);

  procedure AdicionarMenuPesquisa (const ACaptionMenu : string; const ATag : Integer; const APadrao : Boolean);
  Var lItem : TMenuItem;
  begin
    lItem := TMenuItem.Create(ppmPesquisa);
    lItem.Caption := ACaptionMenu;
    lItem.Tag := ATag;
    lItem.Checked := APadrao;
    lItem.OnClick := ClickPesquisar;
    ppmPesquisa.Items.Add(lItem);
  end;

begin
  inherited;
  fmdTabPrincipal.Active  := True;
  ListaPessoas('');
  AdicionarMenuPesquisa('Nome', 1, True);
  AdicionarMenuPesquisa('Documento', 2, False);
  ppmPesquisa.Items[0].Click;

end;

procedure TfrmCadPessoa.ListaPessoas(AFiltro: string);
Var lRegistros : Integer;
    Pessoa     : TPessoa;
begin
  fmdTabPrincipal.DisableControls;
  try
    Pessoa := TPessoa.Create;
    lblAlertaRegistros.Visible := False;
    lRegistros := Pessoa.QuantidadePessoasCadastradas;
    if (lRegistros > 50) and (AFiltro = '') then
      lblAlertaRegistros.Caption := 'Existem mais de [' + IntToStr(lRegistros) + '] registros no banco de dados, por favor, realiza uma pesquisa para prosseguir'
    else
      Pessoa.ListaPessoas(fmdTabPrincipal, AFiltro);
    Pessoa.Free;
  finally
      fmdTabPrincipal.EnableControls;
  end;
end;

procedure TfrmCadPessoa.tdbDocumentoKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9', #8, #9, #13]) then
    Key := #0;
end;

end.
