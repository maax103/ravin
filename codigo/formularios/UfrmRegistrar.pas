unit UfrmRegistrar;
interface
uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  FireDAC.Phys.MySQLWrapper,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  UfrmBotaoPrimario,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  System.Actions, Vcl.ActnList, Vcl.ExtActns, Vcl.Mask, UPessoa, UUsuario,
  UpessoaDao;
type
  TfrmRegistrar = class(TForm)
    imgFundo: TImage;
    pnlRegistrar: TPanel;
    lblTituloRegistrar: TLabel;
    lblSubTituloRegistrar: TLabel;
    lblTituloAutenticar: TLabel;
    lblSubTituloAutenticar: TLabel;
    edtNome: TEdit;
    frmBotaoPrimarioRegistrar: TfrmBotaoPrimario;
    edtLogin: TEdit;
    edtSenha: TEdit;
    edtConfirmarSenha: TEdit;
    edtCpf: TMaskEdit;
    procedure lblSubTituloAutenticarClick(Sender: TObject);
    procedure frmBotaoPrimarioRegistrarspbBotaoPrimarioClick(Sender: TObject);
  private
    function criarUsuario : TUsuario;
    function criarPessoa  : TPessoa;
    { Private declarations }
  public
    { Public declarations }
  end;
var
  frmRegistrar: TfrmRegistrar;
implementation
uses
  UusuarioDao, UfrmLogin, UvalidaUsuario, UFormUtils;
{$R *.dfm}
function TfrmRegistrar.criarPessoa: TPessoa;
var
  Lpessoa : TPessoa;
begin
  Lpessoa := TPessoa.Create;
  Lpessoa.nome := edtNome.Text;
  Lpessoa.cpf  := TFormUtils.tirarMascara(edtCpf);

  Result := Lpessoa;
end;

function TfrmRegistrar.criarUsuario: TUsuario;
var
  Lusuario : Tusuario;
  LpessoaDao : TpessoaDao;
begin
  LpessoaDao := TPessoaDao.Create;
  Lusuario := Tusuario.Create;

  try
    Lusuario.PessoaId := LpessoaDao.buscarIdPorCPF(TFormUtils.tirarMascara(edtCpf));
  finally
    FreeAndNil(LpessoaDao);
  end;

  Lusuario.Login := edtLogin.Text;
  Lusuario.Senha := edtSenha.Text;
  Lusuario.Criadoem := Now();
  Lusuario.CriadoPor := 'admin';
  Lusuario.AlteradoEm := Now();
  Lusuario.AlteradoPor := 'admin';

  Result := Lusuario;
end;

procedure TfrmRegistrar.frmBotaoPrimarioRegistrarspbBotaoPrimarioClick
  (Sender: TObject);
var
  Lusuario: Tusuario;
  LusuarioDao: TUsuarioDAO;
  Lpessoa : TPessoa;
  LpessoaDao : TpessoaDao;
begin
  Lpessoa := criarPessoa;

  LpessoaDao := TPessoaDao.Create();
  LusuarioDao := TUsuarioDAO.Create();
  try
    try
      if not LpessoaDao.checarExistencia(TFormUtils.tirarMascara(edtCpf)) then
      begin
        LpessoaDao.inserirFuncionario(Lpessoa);
      end;

      Lusuario := criarUsuario;
      TValidadorUsuario.Validar(Lusuario, edtConfirmarSenha.Text);

      LusuarioDao.InserirUsuario(Lusuario);
      Vcl.Dialogs.MessageDlg
        ('Agora que você se cadastrou efetue o login com suas informações cadastradas',
        TMsgDlgType.mtConfirmation, [mbOk], 0, mbOk);
      lblSubTituloAutenticarClick(Sender);
    except
      on E: EMySQLNativeException do
      begin
        ShowMessage('Erro ao inserir o usuário no banco');
      end;
      on E: Exception do
      begin
        ShowMessage(E.Message);
      end;
    end;
  finally
    Lpessoa.Free;
    LpessoaDao.Free;
    LusuarioDao.Free;
    Lusuario.Free;
  end;
end;
procedure TfrmRegistrar.lblSubTituloAutenticarClick(Sender: TObject);
begin
  if not Assigned(frmLogin) then
  begin
    Application.CreateForm(TfrmLogin, frmLogin);
  end;
  TFormUtils.SetMainForm(frmLogin);
  frmLogin.Show();
  Close();
end;
end.
