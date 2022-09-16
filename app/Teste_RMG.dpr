program Teste_RMG;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  DAOConexao in 'model\DAOConexao.pas',
  ControllerPessoa in 'controller\ControllerPessoa.pas',
  ControllerEndereco in 'controller\ControllerEndereco.pas',
  WK.Messages in '..\framework\WK.Messages.pas',
  WK.DesignPatterns in '..\framework\WK.DesignPatterns.pas',
  WK.Database in '..\framework\WK.Database.pas',
  WK.Validate in '..\framework\WK.Validate.pas',
  WK.Forms in '..\framework\WK.Forms.pas',
  udmUI in 'view\udmUI.pas' {dmUI: TDataModule},
  WK.Strings in '..\framework\WK.Strings.pas',
  ControllerEnderecoIntegracao in 'controller\ControllerEnderecoIntegracao.pas',
  DAOEndereco in 'model\DAOEndereco.pas',
  DAOPessoa in 'model\DAOPessoa.pas',
  DAOEnderecoIntegracao in 'model\DAOEnderecoIntegracao.pas',
  ufrmModelo in 'view\Templates\ufrmModelo.pas' {frmModelo},
  uMain in 'view\uMain.pas' {frmMain},
  ufrmModeloCRUD in 'view\Templates\ufrmModeloCRUD.pas' {frmModeloCRUD},
  ufrmCadPessoa in 'view\ufrmCadPessoa.pas' {frmCadPessoa},
  ufrmViewProcessaLotePessoa in 'view\ufrmViewProcessaLotePessoa.pas' {frmViewProcessaLotePessoa},
  ControllerConexao in 'controller\ControllerConexao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'TESTE TECNICO - WK';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdmUI, dmUI);
  Application.CreateForm(TfrmViewProcessaLotePessoa, frmViewProcessaLotePessoa);
  Application.Run;
end.
