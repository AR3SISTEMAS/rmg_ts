unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmModelo, dxGDIPlusClasses,
  Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfrmMain = class(TfrmModelo)
    pnlBanner: TPanel;
    imgBanner: TImage;
    bvlAcoes: TBevel;
    btnCadastro: TButton;
    btnCadastroPessoasLote: TButton;
    lblInstrucoes: TLabel;
    lblInstrucoes2: TLabel;
    procedure btnCadastroClick(Sender: TObject);
    procedure btnCadastroPessoasLoteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses ufrmCadPessoa, ufrmViewProcessaLotePessoa;

procedure TfrmMain.btnCadastroClick(Sender: TObject);
Var frmCadPessoa : TfrmCadPessoa;
begin
  frmCadPessoa := TfrmCadPessoa.Create(nil);
  try
    frmCadPessoa.ShowModal;
  finally
    frmCadPessoa.Free;
  end;
end;

procedure TfrmMain.btnCadastroPessoasLoteClick(Sender: TObject);
Var frmViewProcessaLotePessoa : TfrmViewProcessaLotePessoa;
begin
  frmViewProcessaLotePessoa := TfrmViewProcessaLotePessoa.Create(nil);
  try
    frmViewProcessaLotePessoa.ShowModal;
  finally
    frmViewProcessaLotePessoa.Free;
  end;

end;

end.
