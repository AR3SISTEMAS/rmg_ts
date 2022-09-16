unit ufrmViewProcessaLotePessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmModelo, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.BatchMove.Text, FireDAC.Comp.BatchMove.DataSet,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Comp.BatchMove, Vcl.ComCtrls;

type

  TProcessaPessoaThread = class(TThread)
  private
    Fflnatureza  : Integer;
    Fdsdocumento : string;
    Fnmprimeiro  : string;
    Fnmsegundo   : string;
    FCep         : string;
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TfrmViewProcessaLotePessoa = class(TfrmModelo)
    GroupBox1: TGroupBox;
    txtArquivo: TEdit;
    Label1: TLabel;
    btnAbrirArquivo: TButton;
    fmdCSVPessoas: TFDMemTable;
    fmdCSVPessoasflnatureza: TIntegerField;
    fmdCSVPessoasdsdocumento: TStringField;
    fmdCSVPessoasnmprimeiro: TStringField;
    fmdCSVPessoasnmsegundo: TStringField;
    fmdCSVPessoasdsCep: TStringField;
    dsPessoas: TDataSource;
    grdPessoas: TDBGrid;
    pnlBotoes: TPanel;
    Bevel1: TBevel;
    btnProcessar: TButton;
    pnlAndamento: TPanel;
    FDBatchMove: TFDBatchMove;
    pgbAndamento: TProgressBar;
    procedure btnProcessarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmViewProcessaLotePessoa: TfrmViewProcessaLotePessoa;

implementation

{$R *.dfm}

uses WK.Validate, ControllerPessoa, WK.Messages, ControllerEnderecoIntegracao;

procedure TfrmViewProcessaLotePessoa.btnProcessarClick(Sender: TObject);
var ProcessaPessoaThread : TProcessaPessoaThread;
    Pessoa : TPessoa;

  function AbrirCSVPessoas : Boolean;
  begin
    Result := True;
    fmdCSVPessoas.Close;
    fmdCSVPessoas.Open;
    with TFDBatchMoveTextReader.Create(FDBatchMove) do begin
      FileName := txtArquivo.Text;
      DataDef.Separator := ';';
      DataDef.WithFieldNames := True;
    end;

    with TFDBatchMoveDataSetWriter.Create(FDBatchMove) do begin
      DataSet := fmdCSVPessoas;
      Optimise := False;
    end;
    try
      FDBatchMove.GuessFormat;
      FDBatchMove.Execute;
    except
      Result := False;
    end;
  end;

begin

  btnProcessar.Enabled := False;
  pnlAndamento.Visible := True;
  pgbAndamento.Position := 0;
  try
    ValidaCondicaoLogica(FileExists(txtArquivo.Text) = False, 'Arquivo não encontrado');
    AbrirCSVPessoas();
      fmdCSVPessoas.First;
    fmdCSVPessoas.DisableControls;
    while not fmdCSVPessoas.Eof do
    begin
      Application.ProcessMessages;

      {ProcessaPessoaThread := TProcessaPessoaThread.Create;
      ProcessaPessoaThread.Fflnatureza  := fmdCSVPessoasflnatureza.AsInteger;
      ProcessaPessoaThread.Fdsdocumento := fmdCSVPessoasdsdocumento.AsString;
      ProcessaPessoaThread.Fnmprimeiro  := fmdCSVPessoasnmprimeiro.AsString;
      ProcessaPessoaThread.Fnmsegundo   := fmdCSVPessoasnmsegundo.AsString;
      ProcessaPessoaThread.FCep         := fmdCSVPessoasdsCep.AsString;
      ProcessaPessoaThread.Execute;}

      Pessoa := TPessoa.Create;
      Pessoa.idpessoa    := -1;
      Pessoa.flnatureza  := fmdCSVPessoasflnatureza.AsInteger;
      Pessoa.dsdocumento := fmdCSVPessoasdsdocumento.AsString;
      Pessoa.nmprimeiro  := fmdCSVPessoasnmprimeiro.AsString;
      Pessoa.nmsegundo   := fmdCSVPessoasnmsegundo.AsString;
      Pessoa.AdicionarCep(fmdCSVPessoasdsCep.AsString);
      Pessoa.GravarPessoa;
      Pessoa.GravarEnderecoIntegracao;
      Pessoa.Free;

      pgbAndamento.Position := fmdCSVPessoas.RecNo * 100 div fmdCSVPessoas.RecordCount;
      pgbAndamento.Repaint;
      fmdCSVPessoas.Next;
    end;

  finally
    btnProcessar.Enabled := True;
    fmdCSVPessoas.EnableControls;
    pnlAndamento.Visible := False;
  end;

end;

procedure TfrmViewProcessaLotePessoa.FormCreate(Sender: TObject);
begin
  inherited;
  txtArquivo.Text := ExtractFilePath(Application.ExeName) + 'assets\resources\pessoas_50000.csv';
end;

{ TProcessaPessoaThread }

constructor TProcessaPessoaThread.Create;
begin
  inherited Create(True);
  Fflnatureza  := -1;
  Fdsdocumento := '';
  Fnmprimeiro  := '';
  Fnmsegundo   := '';
  FCep         := '';
end;

destructor TProcessaPessoaThread.Destroy;
begin
  inherited;
end;

procedure TProcessaPessoaThread.Execute;
var Pessoa : TPessoa;
begin
  inherited;
  while not Terminated do
  begin
    Pessoa := TPessoa.Create;
    Pessoa.idpessoa    := -1;
    Pessoa.flnatureza  := Fflnatureza;
    Pessoa.dsdocumento := Fdsdocumento;
    Pessoa.nmprimeiro  := Fnmprimeiro;
    Pessoa.nmsegundo   := Fnmsegundo;
    Pessoa.AdicionarCep(FCep);
    Pessoa.GravarPessoa;
    Pessoa.GravarEnderecoIntegracao;
    Pessoa.Free;
  end;
end;

end.
