unit ufrmModeloCRUD;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmModelo, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.DBCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, Buttons,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Menus;

type
  TDBNewNavigator = class (TDBNavigator);
  TfrmModeloCRUD = class(TfrmModelo)
    pgcPrincipal: TPageControl;
    tbsListaRegistros: TTabSheet;
    tbsRegistro: TTabSheet;
    pnlNavegacao: TPanel;
    grdPesquisa: TDBGrid;
    pnlCabecalhoPesquisa: TPanel;
    txtPesquisar: TEdit;
    btnPesquisar: TButton;
    dsTabPrincipal: TDataSource;
    dbnNavegacao: TDBNavigator;
    fmdTabPrincipal: TFDMemTable;
    pnlGravacao: TPanel;
    dbnGravacao: TDBNavigator;
    dbnAcoes: TDBNavigator;
    ppmPesquisa: TPopupMenu;
    procedure dsTabPrincipalStateChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbnGravacaoBeforeAction(Sender: TObject; Button: TNavigateBtn);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmModeloCRUD: TfrmModeloCRUD;

implementation

{$R *.dfm}

uses WK.Messages, WK.Validate;

procedure TfrmModeloCRUD.dbnGravacaoBeforeAction(Sender: TObject;
  Button: TNavigateBtn);
begin
  if Button = nbCancel then
    if MsgBoxConfirmDefNo('Tem certeza que deseja cancelar esta operação? Todos os dados serão perdidos!') = False then
      Abort;
end;

procedure TfrmModeloCRUD.dsTabPrincipalStateChange(Sender: TObject);
begin
  if dsTabPrincipal.State in [dsInsert, dsEdit] then
  begin
    tbsRegistro.TabVisible := True;
    tbsListaRegistros.TabVisible := False;
    pgcPrincipal.ActivePage := tbsRegistro;

    if dsTabPrincipal.State = dsInsert then
      tbsRegistro.Caption := 'Incluindo...'
    else
      tbsRegistro.Caption := 'Editando...';
  end
  else
  begin
    tbsRegistro.TabVisible := False;
    tbsListaRegistros.TabVisible := True;
    pgcPrincipal.ActivePage := tbsListaRegistros;
  end;

end;

procedure TfrmModeloCRUD.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := not(ValidaCondicaoLogica(fmdTabPrincipal.State in [dsInsert, dsEdit], 'O cadastro está em modo de inserção ou edição. ' + #13 + #13 + 'Clique no botão cancelar para desfazer este status'));
end;

procedure TfrmModeloCRUD.FormCreate(Sender: TObject);

  procedure ConfiguraDBNavigator (var ADBNavigator : TDBNavigator);
  var
    Navigator : TNavigateBtn;
  begin
    for Navigator := Low(TNavigateBtn) to High(TNavigateBtn) do
    with TDBNewNavigator(ADBNavigator).Buttons[Navigator] do
    begin
      case Index of
        nbInsert : Caption := 'Novo';
        nbDelete : Caption := 'Excluir';
        nbEdit : Caption := 'Editar';
        nbPost : Caption := 'Salvar';
        nbCancel : Caption := 'Cancelar';
      end;
      Hint := Caption;
      ShowHint := True;
    end;
  end;


begin
  inherited;
  pgcPrincipal.ActivePage := tbsListaRegistros;
  tbsRegistro.TabVisible  := False;
  ConfiguraDBNavigator(dbnAcoes);
  ConfiguraDBNavigator(dbnGravacao);
end;

end.
