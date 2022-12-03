program Ravin;

uses
  Vcl.Forms,
  UfrmCartaoPainelGestao in '..\codigo\frames\UfrmCartaoPainelGestao.pas' {frmCartaoPainelControle: TFrame},
  UfrmLogomarca in '..\codigo\frames\UfrmLogomarca.pas' {frmLogo: TFrame},
  UfrmItemMenu in '..\codigo\frames\UfrmItemMenu.pas' {frmMenuItem: TFrame},
  UdmRavin in '..\codigo\database\UdmRavin.pas' {dmRavin: TDataModule},
  UfrmSplash in '..\codigo\formularios\UfrmSplash.pas' {frmSplash},
  UfrmMesas in '..\codigo\formularios\UfrmMesas.pas' {frmMesas},
  UfrmSobre in '..\codigo\formularios\UfrmSobre.pas' {frmSobre},
  UfrmProdutos in '..\codigo\formularios\UfrmProdutos.pas' {frmProdutos},
  UfrmPainelGestao in '..\codigo\formularios\UfrmPainelGestao.pas' {frmPainelGestao},
  UfrmComandas in '..\codigo\formularios\UfrmComandas.pas' {frmComandas},
  UResourceUtils in '..\codigo\util\UResourceUtils.pas',
  UfrmLogin in '..\codigo\formularios\UfrmLogin.pas' {frmLogin},
  UfrmBotaoSubmit in '..\codigo\frames\UfrmBotaoSubmit.pas' {Frame1: TFrame},
  Uusuario in '..\codigo\modelo\Uusuario.pas',
  UusuarioDao in '..\codigo\dao\UusuarioDao.pas',
  UfrmBotaoSecundario in '..\codigo\frames\UfrmBotaoSecundario.pas' {frmBotaoSecundario: TFrame},
  UfrmBotaoPrimario in '..\codigo\frames\UfrmBotaoPrimario.pas' {frmBotaoPrimario: TFrame},
  UfrmRegistrar in '..\codigo\formularios\UfrmRegistrar.pas' {frmRegistrar},
  UpessoaDao in '..\codigo\dao\UpessoaDao.pas',
  UvalidaUsuario in '..\codigo\validadores\UvalidaUsuario.pas',
  UiniUtils in '..\codigo\util\UiniUtils.pas',
  UFormUtils in '..\codigo\util\UFormUtils.pas',
  UPessoa in '..\codigo\modelo\UPessoa.pas',
  UfrmBotaoCancelar in '..\codigo\frames\UfrmBotaoCancelar.pas' {frmBotaoCancelar: TFrame},
  UfrmBotaoExcluir in '..\codigo\frames\UfrmBotaoExcluir.pas' {frmBotaoExcluir: TFrame},
  UfrmCadastroCliente in '..\codigo\formularios\UfrmCadastroCliente.pas' {frmCadastroCliente},
  UfrmListaClientes in '..\codigo\formularios\UfrmListaClientes.pas' {frmListaClientes},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  ReportMemoryLeaksOnShutdown := True;
  Application.CreateForm(TfrmSplash, frmSplash);
  Application.CreateForm(TdmRavin, dmRavin);
  Application.Run;
end.
